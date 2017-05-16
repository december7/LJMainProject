//
//  LJNavigationController.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LJNavigationController.h"
#import "UIImage+LJColor.h"

@interface LJNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation LJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self)wself = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        //设置返回手势的代理
        self.interactivePopGestureRecognizer.delegate = wself;
        self.delegate = wself;
    }
    
    //定制导航栏样式
    [self setUpNav];
}

/**
    定制导航栏样式
 */
- (void)setUpNav
{
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]
                             forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageWithColor:LJ_Line_Color]];
}

/**
    push过程中隐藏TabBar，并且关闭侧滑手势，防止连续侧滑bug
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

/**
    pop的过程中关闭HUD显示
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    if ([[UIApplication sharedApplication] isNetworkActivityIndicatorVisible]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    return [super popViewControllerAnimated:animated];;
}

/**
    如果当前视图是根视图，则关闭手势
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count-1;
}

/**
    解决pop手势与UIScrollView冲突的问题
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

/**
    如果当前视图是根视图，则隐藏导航栏
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断要显示的控制器是否是自己
    BOOL isShow = [viewController isKindOfClass:[[self.viewControllers firstObject] class]];
    [self setNavigationBarHidden:isShow animated:YES];
}

@end
