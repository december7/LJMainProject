//
//  UIImage+ResizeImage.h
//  JDMEForIphone
//
//  Created by ttkj on 2017/5/17.
//  Copyright © 2017年 jd.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeImage)
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
