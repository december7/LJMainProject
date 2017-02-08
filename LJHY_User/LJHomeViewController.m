//
//  LJHomeViewController.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LJHomeViewController.h"
#import "CTMediator+LJMediatorHomeActions.h"
#import "LJDoctorRequest.h"

@interface LJHomeViewController ()

@end

@implementation LJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCustomNavigationBarWithTitle:nil];
    
    [self createTableViewStyle:UITableViewStylePlain isRootVC:YES];
    
    //YTKNetwork使用
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"https://doc.linjiahaoyi.com";
    LJDoctorRequest *doctorRequest = [[LJDoctorRequest alloc] init];
    [doctorRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"success=====%@",request.responseJSONObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error=====%@",request.error);
    }];
}

- (void)dealloc
{
    // 在Controller被回收的时候，把相关的target也回收掉
    [[CTMediator sharedInstance] CTMediator_cleanTableViewCellTarget];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[CTMediator sharedInstance] CTMediator_configTableViewCell:cell withTitle:@"cell title" atIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[CTMediator sharedInstance] CTMediator_tableViewCellWithIdentifier:@"CellID" tableView:tableView];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [NSString stringWithFormat:@"我是从第%ld行点进来的",indexPath.row+1];
    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_viewControllerForNext:@{@"key":text}];
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
