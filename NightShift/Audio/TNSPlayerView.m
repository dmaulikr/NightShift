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
    self.blurView.frame = self.frame;
    [self addSubview:self.blurView];
    
    self.videoPlayer = [[TNSVideoPlayer alloc] initWithFrame:self.frame identifier:nil];
    [self addSubview:self.videoPlayer];
    
    
    self.audioPlayer = [[TNSAudioPlayer alloc] initWithFrame:CGRectInset([[UIScreen mainScreen] bounds], 30, 200)];
    [self addSubview:self.audioPlayer];
}

- (void)getHidden:(UITapGestureRecognizer *)recognizer{
    [self.audioPlayer disappear];
    [self.videoPlayer disappear];
    self.hidden = YES;
}

- (void)sendIdentifier:(NSString *)identifier{
    if ([self isEqualToAudio:identifier]||[self isEqualToVideo:identifier]) {
        self.hidden = NO;
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
}


- (BOOL)isEqualToVideo:(NSString *)string{
    return [[string substringToIndex:5] isEqualToString:@"video"];
}

- (BOOL)isEqualToAudio:(NSString *)string{
    return [[string substringToIndex:5] isEqualToString:@"audio"];
}


@end
