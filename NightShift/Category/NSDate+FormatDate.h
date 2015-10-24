//
//  NSDate+FormatDate.h
//  YuanQuan
//
//  Created by 陈颖鹏 on 15/9/13.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (FormatDate)

/**
 *  以“年-月-日 时:分:秒”显示
 *
 *  @return 时间字符串
 */
- (NSString *)presentation_YMDHMS;

/**
 *  以“年-月-日”显示
 *
 *  @return 时间字符串
 */
- (NSString *)presentation_YMD;

/**
 *  用于发表时间的显示
 *
 *  @return eg：x天前，x小时前，x秒前；超过一星期则返回"year-month-day hour:minute:second"
 */
- (NSString *)txtMsg;

+ (NSDateFormatter *)formatterYMDHMS;

+ (NSDateFormatter *)formatterYMD;

@end
