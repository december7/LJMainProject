//
//  LJBaseSubViewController.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LJBaseSubViewController.h"

@interface LJBaseSubViewController ()

@end

@implementation LJBaseSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化相关设置
    self.popGestureEnabled = YES;
    
    [self setUp];
}

- (void)setUp
{
    //自定义返回按钮
    LJButton *leftBarButton = [[LJButton alloc] init];
    leftBarButton.frame = CGRectMake(0, 0, 40, 40);
    [leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
    [leftBarButton setImage:[UIImage imageNamed:@"my_list_back"] forState:UIControlStateNormal];
    [leftBarButton setImage:[UIImage imageNamed:@"my_list_back"] forState:UIControlStateHighlighted];
    [leftBarButton addTarget:self action:@selector(lj_backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

/**
    返回按钮点击事件
 */
- (void)lj_backButtonClicked:(UIButton *)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
    界面出现的时候打开侧滑手势
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = self.popGestureEnabled;
}


@end
