//
//  NSString+call.m
//  kangzhipifuyisheng
//  Created by 唐开江 on 15/6/4.
//  Copyright (c) 2015年 KangZhi. All rights reserved.
//

//
#import "NSString+call.h"

@implementation NSString (call)
//--- ----------------打电话------

+ (void)callTeleWithPhoneNumber:(NSString *)phone
{
//NSLog(@"打电话");
//NSString *phone = self.orderInformationModel.userTel;
  if (phone != nil) {
    
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
    
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    
    [[UIApplication sharedApplication] openURL:url];
    
  }


}

@end
