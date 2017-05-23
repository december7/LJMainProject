//
//  AgreeButton.m
//  JDMEForIphone
//
//  Created by ttkj on 2017/5/23.
//  Copyright © 2017年 jd.com. All rights reserved.
//

#import "AgreeButton.h"


@interface AgreeButton ()

 @end
@implementation AgreeButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if ([super initWithFrame:frame]){
        
        
    }
    
    return self;
}

- (void)setIsAgree:(BOOL)isAgree
{
    _isAgree =isAgree;
    
    [self setImage:[UIImage imageNamed:(_isAgree)?@"dailylog_fabulous_selected":@"dailylog_comment"] forState:UIControlStateNormal];
    
    self.layer.contents = (id)[UIImage imageNamed:(_isAgree?@"dailylog_fabulous_selected":@"dailylog_comment@3x")].CGImage;
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    
    [self.layer addAnimation:k forKey:@"SHOW"];

}





@end
