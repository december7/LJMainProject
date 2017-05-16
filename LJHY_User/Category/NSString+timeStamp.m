//
//  NSString+timeStamp.m
//  kangzhipifuyisheng
//
//  Created by 唐开江 on 15/6/3.
//  Copyright (c) 2015年 KangZhi. All rights reserved.
//

#import "NSString+timeStamp.h"
//#import "NSDate+divisionTime.h"

#define  KTimeFormart @"YYYY-MM-dd hh:mm:ss"


@implementation NSString (timeStamp)


+ (NSString *)dealWithTimestamp:(NSString *)timeStamp withFormaterStr:(NSString *)formatter
{


    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
//    [formatter1 setDateStyle:NSDateFormatterMediumStyle];
//    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    [formatter1 setDateFormat:formatter];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter1 setTimeZone:timeZone];
    
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];

    NSTimeInterval time = [timeStamp integerValue] ;
    NSDate *  date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *timeStr = [formatter1 stringFromDate:date];
    
    return timeStr;
    

}


//--------------------处理时间 （将时间戳转成字符串）--------------------
+ (NSString *)dealWithTimestamp:(NSString *)timeStamp
{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:KTimeFormart];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    
    NSString *timeStr = [formatter stringFromDate:confromTimesp];
    return timeStr;
    
}


//--------------------给予时间戳返回星期几-------
+ (NSString *)switchToWeekWithTimeStamp:(NSTimeInterval )timeStamp
{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *now = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:timeStamp];;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger  week = [comps weekOfMonth];
    
    if(week==1)
    {
        return  @"周日";
    }else if(week==2){
        return  @"周一";
        
    }else if(week==3){
        return  @"周二";
        
    }else if(week==4){
        return  @"周三";

    }else if(week==5){
        return  @"周四";
        
    }else if(week==6){
        return  @"周五";
        
    }else {
        return  @"周二";
        
    }
    
}
//----------将时间戳转成年月日（麻烦）---------------

+ (NSDateComponents *)switchToDateComponentsWithTimeStamp:(NSString *)timeStamp
{

    NSString * timeStr = [NSString dealWithTimestamp:timeStamp];
    NSDate * datenow = [NSString dateFromString:timeStr];
//    NSDate *datenow = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *cmps = [calendar components:unit fromDate:datenow];
//    NSLog(@"%d-%d-%d",cmps.year,cmps.month,cmps.day);
    return cmps;
}



//根据时间戳获取星期几(新方法)
+ (NSString *)getWeekDayFordate:(double)data
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}


//----------------------nsstring 转 nsdate
//输入的日期字符串形如：@"1992-05-21 13:08:08"
+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: KTimeFormart];
    NSDate *firstDay= [dateFormatter dateFromString:dateString];
    
    return firstDay;
}

+ (NSDate *)dateFromString:(NSString *)dateString andFormat:(NSString *)format
{
    
     //设置时区,系统默认的是utc
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    
    //设置中文
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
   
//    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSDate *firstDay= [dateFormatter dateFromString:dateString];
    return firstDay;

}





//------------------时间转时间戳------------

+ (NSString *)switchToTimeStampWithTimeStr:(NSString *)timeStr
{
//    NSString* timeStr = fileModel.rightContentStr;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];

    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式


    //时间转时间戳的方法:(时间差)
    NSString * timeSp = [NSString stringWithFormat:@"%ld", (long)[[[NSDate alloc]init] timeIntervalSinceDate:date]- (long)[datenow timeIntervalSince1970]];
    
    return  timeSp;

}

// 判断是上午还是下午

+ (NSString *)switchTimeToNoon:(NSString *)timeStr
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
//    NSDate *firstDay= [dateFormatter dateFromString:timeStr];
    [dateFormatter setDateFormat:@"HH"];
    NSString *str = [dateFormatter stringFromDate:[NSDate date]];
    int time = [str intValue];
    if (time>=0||time<=12) {
        return @"上午";
    }
    else{
        return @"下午午";
    }


}



/**
 * Retain a formated string with a real date string
 *
 * @param dateString a real date string, which can be converted to a NSDate object
 *
 * @return a string that will be x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
+ (NSString *)timeInfoWithDateString2:(NSString *)dateString {
    
    
    /*
    // 把日期字符串格式化为日期对象
    
   NSString * newTimeStr = [self dealWithTimestamp:dateString];
    NSDate *date = [NSDate dateFromString:newTimeStr withFormat:KTimeFormart];//@"yyyy-MM-dd HH:mm:ss"
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate getMonth] - [date getMonth]);
    int year = (int)([curDate getYear] - [date getYear]);
    int day = (int)([curDate getDay] - [date getDay]);
    
    NSTimeInterval retTime = 1.0;
    // 小于一小时
    if (time < 3600) {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }
    // 小于一天，也就是今天
    else if (time < 33600 * 24) {
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    }
    // 昨天
    else if (time < 33600 * 224 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate getMonth] == 1 && [date getMonth] == 12)) {
        int retDay = 0;
        // 同年
        if (year == 0) {
            // 同月
            if (month == 0) {
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 这里按月最大值来计算
            // 获取发布日期中，该月总共有多少天
            int totalDays = [NSDate daysInMonth:(int)[date getMonth] year:(int)[date getYear]];
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate getDay] + (totalDays - (int)[date getDay]);
            
            if (retDay >= totalDays) {
                return [NSString stringWithFormat:@"%d个月前", (abs)(MAX(retDay / 31, 1))];
            }
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 相差一年
            int month = (int)[curDate getMonth];
            int preMonth = (int)[date getMonth];
            
            // 隔年，但同月，就作为满一年来计算
            if (month == 12 && preMonth == 12) {
                return @"1年前";
            }  
            
            // 也不看，但非同月  
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];  
        }  
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];  
    }  
    
    return @"1小时前";
    
    
    */
    
    
    NSString * newTimeStr = [self dealWithTimestamp:dateString];
    
   return  [[[self alloc]init] getUTCFormateDate:newTimeStr];
}


