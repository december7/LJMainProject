//
//  UIImageView+KJ.h
//  VPImageCropperDemo
//
//  Created by 唐开江 on 14/12/20.
//  Copyright (c) 2014年 Vinson.D.Warm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (KJ)

/**
 *  创建一个缩小的imageView,可以指定x,y和圆圈颜色
 *
 *  @param width      图片宽度
 *  @param imageViewX x值
 *  @param imageViewY y值
 *  @param color      指定颜色
 *  @param borderW    外边宽度
 *  @param round      是否切成原型
 */
- (instancetype)initImageViewWidth:(CGFloat)imageV X:(CGFloat)imageViewX Y:(CGFloat)imageViewY circleColor:(UIColor *)color borderWidth:(CGFloat)borderW isRound:(BOOL)round;






@end
