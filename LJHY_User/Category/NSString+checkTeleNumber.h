//
//  NSString+checkTeleNumber.h
//  kangzhipifuyisheng
//
//  Created by 唐开江 on 15/7/11.
//  Copyright (c) 2015年 KangZhi. All rights reserved.
// 检查电话是否正确

#import <Foundation/Foundation.h>

@interface NSString (checkTeleNumber)
//- (BOOL)checkTel:(NSString *)str;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
