//
//  VPViewController.h
//  VPImageCropperDemo
//
//  Created by Vinson.D.Warm on 1/13/14.
//  Copyright (c) 2014 Vinson.D.Warm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPViewController : UIViewController

//不改变形状的图片
@property (nonatomic,weak)UIImage  * originalImageView;

/**
 *  *  创建返回一个可以选择图片的iamgeView
 *
 *  @param width 宽度
 *  @param X     x值
 *  @param Y     y值
 *  @param borderW     外圆宽度，一般为2.0f
 *  @param borderColor 外圆颜色，默认白色
 *  @param round  是否切成原型
 */
- (UIImageView *)addPortaitImageViewWidth:(CGFloat)imageW portraitX:(CGFloat)X portraitY:(CGFloat)Y width:(CGFloat)borderW circleColor:(UIColor *)borderColor isRound:(BOOL)round;



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
@end
