//
//  NSDate+FormatDate.m
//  YuanQuan
//
//  Created by 陈颖鹏 on 15/9/13.
//
//

#import "NSDate+FormatDate.h"

@implementation NSDate (FormatDate)

- (NSString *)presentation_YMDHMS
{
    return [[NSDate formatterYMDHMS] stringFromDate:self];
}

- (NSString *)presentation_YMD
{
    return [[NSDate formatterYMD] stringFromDate:self];
}

- (NSString *)txtMsg
{
    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:self];
    NSTimeInterval minutes = seconds / 60;
    NSTimeInterval hours = minutes / 60;
    NSTimeInterval days = hours / 24;
    NSTimeInterval weeks = days / 7;
    
    NSString *textMsg = nil;
    
    if (weeks >= 1) {
        return [self presentation_YMDHMS];
    } else if (days >= 1) {
        textMsg = [NSString stringWithFormat:@"%ld天前", (unsigned long)days];
    } else if (hours >= 1) {
        textMsg = [NSString stringWithFormat:@"%ld小时前", (unsigned long)hours];
    } else if (minutes >= 1) {
        textMsg = [NSString stringWithFormat:@"%ld分钟前", (unsigned long)minutes];
    } else {
        textMsg = [NSString stringWithFormat:@"%ld秒前", (unsigned long)seconds];
    }
    
    return textMsg?:[NSString string];
}

+ (NSDateFormatter *)formatterYMDHMS
{
    static NSDateFormatter *__formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __formatter = [[NSDateFormatter alloc] init];
        [__formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    
    return __formatter;
}

+ (NSDateFormatter *)formatterYMD
{
    static NSDateFormatter *__formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __formatter = [[NSDateFormatter alloc] init];
        [__formatter setDateFormat:@"yyyy-MM-dd"];
    });
    
    return __formatter;
}

@end
