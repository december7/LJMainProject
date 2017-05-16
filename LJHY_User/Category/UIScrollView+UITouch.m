//
//  UIScrollView+UITouch.m
//  kangzhipifuyisheng
//
//  Created by 唐开江 on 15/7/1.
//  Copyright (c) 2015年 KangZhi. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)

/*
//------------在UIScrollview 中重写下面三种方法中的一种，会导致崩溃bug（-[UIKBBlurredKeyView candidateList]) : unrecognized selector sent to instance 0x13617e3d0
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}


*/


//用以下方法代替
- (void)awakeFromNib
{
    [super awakeFromNib];
//    UIView * backView = [[UIView alloc]initWithFrame:self.bounds];
    
    // 此方法会引起键盘不能正常弹出
    
//    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
//    tapGr.cancelsTouchesInView = NO;
//    [self addGestureRecognizer:tapGr];
    
    
//    [backView addGestureRecognizer:tapGr];
    
//    [self addSubview:backView];
}
//
//- (void)hideKeyboard:(UITapGestureRecognizer *)tapGure
//{
//    [self endEditing:YES];
//}



@end
