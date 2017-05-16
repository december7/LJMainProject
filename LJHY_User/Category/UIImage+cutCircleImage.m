//
//  fd.m
//  yiliaotoutiao
//
//  Created by Jason T on 16/9/27.
//  Copyright © 2016年 YLTT. All rights reserved.
//

#import "UIImage+cutCircleImage.h"

@implementation UIImage(cutCircleImage)

//在此之后建议大家尽量不要这么设置, 因为使用图层过量会有卡顿现象, 特别是弄圆角或者阴影会很卡, 如果设置图片圆角我们一般用绘图来做:
/** 设置圆形图片(放到分类中使用) */
- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)setImageSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, size.width,  size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
//    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
