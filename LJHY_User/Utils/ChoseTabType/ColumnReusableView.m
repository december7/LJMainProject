//
//  ColumnReusableView.m
//  Column
//
//  Created by fujin on 15/11/19.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "ColumnReusableView.h"
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@interface ColumnReusableView ()
@property (nonatomic, copy)ClickBlock clickBlock;

@end
@implementation ColumnReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
    }
    return self;
}
-(void)confingSubViews{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, self.bounds.size.height)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = RGBA(51, 51, 51, 1);
    [self addSubview:self.titleLabel];
    
    CGFloat width = (ScreenWidth / 4.0) - 14;
    self.clickButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width - width  -10, 10, width, 30)];

    self.titleLabel.centerY = self.height * 0.6;
    self.clickButton.centerY = self.height * 0.6;
    self.clickButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.clickButton.backgroundColor = [UIColor whiteColor];
    self.clickButton.layer.masksToBounds = YES;
    self.clickButton.layer.cornerRadius = 1;
    self.clickButton.layer.borderColor = RGBA(225, 47, 63, 1).CGColor;
    self.clickButton.layer.borderWidth = 0.7;
    [self.clickButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.clickButton setTitle:@"完成" forState:UIControlStateSelected];
    [self.clickButton setTitleColor: RGBA(225, 47, 63, 1) forState:UIControlStateNormal];
    [self.clickButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clickButton];
}
-(void)clickWithBlock:(ClickBlock)clickBlock{
    
    
    
    if (clickBlock) {
        self.clickBlock = clickBlock;
    }
}
-(void)clickAction:(UIButton *)sender{
    self.clickButton.selected = !self.clickButton.selected;
    if (sender.selected) {
        // 更改选中状态
        self.clickBlock(StateSortDelete);
    }else{
        self.clickBlock(StateComplish);
    }
    
}
#pragma mark ----------- set ---------------
-(void)setButtonHidden:(BOOL)buttonHidden{
    if (buttonHidden != _buttonHidden) {
        self.clickButton.hidden = buttonHidden;
        _buttonHidden = buttonHidden;
    }
}
@end
