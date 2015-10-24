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
@property (weak, nonatomic) IBOutlet TNSVideoPlayer *videoPlayer;
@property (nonatomic, strong) NSString *identifier;
@end

@implementation TNSPlayerView

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}


- (BOOL)isEqualToVideo:(NSString *)string{
    return [[string substringToIndex:5] isEqualToString:@"video"];
}

- (BOOL)isEqualToAudio:(NSString *)string{
    return [[string substringToIndex:5] isEqualToString:@"audio"];
}


@end
