//
//  TNSPlayVideoView.h
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/24.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#import "TNSQiubaiVideoCrawler.h"

@interface TNSVideoPlayer : UIView

// 唯一标识符
@property (nonatomic, copy) NSString *identifier;

// 播放按钮
@property (nonatomic, weak, readonly) UIButton *playBtn;
// 视频播放器
@property (nonatomic, weak, readonly) AVPlayer *player;
// 展示视频的层
@property (nonatomic, weak, readonly) AVPlayerLayer *playerLayer;

// 初始化方法
- (id)initWithFrame:(CGRect)frame identifier:(NSString *)identifier;
//
- (void)setupUIWithIdentifier:(NSString *)identifier;
// 播放
- (void)play;
// 暂停
- (void)pause;

@end
