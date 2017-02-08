//
//  LJNextViewController.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LJNextViewController.h"

@interface LJNextViewController ()

@end

@implementation LJNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.value;
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
    label.frame = CGRectMake(100, 100, 200, 100);
}

@end
