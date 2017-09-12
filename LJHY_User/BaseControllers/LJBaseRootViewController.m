//
//  LJBaseRootViewController.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LJBaseRootViewController.h"

@interface LJBaseRootViewController ()

@end

@implementation LJBaseRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (LJView *)createCustomNavigationBarWithTitle:(NSString *)title
{
    LJView *navigationView = [[LJView alloc] init];
    navigationView.backgroundColor = LJ_Yellow_Color;
    [self.view addSubview:navigationView];
    
    navigationView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .heightIs(64);
    
    //如果传入title，则创建titleLabel
    if (title && title.length > 0) {
        LJLabel *titleLabel = [[LJLabel alloc] init];
        titleLabel.text = title;
        titleLabel.textColor = LJ_Text_Color;
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [navigationView addSubview:titleLabel];
        
        titleLabel.sd_layout
        .centerXEqualToView(navigationView)
        .topSpaceToView(navigationView,30);
        [titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    }
    
    return navigationView;
}

@end
