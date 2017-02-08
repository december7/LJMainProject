//
//  LJTarget_Next.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Target_Home.h"
#import <LJHY_OrderModule/LJNextViewController.h>

@implementation Target_Home

- (UIViewController *)Action_nativeFetchNextViewController:(NSDictionary *)params
{
    LJNextViewController *viewController = [[LJNextViewController alloc] init];
    viewController.value = params[@"key"];
    return viewController;
}

- (UITableViewCell *)Action_cell:(NSDictionary *)params
{
    UITableView *tableView = params[@"tableView"];
    NSString *identifier = params[@"identifier"];
    
    // 这里的TableViewCell的类型可以是自定义的，我这边偷懒就不自定义了。
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)Action_configCell:(NSDictionary *)params
{
    NSString *title = params[@"title"];
    NSIndexPath *indexPath = params[@"indexPath"];
    UITableViewCell *cell = params[@"cell"];
    
    // 这里的TableViewCell的类型可以是自定义的，我这边偷懒就不自定义了。
    cell.textLabel.text = [NSString stringWithFormat:@"%@------第%ld行", title, (long)indexPath.row];
    
    //    if ([cell isKindOfClass:[XXXXXCell class]]) {
    //        正常情况下在这里做特定cell的赋值，上面就简单写了
    //    }
    
    return nil;
}

@end
