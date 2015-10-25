//
//  TNSBubbleManager.h
//  TNSBubbleViewController
//
//  Created by Bers on 15/10/24.
//  Copyright © 2015年 Bers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TNSBubbleView.h"
#import "TNSPlayerView.h"

@interface TNSBubbleManager : NSObject

@property (nonatomic) NSMutableArray<TNSBubbleView*>* bubblesArray;
@property (nonatomic) TNSPlayerView *playerView;

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles urls:(NSArray<NSString *> *)urls;
// 重置所有泡泡，按照所给title数组、subtitle数组和url数组的顺序为bubble设置标题、副标题和URL
// 每次最多8个
- (void)resetBubblesWithTitles:(NSArray<NSString*>*)titles
                     subtitles:(NSArray<NSString*>*)subtitles
                          urls:(NSArray<NSString*>*)urls;

- (void)addBubblesToView:(UIView*)superView;

@end
