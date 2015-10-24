//
//  TNSDBCenter.h
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/25.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNSDBCenter : NSObject

// 单例
+ (TNSDBCenter *)sharedCenter;

// 插入图片
+ (void)insertRecordIntoNightShiftPhotosTableWithImage:(UIImage *)image takeTime:(NSNumber *)takeTime;

// 从数据库中获取图片
+ (void)selectRecordsOfTodayWhenOK:(void (^)(BOOL success, NSArray *array))block;

@end
