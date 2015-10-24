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
@end

@implementation TNSAudioPlayer


- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    self.audioStream = [[FSAudioStream alloc] initWithUrl:[NSURL URLWithString:@"http://file.qianqian.com//data2/music/18874628/18874628.mp3?xcode=e5b6e8a9cc0ddfe705ffee87c3adb48c&src="]];
    [self.audioStream setVolume:0.5];
    [self.audioStream play];
}

//- (void)setUpUIWithIdentifier:(NSString *)identifier{
//    identifier = [identifier substringFromIndex:6];
//    [self.services getDBSongInfoWithID:identifier success:^(NSString *title) {
//        [self.services getBDSongInfoWithInfo:title success:^(NSString *identifier) {
//            [self.services getBDSongDownloadURLWithSongID:identifier success:^(NSString *downloadURL) {
//                self.url = [NSURL URLWithString:downloadURL];
//                [self.audioStream setUrl:self.url];
//                [self.audioStream setVolume:0.5];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self play];
//                });
//            }];
//        }];
//    }];
//}

@end
