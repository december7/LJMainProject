//
//  UIView+presentViewController.m
//  yiliaotoutiao
//
//  Created by Jason T on 16/3/4.
//  Copyright © 2016年 YXH. All rights reserved.
//

#import "UIView+ParentController.h"

@implementation UIView (ParentController)

-(UIViewController*)parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


@end
