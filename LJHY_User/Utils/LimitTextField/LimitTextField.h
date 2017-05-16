//
//  UITextField+Limit.h
//  yiliaotoutiao
//
//  Created by Jason T on 16/5/26.
//  Copyright © 2016年 YLTT. All rights reserved.
//

//#import <UIKit>
#import <Foundation/Foundation.h>

@interface LimitTextField : UITextField

@property (nonatomic,assign)NSUInteger kMaxLength;

@property (nonatomic,copy)void (^ inptutBlock)(NSString * inputStr);
@end


