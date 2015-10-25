//
//  TNSQiubaiVideoCrawler.h
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/24.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNSQiubaiVideoCrawler : NSObject

// 抓取糗百视频的链接。
+ (void)fetchVideosWhenOK:(void (^)(BOOL success, NSArray *identifiers, NSError *error))block;

+ (NSString *)URLString4Poster:(NSString *)identifier;
+ (NSString *)URLString4Video:(NSString *)identifier;

@end
