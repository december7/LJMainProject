//
//  VPViewController.h
//  VPImageCropperDemo
//
//  Created by Vinson.D.Warm on 1/13/14.
//  Copyright (c) 2014 Vinson.D.Warm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myblock2)(UIImage * image);

@protocol KZPortaitViewDelegate <NSObject>

- (void)uploadPict:(UIImage *)image;

@end

@interface KZPortaitView :  UIView


//头像图片View
@property (nonatomic, strong) UIImageView *portraitImageView;

@property (nonatomic,assign)BOOL isCrop;
@property (nonatomic,assign)float portraintX;
@property (nonatomic,assign)float portraintY;
@property (nonatomic,strong)UITapGestureRecognizer * tapGesture;

@property (nonatomic,assign)UIViewController * controller;


/**1
 *  *  创建返回一个可以选择图片的iamgeView
 *
 *  @param width       宽度
 *  @param X           x值
 *  @param Y           y值
 *  @param borderW     外圆宽度，一般为2.0f
 *  @param borderColor 外圆颜色，默认白色
 *  @param round       是否切成原型
 *  @param controller  当前控制器(遵守KZPortaitViewDelegate即可)
 */
+ (KZPortaitView *)addPortaitImageViewWidth:(CGFloat)imageW portraitX:(CGFloat)X portraitY:(CGFloat)Y borderWidth:(CGFloat)borderW circleColor:(UIColor *)borderColor isRound:(BOOL)round andViewController:(UIViewController<KZPortaitViewDelegate> *)controller;


/**
 *  当取到图片就执行的操作，可以在此上传
 */
@property (nonatomic,copy)myblock2  uploadPictBlock;

@property (nonatomic,assign)id <KZPortaitViewDelegate> portaitDelegate;


@end
