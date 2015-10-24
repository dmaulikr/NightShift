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
@property (nonatomic, strong) UILabel *titleLabel;
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
    self.pauseButton = [[UIButton alloc] initWithFrame:CGRectInset(self.frame, self.frame.size.width/2-22, self.frame.size.height/2-22)];
    [self.pauseButton setImage:[UIImage imageNamed:@"icon_pause_normal"] forState:UIControlStateNormal];
    [self addSubview:self.pauseButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
}

//- (IBAction)pauseButtonTapped:(id)sender {
//    if (self.audioStream.isPlaying) {
//        [self pause];
//#warning 改变图标
//    } else{
//        [self play];
//    }
//}

- (void)setUpUIWithIdentifier:(NSString *)identifier{
    identifier = [identifier substringFromIndex:6];
    [self.services getDBSongInfoWithID:identifier success:^(NSString *title) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = title;
        });
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
    self.titleLabel.text = nil;
}

@end
