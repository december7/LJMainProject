//
//  LJDoctorRequest.m
//  LJHY_User
//
//  Created by 李彬 on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "LJDoctorRequest.h"

@implementation LJDoctorRequest

- (NSString *)requestUrl
{
    return @"/doctor/recommend";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

@end
