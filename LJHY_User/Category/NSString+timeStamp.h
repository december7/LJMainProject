//
//  NSString+timeStamp.h
//  kangzhipifuyisheng
//
//  Created by 唐开江 on 15/6/3.
//  Copyright (c) 2015年 KangZhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (timeStamp)

//--------------------处理时间 （将时间戳转成字符串）--------------------
+ (NSString *)dealWithTimestamp:(NSString *)timeStamp;

//--------------------处理时间 （将时间戳转成字符串,自定义时间格式）--------------------
+ (NSString *)dealWithTimestamp:(NSString *)timeStamp withFormaterStr:(NSString *)formatter;


//根据时间戳获取星期几(新方法)
+ (NSString *)getWeekDayFordate:(double)data;

//--------------------给予时间戳返回星期几-------
+ (NSString *)switchToWeekWithTimeStamp:(NSTimeInterval )timeStamp;

//----------将时间戳转成年月日（麻烦）---------------
+ (NSDateComponents *)switchToDateComponentsWithTimeStamp:(NSString *)timeStamp;
//----------------------nsstring 转 nsdate----
//输入的日期字符串形如：@"1992-05-21 13:08:08"
+ (NSDate *)dateFromString:(NSString *)dateString;

//输入的日期字符串形 如：@"1992-05-21 13:08:08",带一个format 参数
+ (NSDate *)dateFromString:(NSString *)dateString andFormat:(NSString *)format;


//------------------时间转时间戳------------

+ (NSString *)switchToTimeStampWithTimeStr:(NSString *)timeStr;
//------------------判断时间是上午下午------
+ (NSString *)switchTimeToNoon:(NSString *)timeStr;



//------------------根据时间戳返回 x分钟前/x小时前/昨天/x天前/x个月前/x年前-----
+ (NSString *)timeInfoWithDateString2:(NSString *)dateString;


//--------------- 第二种 -根据时间戳返回 x分钟前/x小时前/昨天/x天前/x个月前/x年 前-----
- (NSString *)getUTCFormateDate:(NSString *)newsDate;


//获得当前时间戳
+ (NSString *)getCurrentTimeStamp;

//获得当天0点，时间戳
+ (NSString *)getTodayZeroClickTimeStamp;

//传入某天返回某天0点时间戳
+ (NSString *)getZeroClickTime:(NSString *)timeStamp;

//nsDate 转成时间戳
+ (NSString *)DateToStringWithDate:(NSDate *)date;

//时间转成时间戳 @"YYYY-MM-dd"
+ (NSString *)switchToTimeStampWithTimeStr:(NSString *)timeStr withFormat:(NSString *)format;





@end
