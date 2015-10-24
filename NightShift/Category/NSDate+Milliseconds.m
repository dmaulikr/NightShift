//
//  NSDate+Milliseconds.m
//  YuanQuan
//
//  Created by 陈颖鹏 on 15/10/4.
//
//

#import "NSDate+Milliseconds.h"

@implementation NSDate (Milliseconds)

+ (NSString *)millisecondsStringSince1970
{
    return [[NSDate millisecondsNumberSince1970] stringValue];
}

+ (NSNumber *)millisecondsNumberSince1970
{
    return [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]*1000];
}

- (NSNumber *)millisecondsNumberSince1970
{
    return [NSNumber numberWithLongLong:[self timeIntervalSince1970]*1000];
}

+ (NSDate *)dateFromMillisecondsNumberSince1970:(NSNumber *)time
{
    double milliseconds = [time doubleValue];
    milliseconds /= 1000;
    return [NSDate dateWithTimeIntervalSince1970:milliseconds];
}

@end
