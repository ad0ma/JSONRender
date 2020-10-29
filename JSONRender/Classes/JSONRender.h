//
//  JSONRender.h
//  ADLog
//
//  Created by Adoma on 2019/12/20.
//  Copyright © 2019 adoma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (ADLog)

+ (NSAttributedString *)render:(id)element;

@end


@interface NSMutableAttributedString (ADLog)

- (void)append:(id)element;

@end

NS_ASSUME_NONNULL_END
