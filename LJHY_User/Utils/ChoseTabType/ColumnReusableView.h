//
//  ColumnReusableView.h
//  Column
//
//  Created by fujin on 15/11/19.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,ButtonState){
    StateComplish = 0 ,
    StateSortDelete
};
typedef void(^ClickBlock) (ButtonState state);
@interface ColumnReusableView : UICollectionReusableView
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *clickButton;
@property (nonatomic, assign)BOOL buttonHidden;

-(void)clickWithBlock:(ClickBlock)clickBlock;
@end
