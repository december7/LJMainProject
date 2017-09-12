//
//  LJTabBarController.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LJTabBarController.h"
#import "LJNavigationController.h"
#import "LJHomeViewController.h"
#import "LJDoctorViewController.h"
#import "LJServiceViewController.h"
#import "LJPersonalViewController.h"
#import "UIImage+LJColor.h"

@interface LJTabBarController ()

@end

@implementation LJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];
    
    //初始化子viewController
    LJHomeViewController   *homeVC       = [[LJHomeViewController alloc] init];
    LJDoctorViewController *doctorVC     = [[LJDoctorViewController alloc] init];
    LJServiceViewController  *serviceVC  = [[LJServiceViewController alloc] init];
    LJPersonalViewController *personalVC = [[LJPersonalViewController alloc] init];
    
    //包装数组
    NSArray *tabBarItems = @[@"首页",@"医生",@"服务",@"我"];
    NSArray *vcItems     = @[homeVC, doctorVC, serviceVC, personalVC];
    
    //遍历添加子模块
    [tabBarItems enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil selectedImage:nil];
        LJNavigationController *navigationVC = [[LJNavigationController alloc] initWithRootViewController:vcItems[idx]];
        navigationVC.tabBarItem = tabBarItem;
        [self addChildViewController:navigationVC];
        
    }];
    
}

/**
    定制TabBar样式
 */
- (void)setUpTabBar
{
    self.tabBar.tintColor = LJ_Yellow_Color;
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:LJ_Line_Color]];
}

@end
