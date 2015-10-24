//
//  NSDate+Milliseconds.h
//  YuanQuan
//
//  Created by 陈颖鹏 on 15/10/4.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Milliseconds)

+ (NSNumber *)millisecondsNumberSince1970;
- (NSNumber *)millisecondsNumberSince1970;

+ (NSString *)millisecondsStringSince1970;

+ (NSDate *)dateFromMillisecondsNumberSince1970:(NSNumber *)time;

@end
