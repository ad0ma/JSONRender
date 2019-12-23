# JSONRender

[![Version](https://img.shields.io/cocoapods/v/JSONRender.svg?style=flat)](https://cocoapods.org/pods/JSONRender)
[![Platform](https://img.shields.io/cocoapods/p/JSONRender.svg?style=flat)](https://cocoapods.org/pods/JSONRender)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## SnapShot
### Before👇🏻
![](https://adomaimges.oss-cn-beijing.aliyuncs.com/658DEE0D-90C0-453F-B05D-C37148FBCF54.png)
### Render👇🏻
![](https://adomaimges.oss-cn-beijing.aliyuncs.com/6C764DC1-D7EE-477D-8416-47F61F78B64B.png)

## Usage
> 
> Objc \#import \<JSONRender/JSONRender.h>
> 
>Swift \#import \<JSONRenderSwift-Swift.h>


```objc
NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

NSMutableAttributedString *mattrs = [[NSMutableAttributedString alloc] initWithString:@"Example\n" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:30]}];

[mattrs append:json];

self.textView.attributedText = mattrs;
```


## Installation

JSONRender is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JSONRender'
pod 'JSONRenderSwift'
```

## Author

ad0ma, adomacn@gmail.com

## License

JSONRender is available under the MIT license. See the LICENSE file for more info.
