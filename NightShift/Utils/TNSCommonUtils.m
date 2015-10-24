//
//  TNSCommonUtils.m
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/24.
//
//

#import "TNSCommonUtils.h"

@implementation TNSCommonUtils

+ (BOOL)isStrEmpty:(NSString *)str
{
    return !str || str.length==0;
}

+ (UIFont *)setFontSize:(float)fontSize
{
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIColor *)setR:(int)r G:(int)g B:(int)b
{
    return [TNSCommonUtils setR:r G:g B:b alpha:1.0];
}

+ (UIColor *)setR:(int)r G:(int)g B:(int)b alpha:(float)alpha
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

@end