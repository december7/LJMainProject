//
//  UIImage+Help.m
//  03-QQ聊天
//
//  Created by apple on 14-7-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+Help.h"

@implementation UIImage (Help)
+ (UIImage *)resizableImage:(NSString *)name
{
    // 想把图片的拉伸这个功能封装起来
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;

    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    


}

@end
