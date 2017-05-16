//
//  CTMediator+LJMediatorHomeActions.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CTMediator+LJMediatorHomeActions.h"

NSString * const kCTMediatorTargetHome = @"Home";

NSString * const kCTMediatorActionNativFetchNextViewController = @"nativeFetchNextViewController";
NSString * const kCTMediatorActionCell = @"cell";
NSString * const kCTMediatorActionConfigCell = @"configCell";

@implementation CTMediator (LJMediatorHomeActions)

- (UIViewController *)CTMediator_viewControllerForNext:(NSDictionary *)params
{
    UIViewController *viewController = [self performTarget:kCTMediatorTargetHome
                                                    action:kCTMediatorActionNativFetchNextViewController
                                                    params:params
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

- (UITableViewCell *)CTMediator_tableViewCellWithIdentifier:(NSString *)identifier tableView:(UITableView *)tableView
{
    return [self performTarget:kCTMediatorTargetHome
                        action:kCTMediatorActionCell
                        params:@{
                                 @"identifier":identifier,
                                 @"tableView":tableView
                                 }
             shouldCacheTarget:YES];
}

- (void)CTMediator_configTableViewCell:(UITableViewCell *)cell withTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath
{
    [self performTarget:kCTMediatorTargetHome
                 action:kCTMediatorActionConfigCell
                 params:@{
                          @"cell":cell,
                          @"title":title,
                          @"indexPath":indexPath
                          }
      shouldCacheTarget:YES];
}

- (void)CTMediator_cleanTableViewCellTarget
{
    [self releaseCachedTargetWithTargetName:kCTMediatorTargetHome];
}

@end
