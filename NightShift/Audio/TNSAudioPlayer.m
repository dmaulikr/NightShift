//
//  TNSAudioPlayer.m
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import "TNSAudioWebServices.h"
#import "TNSAudioPlayer.h"

@interface TNSAudioPlayer()
@property (nonatomic, strong) TNSAudioWebServices *services;
@property (nonatomic, strong) FSAudioStream *audioStream;
@property (nonatomic, strong) UIButton *pauseButton;
//@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TNSAudioPlayer


- (instancetype)initWithFrame:(CGRect)frame Identifier:(NSString *)identifier{
    self = [super initWithFrame:frame];
    if (self) {
        _services = [[TNSAudioWebServices alloc] init];
        _audioStream = [[FSAudioStream alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        [self initLayOut];
    }
    return self;
}

- (void)initLayOut{
    self.pauseButton = [[UIButton alloc] initWithFrame:CGRectInset(self.bounds, self.frame.size.width/2-22, self.frame.size.height/2-22)];
    [self.pauseButton setImage:[UIImage imageNamed:@"icon_pause_normal"] forState:UIControlStateNormal];
    [self.pauseButton addTarget:self action:@selector(pauseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.pauseButton];
    
//    CGRect frame = self.pauseButton.bounds;
//    frame.size.width = self.frame.size.width;
//    frame.origin.y += 100;
//    self.titleLabel = [[UILabel alloc] initWithFrame:frame];
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:self.titleLabel];
    
}

- (void)pauseButtonTapped:(id)sender {
    [self pause];
    if (!self.audioStream.isPlaying) {
        [self.pauseButton setImage:[UIImage imageNamed:@"icon_play_normal"] forState:UIControlStateNormal];
    } else{
        [self.pauseButton setImage:[UIImage imageNamed:@"icon_pause_normal"] forState:UIControlStateNormal];
    }
}

- (void)setUpUIWithIdentifier:(NSString *)identifier{
    identifier = [identifier substringFromIndex:6];
    [self.services getDBSongInfoWithID:identifier success:^(NSString *title) {
        [self.services getBDSongInfoWithInfo:title success:^(NSString *identifier) {
            [self.services getBDSongDownloadURLWithSongID:identifier success:^(NSString *downloadURL) {
                [self.audioStream setUrl:[NSURL URLWithString:downloadURL]];
                [self.audioStream setVolume:0.5];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self play];
                });
            }];
        }];
    }];
}

- (void)play{
    [self.audioStream play];
}

- (void)pause{
    [self.audioStream pause];
}

- (void)stop{
    [self.audioStream stop];
}

- (void)disappear{
    [self stop];
    self.hidden = YES;
}

@end