-(NSString *)getUTCFormateDate:(NSString *)newsDate
{
            //    newsDate = @"2013-08-09 17:01";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:KTimeFormart];//@"yyyy-MM-dd HH:mm"

       // NSLog(@"newsDate = %@",newsDate);
        NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
//        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

        [dateFormatter setTimeZone:timeZone];

        NSDate* current_date = [[NSDate alloc] init];
        NSString *currentTime = [dateFormatter stringFromDate:current_date];
        NSDate* current_date0 = [NSString  dateFromString:currentTime];
    
    
        NSTimeInterval time0=[current_date0 timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
        NSTimeInterval time = fabs(time0);
//        int  toalTime = (int)time;
    
        int month=((int)time)/(3600*24*30);
        int days=((int)time)/(3600*24);
        int hours=((int)time)%(3600*24)/3600;
        int minute=((int)time)%(3600*24)/60;
       // NSLog(@"time=%f",(double)time);

        NSString *dateContent;

        if(month!=0){

            dateContent = [NSString stringWithFormat:@"%@%i%@",@"",month,@"个月前"];

        }else if(days!=0){

            dateContent = [NSString stringWithFormat:@"%@%i%@",@"",days,@"天前"];
        }else if(hours!=0){

            dateContent = [NSString stringWithFormat:@"%@%i%@",@"",hours,@"小时前"];
        }else {

            dateContent = [NSString stringWithFormat:@"%@%i%@",@"",minute,@"分钟前"];
        }

            //    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];

          return dateContent;
}

/*
        1.

        NSDate *localDate = [NSDate date]; //获取当前时间
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];  //转化为UNIX时间戳
        NSLog(@"timeSp:%@",timeSp); //时间戳的值

        2.

        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970]*1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
        NSString *timeString = [NSString stringWithFormat:@"%f", a]; //转为字符型

        3.

        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate  date] timeIntervalSince1970]];

        4.

        NSLog(@"%ld", time(NULL));  // 这句也可以获得时间戳，跟上面一样，精确到秒

*/
//获取当前时间戳
+ (NSString *)getCurrentTimeStamp
{
    NSDate *localDate = [NSDate date]; //获取当前时间
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];
    return timeSp;
}

+ (NSString *)DateToStringWithDate:(NSDate *)date
{

    //时间转时间戳的方法:(时间差)
    NSString * timeSp = [NSString stringWithFormat:@"%ld",  (long)[date timeIntervalSince1970]];
    return  timeSp;


}




+ (NSString *)switchToTimeStampWithTimeStr:(NSString *)timeStr withFormat:(NSString *)format;
{
    
    NSDate * date =[NSString dateFromString:timeStr andFormat:format];
    
   NSString *dateString =  [self DateToStringWithDate:date];

    return dateString;
}



+ (NSString *)getTodayZeroClickTimeStamp
{
    
    
    NSInteger   today = [[NSString getCurrentTimeStamp] integerValue];
    
#warning  --这里的时间没有到0点,减去8个小时
    NSInteger  time = today-(today%86400)-8*60*60;
   NSString * str = [NSString stringWithFormat:@"%zd",time];
    
    return str;

}


+ (NSString *)getZeroClickTime:(NSString *)timeStamp
{
    
    NSInteger time =[timeStamp integerValue];
   NSInteger  zeroTime = time-(time%86400)-8*60*60;
    NSString * zeroTimeStr = [NSString stringWithFormat:@"%zd",zeroTime];

    return zeroTimeStr;
}

//----------另一种获取当前当前年月日（麻烦）---------------
//NSDate * current = [NSDate date];
//NSString *currentDateSTr = [formatter stringFromDate:current];
////   NSArray * birthGroup = [currentDateSTr componentsSeparatedByString:@"-"];
//
//int year = [[currentDateSTr substringToIndex:4] intValue];
//
//NSRange range = {5,2};
//int  month =[[currentDateSTr  substringWithRange:range] intValue];
//
//NSRange range1 = {8,2};
//int  day = [[currentDateSTr  substringWithRange:range1] intValue];


@end
