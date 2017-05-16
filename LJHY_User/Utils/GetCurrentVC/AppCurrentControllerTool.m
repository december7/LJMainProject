//
//  AppCurrentControllerTool.m
//  yiliaotoutiao
//
//  Created by Jason T on 16/2/15.
//  Copyright © 2016年 YXH. All rights reserved.
//

#import "AppCurrentControllerTool.h"


@implementation UIView(parentViewController)

//1.提供一个UIView的分类方法，这个方法通过响应者链条获取view所在的控制器

- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

@end


@implementation AppCurrentControllerTool



//2.通过控制器的布局视图可以获取到控制器实例对象
//
//modal的展现方式需要取到控制器的根视图

+ (UIViewController *)getCurrentController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // modal展现方式的底层视图不同
    // 取到第一层时，取到的是UITransitionView，通过这个view拿不到控制器
    UIView *firstView = [keyWindow.subviews firstObject];
    UIView *secondView = [firstView.subviews firstObject];
    UIViewController *vc = secondView.parentController;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)vc;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            return [nav.viewControllers lastObject];
        } else {
            return tab.selectedViewController;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        return [nav.viewControllers lastObject];
    } else {
        return vc;
    }
    return nil;
}
/*
+ (UIViewController *)getCurrentController
{

        UIViewController *result = nil;

        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        if (window.windowLevel != UIWindowLevelNormal)
        {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tmpWin in windows)
            {
                if (tmpWin.windowLevel == UIWindowLevelNormal)
                {
                    window = tmpWin;
                    break;
                }
            }
        }

        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
        else
        result = window.rootViewController;
    
    return result;
    
}

*/
@end
