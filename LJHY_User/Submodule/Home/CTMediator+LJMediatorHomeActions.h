//
//  CTMediator+LJMediatorHomeActions.h
//  LJHY_User
//
//  Created by 李彬 on 2016/12/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <CTMediator/CTMediator.h>

@interface CTMediator (LJMediatorHomeActions)

- (UIViewController *)CTMediator_viewControllerForNext:(NSDictionary *)params;

- (UITableViewCell *)CTMediator_tableViewCellWithIdentifier:(NSString *)identifier tableView:(UITableView *)tableView;

- (void)CTMediator_configTableViewCell:(UITableViewCell *)cell withTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath;

- (void)CTMediator_cleanTableViewCellTarget;

@end
