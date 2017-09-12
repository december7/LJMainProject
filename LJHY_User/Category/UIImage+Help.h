//
//  UIImage+Help.h
//  03-QQ聊天
//
//  Created by apple on 14-7-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Help)

/**
 *  返回一个可以随意拉伸的不变形的图片
 */
+ (UIImage *)resizableImage:(NSString *)name;

@end
