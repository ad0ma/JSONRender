//
//  JSONRender.m
//  ADLog
//
//  Created by Adoma on 2019/12/20.
//  Copyright © 2019 adoma. All rights reserved.
//

//systemFontOfSize/boldSystemFontOfSize
#define kJSONFont [UIFont boldSystemFontOfSize:14]

#define kJSONKeyColor [UIColor colorWithRed:146/255.0 green:39/255.0 blue:143/255.0 alpha:1]
#define kJSONIndexColor [UIColor colorWithRed:25/255.0 green:25/255.0 blue:112/255.0 alpha:1]
#define kJSONSymbolColor [UIColor colorWithRed:74/255.0 green:85/255.0 blue:96/255.0 alpha:1]

#define kJSONNullValueColor [UIColor colorWithRed:241/255.0 green:89/255.0 blue:42/255.0 alpha:1]
#define kJSONBoolValueColor [UIColor colorWithRed:249/255.0 green:130/255.0 blue:128/255.0 alpha:1]
#define kJSONNumberValueColor [UIColor colorWithRed:37/255.0 green:170/255.0 blue:226/255.0 alpha:1]
#define kJSONStringValueColor [UIColor colorWithRed:58/255.0 green:181/255.0 blue:74/255.0 alpha:1]

#import "JSONRender.h"

@implementation NSAttributedString (ADLog)

+ (NSAttributedString *)render:(id)element
{
    return [self render:element level:0 ext:0];
}

+ (NSAttributedString *)render:(id)element level:(int)level ext:(CGFloat)ext
{
    if ([element isKindOfClass:[NSDictionary class]]) {
        return  [self attributedStringWithDic:element level:level ext:ext];
    }
    else if ([element isKindOfClass:[NSArray class]]) {
        return [self attributedStringWithArr:element level:level ext:ext];
    }
    else {
        UIColor *color = kJSONStringValueColor;
        if (element == nil || [element isKindOfClass:[NSNull class]]) {
            color = kJSONNullValueColor;
            element = @"null";
        }
        else if ([element isKindOfClass:[NSNumber class]]) {
            if ([element isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
                color = kJSONBoolValueColor;
                element = [element boolValue] ? @"true" : @"false";
            } else {
                color = kJSONNumberValueColor;
                const char *objCType = [element objCType];
                if (strcmp("f", objCType) == 0 || strcmp("d", objCType) == 0) {
                    element = [NSString stringWithFormat:@"%f",[element doubleValue]];
                    NSDecimalNumber *dec = [NSDecimalNumber decimalNumberWithString:element];
                    element = dec.stringValue;
                } else {
                    element = [element stringValue];
                }
            }
        }
        else if ([element isKindOfClass:[NSString class]]) {
            element = [NSString stringWithFormat:@"\"%@\"", element];
        }
        else {
            element = [NSString stringWithFormat:@"%@", element];
        }
        return [[NSAttributedString alloc] initWithString:element attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: color}];
    }
}

+ (NSAttributedString *)attributedStringWithDic:(NSDictionary *)dic level:(int)level ext:(CGFloat)ext
{
    NSMutableParagraphStyle *headPara = [NSMutableParagraphStyle new];
    headPara.firstLineHeadIndent = level * 10;
    
    NSMutableAttributedString *mattr = [[NSMutableAttributedString alloc] initWithString:@"{" attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: kJSONSymbolColor, NSParagraphStyleAttributeName:headPara}];
    
    if (dic.count) {
        [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    for (int i = 0; i < dic.allKeys.count; i ++) {
        
        NSString *key = dic.allKeys[i];
        
        NSString *keyString = [NSString stringWithFormat:@"\"%@\"", key];
        
        CGFloat width = [keyString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, kJSONFont.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kJSONFont} context:nil].size.width + 10;
        
        NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
        para.firstLineHeadIndent = (level + 1) * 10 + ext;
        para.headIndent = level * 10 + width + ext + 5;
        para.lineBreakMode = NSLineBreakByCharWrapping;
        
        [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:keyString attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: kJSONKeyColor, NSParagraphStyleAttributeName:para}]];
        
        [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@":" attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: kJSONSymbolColor}]];
                
        [mattr append:[NSAttributedString render:dic[key] level:level + 1 ext:width + ext]];

        if (i != dic.allKeys.count - 1) {
            [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"," attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName:kJSONSymbolColor}]];
        }
        [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    NSMutableParagraphStyle *tailPara = [NSMutableParagraphStyle new];
    tailPara.firstLineHeadIndent = level * 10 + ext;
    
    [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"}" attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: kJSONSymbolColor, NSParagraphStyleAttributeName:tailPara}]];
    
    return mattr;
}

+ (NSAttributedString *)attributedStringWithArr:(NSArray *)arr level:(int)level ext:(CGFloat)ext
{
    NSMutableParagraphStyle *headPara = [NSMutableParagraphStyle new];
    headPara.firstLineHeadIndent = level * 10;
    
    NSMutableAttributedString *mattr = [[NSMutableAttributedString alloc] initWithString:@"[" attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: kJSONSymbolColor, NSParagraphStyleAttributeName:headPara}];
    
    if (arr.count) {
        [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    for (int i = 0; i < arr.count; i ++) {
        
        NSString *index = @(i).stringValue;

        CGFloat width = [index boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, kJSONFont.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kJSONFont} context:nil].size.width + 10;
        
        NSMutableParagraphStyle *para = [NSMutableParagraphStyle new];
        para.firstLineHeadIndent = level * 10 + ext + 5;
        para.headIndent = level * 10 + ext + width + 5;
        para.lineBreakMode = NSLineBreakByCharWrapping;

        [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:index attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: kJSONIndexColor, NSParagraphStyleAttributeName:para}]];
        
        [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@":" attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: kJSONSymbolColor}]];
        
        [mattr append:[NSAttributedString render:arr[i] level:level + 1 ext:width + ext]];
        
        if (i != arr.count - 1) {
            [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"," attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName:kJSONSymbolColor}]];
        }
        [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }
    
    NSMutableParagraphStyle *tailPara = [NSMutableParagraphStyle new];
    tailPara.firstLineHeadIndent = level * 10 + ext;
    
    [mattr appendAttributedString:[[NSAttributedString alloc] initWithString:@"]" attributes:@{NSFontAttributeName:kJSONFont, NSForegroundColorAttributeName: kJSONSymbolColor, NSParagraphStyleAttributeName:tailPara}]];
    
    return mattr;
}

@end

@implementation NSMutableAttributedString (ADLog)

- (void)append:(id)element
{
    [self append: [NSAttributedString render:element]];
}

@end
