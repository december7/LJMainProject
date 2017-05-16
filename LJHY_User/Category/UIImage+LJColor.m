//
//  UIImage+LJColor.m
//  LJHY_User
//
//  Created by 李彬 on 2016/12/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIImage+LJColor.h"

@implementation UIImage (LJColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0,0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
