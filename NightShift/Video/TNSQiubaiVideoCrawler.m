//
//  TNSQiubaiVideoCrawler.m
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/24.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import "TNSQiubaiVideoCrawler.h"

static NSString *QiubaiBaseURLString = @"http://qiubai-video.qiushibaike.com/";

@implementation TNSQiubaiVideoCrawler

+ (void)fetchVideosWhenOK:(void (^)(BOOL success, NSArray *identifiers, NSError *error))block
{
    static NSInteger page = 0;
    static NSMutableArray *unusedVideos = nil;
    
    if (!unusedVideos) {
        unusedVideos = [NSMutableArray array];
    }
    
    // 有未用的
    if (unusedVideos.count >= 3) {
        NSArray *returnedArray = [unusedVideos subarrayWithRange:NSMakeRange(0, 3)];
        [unusedVideos removeObjectsInRange:NSMakeRange(0, 3)];
        block(YES, returnedArray, nil);
        return ;
    }
    
    // 糗百扒取视频的URL
    NSString *baseURLStr = @"http://www.qiushibaike.com/video/page/";
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld", baseURLStr, (unsigned long)++page]];
    // 爬取
    [[[NSURLSession sharedSession] dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(NO, nil, error);
            });
        } else {
            // 网页源码
            NSString *HTMLStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableArray *identifiers = [NSMutableArray array];
            
            // 正则匹配
            NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:[NSString stringWithFormat:@"poster=\"%@.*?\\.jpg\"", QiubaiBaseURLString] options:NSRegularExpressionDotMatchesLineSeparators error:nil];
            NSArray *matches = [reg matchesInString:HTMLStr options:NSMatchingReportCompletion range:NSMakeRange(0, HTMLStr.length)];
            
            // 筛选出标识符
            for (NSTextCheckingResult *result in matches) {
                NSRange resultRange = result.range;
                NSString *matchString = [HTMLStr substringWithRange:resultRange];
                NSRange baseURLRange = [matchString rangeOfString:QiubaiBaseURLString];
                NSRange dotRange = [matchString rangeOfString:@"." options:NSBackwardsSearch];
                if (dotRange.location != NSNotFound &&
                    baseURLRange.location != NSNotFound) {
                    
                    NSString *identifier = [matchString substringWithRange:NSMakeRange(baseURLRange.location+baseURLRange.length, dotRange.location-baseURLRange.location-baseURLRange.length)];
                    [identifiers addObject:[TNSQiubaiVideoCrawler identifierWithRawIdentifier:identifier]];
                    
                }
            }
            
            [unusedVideos addObjectsFromArray:identifiers];
            NSArray *returnedArray = [unusedVideos subarrayWithRange:NSMakeRange(0, 3)];
            [unusedVideos removeObjectsInRange:NSMakeRange(0, 3)];
            dispatch_async(dispatch_get_main_queue(), ^{
                block(YES, returnedArray, nil);
            });
        }
        
    }] resume];
}

+ (NSString *)URLString4Poster:(NSString *)identifier
{
    return [NSString stringWithFormat:@"%@%@.jpg", QiubaiBaseURLString, [identifier substringFromIndex:6]];
}

+ (NSString *)URLString4Video:(NSString *)identifier
{
    return [NSString stringWithFormat:@"%@%@.mp4", QiubaiBaseURLString, [identifier substringFromIndex:6]];
}

+ (NSString *)identifierWithRawIdentifier:(NSString *)rawIdentifier
{
    return [@"video@" stringByAppendingString:rawIdentifier];
}

@end
