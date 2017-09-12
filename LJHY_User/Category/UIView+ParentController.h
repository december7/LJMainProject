//
//  UIView+presentViewController.h
//  yiliaotoutiao
//
//  Created by Jason T on 16/3/4.
//  Copyright © 2016年 YXH. All rights reserved.
//  该分类用于获取当前的控制器

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
@interface UIView (ParentController)

-(UIViewController*)parentController;
@end
