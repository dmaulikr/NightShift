//
//  TNSPlayerView.m
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import "TNSPlayerView.h"
#import "TNSVideoPlayer.h"

@interface TNSPlayerView ()
@property (strong, nonatomic) TNSVideoPlayer *videoPlayer;
@property (strong, nonatomic) TNSAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSString *identifier;
@property (strong, nonatomic) UIVisualEffectView *blurView;
@end

@implementation TNSPlayerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getHidden:)]];
        [self initLayOut];
    }
    return self;
}

- (void)initLayOut{
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.blurView.frame = self.bounds;
    [self addSubview:self.blurView];
    
    self.videoPlayer = [[TNSVideoPlayer alloc] initWithFrame:CGRectInset(self.bounds, 0, self.frame.size.height/2-self.frame.size.width/2) identifier:nil];
    self.videoPlayer.hidden = YES;
    [self addSubview:self.videoPlayer];
    
    
    self.audioPlayer = [[TNSAudioPlayer alloc] initWithFrame:CGRectInset(self.bounds, 20, 100) Identifier:nil];
    self.audioPlayer.hidden = YES;
    [self addSubview:self.audioPlayer];
}

- (void)getHidden:(UITapGestureRecognizer *)recognizer{
    [UIView animateWithDuration:1.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.audioPlayer disappear];
        [self.videoPlayer disappear];
    }];
}

- (void)sendIdentifier:(NSString *)identifier{
    NSLog(@"%@",identifier);
    self.hidden = NO;
    if ([self isEqualToAudio:identifier]||[self isEqualToVideo:identifier]) {
        [self.superview bringSubviewToFront:self];
    }
    if ([self isEqualToAudio:identifier]) {
        self.audioPlayer.hidden = NO;
        [self bringSubviewToFront:self.audioPlayer];
        [self.audioPlayer setUpUIWithIdentifier:identifier];
    } else if ([self isEqualToVideo:identifier]){
        self.videoPlayer.hidden = NO;
        [self bringSubviewToFront:self.videoPlayer];
        [self.videoPlayer setupUIWithIdentifier:identifier];
        [self.videoPlayer play];
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.5;
    }];
}


- (BOOL)isEqualToVideo:(NSString *)string{
    return [[string substringToIndex:5] isEqualToString:@"video"];
}

- (BOOL)isEqualToAudio:(NSString *)string{
    return [[string substringToIndex:5] isEqualToString:@"audio"];
}


@end
