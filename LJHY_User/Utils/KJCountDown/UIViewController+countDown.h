//
//  UIButton+countDown.h
//  kangzhipifuyisheng
//
//  Created by Jason T on 15/10/28.
//  Copyright © 2015年 KangZhi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ myBlock)(int processTime);
@interface NSObject (countDown)


//+ (UIViewController *)addCountDownWithDuration:(int)duration andspeed:(int)speedTime andCounting:(myBlock)countingBlock andCountdown:(myBlock)countDownBlock;

- (void )addCountDownWithDuration:(int)duration andspeed:(int)speedTime andCounting:(myBlock)countingBlock andCountdown:(myBlock)countDownBlock;

@end
