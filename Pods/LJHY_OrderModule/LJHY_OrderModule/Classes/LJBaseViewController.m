//
//  LJBaseViewController.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LJBaseViewController.h"

//导航栏+状态栏高度
#define NavStatusBar_Height 64
#define TabBar_Height 49

//屏幕宽高
#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height

@interface LJBaseViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UITableView *)createTableViewStyle:(UITableViewStyle)style isRootVC:(BOOL)isRootVC
{
    if (isRootVC) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavStatusBar_Height, Screen_W, Screen_H-NavStatusBar_Height-TabBar_Height) style:style];
    }else{
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavStatusBar_Height, Screen_W, Screen_H-NavStatusBar_Height) style:style];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:self.tableView];
    return self.tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
