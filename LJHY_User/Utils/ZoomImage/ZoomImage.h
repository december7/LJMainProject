//
//  ZoomImage.h
//  yiliaotoutiao
//
//  Created by Jason T on 16/2/29.
//  Copyright © 2016年 YXH. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZoomImage : UIView
/**
  * @brief 点击图片放大,再次点击缩小
  *
  * @param oldImageView 头像所在的imageView
  */
+(void)showImage:(UIImageView*)avatarImageView;
@end

