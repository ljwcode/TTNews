//
//  TT_TimeIntervalConverString.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/28.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_TimeIntervalConverString.h"

@interface TT_TimeIntervalConverString()



@end

@implementation TT_TimeIntervalConverString

+(NSString *)TT_converTimeIntervalToString:(NSTimeInterval)timeInterval{
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:createDate toDate:[NSDate date] options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    if(![self isThisYear:createDate]){
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        return [dateFormatter stringFromDate:createDate];
    }
    if([self isBeforeYesterday:createDate]){
        dateFormatter.dateFormat = @"前天 HH:mm";
        return [dateFormatter stringFromDate:createDate];
    }else if([self isToday:createDate] || [self isBeforeYesterday:createDate]){
        if(dateComponents.hour >= 1){
            return [NSString stringWithFormat:@"%ld小时前",(long)dateComponents.hour];
        }else if(dateComponents.minute >= 1){
            return [NSString stringWithFormat:@"%ld分钟前",(long)dateComponents.minute];
        }else{
            return @"刚刚";
        }
    }else{
        dateFormatter.dateFormat = @"MM-dd HH:mm";
        return [dateFormatter stringFromDate:createDate];
    }
    
}

+(NSString *)converString:(NSInteger)time{
    if(time < 10000){
        return [NSString stringWithFormat:@"%ld",(long)time];
    }
    return [NSString stringWithFormat:@"%ld.1f万",(long)time];
}

+(NSString *)converVideoDuration:(NSInteger)time{
    if(time == 0){return @"00:00";}
    NSInteger hour = time / 3600;
    NSInteger minute = (time/60)%60;
    NSInteger second = time % 60;
    if(hour > 0){
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)minute,(long)second];
    }
    return [NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)second];
}

+(BOOL)isThisYear:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCompnents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
    
    return dateCompnents.year == 0 && dateCompnents.month == 0 && dateCompnents.date == 0;
}

+(BOOL)isBeforeYesterday:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
    return dateComponents.year == 0 && dateComponents.month == 0 && dateComponents.day == 0;
}

+(BOOL)isToday:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSString *nowStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr == nowStr;
    
}

@end
