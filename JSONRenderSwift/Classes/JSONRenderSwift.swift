//
//  JSONRenderSwift.swift
//
//  Created by Adoma on 2019/12/20.
//  Copyright © 2019 ad0ma. All rights reserved.
//

import UIKit

//systemFont/boldSystemFont
let kJSONFont = UIFont.boldSystemFont(ofSize: 14)

let kJSONKeyColor = UIColor.init(red: 146/255.0, green: 39/255.0, blue: 143/255.0, alpha: 1)
let kJSONIndexColor = UIColor.init(red: 25/255.0, green: 25/255.0, blue: 112/255.0, alpha: 1)
let kJSONSymbolColor = UIColor.init(red: 74/255.0, green: 85/255.0, blue: 96/255.0, alpha: 1)

let kJSONNullValueColor = UIColor.init(red: 241/255.0, green: 89/255.0, blue: 42/255.0, alpha: 1)
let kJSONBoolValueColor = UIColor.init(red: 249/255.0, green: 130/255.0, blue: 128/255.0, alpha: 1)
let kJSONNumberValueColor = UIColor.init(red: 37/255.0, green: 170/255.0, blue: 226/255.0, alpha: 1)
let kJSONStringValueColor = UIColor.init(red: 58/255.0, green: 181/255.0, blue: 74/255.0, alpha: 1)

extension NSAttributedString {
    
    convenience init(string: String, font: UIFont = kJSONFont, color: UIColor , style: NSParagraphStyle? = nil) {
        var attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: color]
        if let style = style {
            attributes[NSAttributedString.Key.paragraphStyle] = style
        }
        self.init(string: string, attributes: attributes)
    }
}

extension NSMutableAttributedString {
    
    @objc public func append(_ element: Any?) {
        return append(element: element, level: 0, ext: 0)
    }
    
    private func append(element: Any?, level: Int, ext: CGFloat) {
        
        guard let element = element, element is NSNull == false else {
            append(NSAttributedString.init(string: "null", color: kJSONNullValueColor))
            return
        }
        
        switch element {
        case let dic as [String: Any]:
            append(attributedString(dic: dic, level: level, ext: ext))
        case let arr as [Any]:
            append(attributedString(arr: arr, level: level, ext: ext))
        case let bool as Bool:
            append(NSAttributedString.init(string: bool ? "true":"false", color: kJSONBoolValueColor))
        case let number as NSNumber:
            var string = "\(number)"
            if number.objCType.pointee == 100 {
                string = (Decimal.init(string: String.init(format: "%f", number.doubleValue))! as NSDecimalNumber).stringValue
            }
            append(NSAttributedString.init(string: string, color: kJSONNumberValueColor))
        case let string as String:
            append(NSAttributedString.init(string: "\"" + string + "\"", color: kJSONStringValueColor))
        default:
            append(NSAttributedString.init(string: "\(element)", color: kJSONStringValueColor))
        }
    }
    
    private func attributedString(dic: [String: Any], level: Int, ext: CGFloat) -> NSMutableAttributedString {
        
        let headPara = NSMutableParagraphStyle()
        headPara.firstLineHeadIndent = CGFloat(level * 10)
        
        let mattr = NSMutableAttributedString.init(string: "{", color: kJSONSymbolColor, style: headPara)
        
        if (dic.isEmpty == false) {
            mattr.append(NSAttributedString.init(string: "\n"))
        }
        
        for (idx, element) in dic.enumerated() {
            
            let key = "\"" + element.key + "\""
            
            let width = (key as NSString).boundingRect(with: CGSize.init(width: CGFloat.infinity, height: kJSONFont.lineHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: kJSONFont], context: nil).size.width + 10
            
            let para = NSMutableParagraphStyle()
            para.firstLineHeadIndent = CGFloat((level + 1) * 10) + ext
            para.headIndent = CGFloat(level * 10) + width + ext + 5
            
            mattr.append(NSAttributedString.init(string: key, color: kJSONKeyColor, style: para))
            
            mattr.append(NSAttributedString.init(string: ":", color: kJSONSymbolColor))
            
            mattr.append(element: element.value, level: level + 1, ext: width + ext)
            
            if idx != dic.count - 1 {
                mattr.append(NSAttributedString.init(string: ",", color: kJSONSymbolColor))
            }
            mattr.append(NSAttributedString.init(string: "\n"))
        }
        
        let tailPara = NSMutableParagraphStyle()
        tailPara.firstLineHeadIndent = CGFloat(level * 10) + ext
        
        mattr.append(NSAttributedString.init(string: "}", color: kJSONSymbolColor, style: tailPara))
        
        return mattr
    }
    
    private func attributedString(arr: [Any], level: Int, ext: CGFloat) -> NSMutableAttributedString {
        
        let headPara = NSMutableParagraphStyle()
        headPara.firstLineHeadIndent = CGFloat(level * 10)
        
        let mattr = NSMutableAttributedString.init(string: "[", color: kJSONSymbolColor, style: headPara)
        
        if (arr.isEmpty == false) {
            mattr.append(NSAttributedString.init(string: "\n"))
        }
        
        for (idx, element) in arr.enumerated() {
            
            let index = String(idx)
            
            let width = (index as NSString).boundingRect(with: CGSize.init(width: CGFloat.infinity, height: kJSONFont.lineHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: kJSONFont], context: nil).size.width + 10
            
            let para = NSMutableParagraphStyle()
            para.firstLineHeadIndent = CGFloat(level * 10) + ext + 5
            para.headIndent = CGFloat(level * 10) + width + ext + 5
            
            mattr.append(NSAttributedString.init(string: index, color: kJSONIndexColor, style: para))
            
            mattr.append(NSAttributedString.init(string: ":", color: kJSONSymbolColor))
            
            mattr.append(element: element, level: level + 1, ext: width + ext)
            
            if idx != arr.count - 1 {
                mattr.append(NSAttributedString.init(string: ",", color: kJSONSymbolColor))
            }
            mattr.append(NSAttributedString.init(string: "\n"))
        }
        
        let tailPara = NSMutableParagraphStyle()
        tailPara.firstLineHeadIndent = CGFloat(level * 10) + ext
        
        mattr.append(NSAttributedString.init(string: "]", color: kJSONSymbolColor, style: tailPara))
        
        return mattr
    }
}
