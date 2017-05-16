//
//  CoclumnCollectionViewCell.m
//  Column
//
//  Created by fujin on 15/11/18.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "CoclumnCollectionViewCell.h"
#import "StudyTabModel.h"
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
@implementation CoclumnCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self confingSubViews];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)confingSubViews{
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 0, self.contentView.bounds.size.width - 2, self.contentView.bounds.size.height)];
    self.contentLabel.center = self.contentView.center;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 1;
    self.contentLabel.adjustsFontSizeToFitWidth = YES;
    self.contentLabel.minimumScaleFactor = 0.1;
    [self.contentView addSubview:self.contentLabel];
    
//    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
//    [self.contentLabel addGestureRecognizer:longPressGesture];
    self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width-6, -6, 13, 13)];
    [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.contentView addSubview:self.deleteButton];
    
    
    self.coverButton = [[UIButton alloc] initWithFrame:self.contentLabel.bounds];
    self.coverButton.backgroundColor = [UIColor clearColor];
    [self.coverButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
      [self.contentView addSubview:self.coverButton];
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];
    if (_indexPath.section == 0)
    {
        CGPoint buttonPoint = [self.deleteButton convertPoint:point fromView:self.contentView];
        if ([self.deleteButton pointInside:buttonPoint withEvent:event]) {
            return self.deleteButton;
        }
    }
    return result;
}

//-(void)longPress{
//
//    if ([self.deleteDelegate respondsToSelector:@selector(longPressAction)]) {
//        [self.deleteDelegate longPressAction];
//    }
//    
//}


-(void)configCell:(NSArray *)dataArray withIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    self.contentLabel.hidden = NO;
    
    StudyTabModel * studyM  = dataArray[indexPath.row];
    
    self.contentLabel.text = studyM.name;
//    if (indexPath.section == 0 & indexPath.row == 0) {
    if ([studyM.locked isEqualToString:@"1"]) {
    
//
        self.contentLabel.textColor = RGBA(130, 130, 130, 1);
//         self.contentLabel.textColor = RGBA(214, 39, 48, 1);
//         self.contentLabel.layer.masksToBounds = YES;
//         self.contentLabel.layer.borderColor = [UIColor clearColor].CGColor;
        self.contentLabel.layer.cornerRadius = CGRectGetHeight(self.contentView.bounds) * 0.0;
        self.contentLabel.layer.borderColor = RGBA(211, 211, 211, 1).CGColor;
         self.contentLabel.layer.borderWidth = 0.45;
    }
    else{
        self.contentLabel.textColor = RGBA(101, 101, 101, 1);
//        self.contentLabel.layer.masksToBounds = YES;
        self.contentLabel.layer.cornerRadius = CGRectGetHeight(self.contentView.bounds) * 0.0;
        self.contentLabel.layer.borderColor = RGBA(211, 211, 211, 1).CGColor;
        self.contentLabel.layer.borderWidth = 0.45;
    }
}
-(void)deleteAction:(UIButton *)sender{
    if ([self.deleteDelegate respondsToSelector:@selector(deleteItemWithIndexPath:)]) {
        [self.deleteDelegate deleteItemWithIndexPath:self.indexPath];
    }
}
-(void)dealloc{
    for (UIPanGestureRecognizer *pan in self.gestureRecognizers) {
        [self removeGestureRecognizer:pan];
    }
    for (UILongPressGestureRecognizer *longPress in self.contentLabel.gestureRecognizers) {
        [self removeGestureRecognizer:longPress];
    }
    
}
@end
