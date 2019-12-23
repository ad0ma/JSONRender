//
//  ADViewController.m
//  JSONRender
//
//  Created by ad0ma on 12/20/2019.
//  Copyright (c) 2019 ad0ma. All rights reserved.
//

#import "ADViewController.h"
///objc
//#import <JSONRender/JSONRender.h>
///Swift
#import <JSONRenderSwift-Swift.h>

@interface ADViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://adoma.cn/testJson"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableAttributedString *mattrs = [[NSMutableAttributedString alloc] initWithString:@"Example\n" attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:30]}];
        [mattrs append:json];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.textView.attributedText = mattrs;
        });
    }];
    [task resume];
}

@end
