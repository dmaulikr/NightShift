//
//  TNSPlayVideoView.m
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/24.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import "TNSVideoPlayer.h"

@implementation TNSVideoPlayer

- (id)initWithFrame:(CGRect)frame identifier:(NSString *)identifier
{
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = identifier;
        [self setupUIWithIdentifier:identifier];
    }
    return self;
}

- (void)setupUIWithIdentifier:(NSString *)identifier
{
    self.identifier = identifier;
    if (self.identifier) {
        NSURL *url = [NSURL URLWithString:[TNSQiubaiVideoCrawler URLString4Video:self.identifier]];
        AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
        layer.frame = self.layer.bounds;
        [self.layer addSublayer:layer];
        
        _player = player;
        _playerLayer = layer;
        
        UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeSystem];
#warning 未设置播放按钮图片
        [playBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
        _playBtn = playBtn;
    }
}

- (void)play
{
    [self.player play];
}

- (void)pause
{
    [self.player pause];
}

// 为了避免内存泄露进行手动释放
- (void)dealloc
{
    [self.player pause];
    [self.playerLayer removeFromSuperlayer];
    
    _player = nil;
    _player = nil;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.playerLayer.frame = self.layer.bounds;
    self.playBtn.center = CGPointMake(rect.size.width/2, rect.size.height/2);
}

- (void)disappear{
    self.hidden = YES;
    [self pause];
}

@end
