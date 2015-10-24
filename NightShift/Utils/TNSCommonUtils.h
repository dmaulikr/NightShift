//
//  TNSCommonUtils.h
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/24.
//
//

#import <UIKit/UIKit.h>

@interface TNSCommonUtils : NSObject

// 检查字符串是否为空
+ (BOOL)isStrEmpty:(NSString *)str;

// 返回一个UIFont对象
+ (UIFont *)setFontSize:(float)fontSize;

// 返回颜色值，默认alpha为1.0
+ (UIColor *)setR:(int)r G:(int)g B:(int)b;
// 返回颜色值
+ (UIColor *)setR:(int)r G:(int)g B:(int)b alpha:(float)alpha;

@end