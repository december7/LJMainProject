
//
//  UIButton+countDown.m
//  kangzhipifuyisheng
//
//  Created by Jason T on 15/10/28.
//  Copyright © 2015年 KangZhi. All rights reserved.
//

#import "UIViewController+countDown.h"
static int duration0;
static int speedTime0;

@implementation UIViewController (countDown)


//+ (UIViewController *)addCountDownWithDuration:(int)duration andspeed:(int)speedTime andCounting:(myBlock)countingBlock andCountdown:(myBlock)countDownBlock
//{
//    
//    duration0 = duration;
//    speedTime0 = speedTime;
//   return  [[self alloc] addCountDownWithDuration:duration andspeed:speedTime andCounting:countingBlock andCountdown:countDownBlock];
//}



- (void)addCountDownWithDuration:(int)duration andspeed:(int)speedTime andCounting:(myBlock)countingBlock andCountdown:(myBlock)countDownBlock
{
    duration0 = duration;
    speedTime0 = speedTime;
    
//    return [self  startTimeWithCounting:countingBlock andCountdown:countDownBlock];
    [self startTimeWithCounting:countingBlock andCountdown:countDownBlock];
    
}



-(void)startTimeWithCounting:(myBlock)countingBlock andCountdown:(myBlock)countDownBlock
{
    __block int timeout=duration0; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),speedTime0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (countDownBlock) {
                    countDownBlock(0);
                }
                
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = (timeout-1) % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
                if (countingBlock) {
                    countingBlock(seconds);
                }
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}
@end
