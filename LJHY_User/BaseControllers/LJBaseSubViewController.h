//
//  LJBaseSubViewController.h
//  LJHY_User
//
//  Created by 李彬 on 2016/12/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LJBaseViewController.h"

@interface LJBaseSubViewController : LJBaseViewController

/**
    侧滑手势开关,默认YES(打开)
 */
@property (nonatomic, assign) BOOL popGestureEnabled;



/**
    返回按钮点击事件,用于重写返回到指定页面
 */
- (void)lj_backButtonClicked:(UIButton *)backBtn;


@end
