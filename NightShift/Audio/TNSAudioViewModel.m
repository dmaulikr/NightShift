//
//  TNSAudioPlayer.m
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import "TNSAudioVIewModel.h"

@interface TNSAudioViewModel(){
    NSInteger startNum;
    NSString *AudioTag;
}
@property (nonatomic, strong) TNSAudioWebServices *services;
@end

@implementation TNSAudioViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        startNum = 0;
        _services = [[TNSAudioWebServices alloc] init];
        AudioTag = [NSString string];
    }
    return self;
}

- (void)getAudioInfoWithTag:(NSString *)tag success:(void (^)(NSArray *))success{
    startNum = 0;
    AudioTag = tag;
    [self.services getDBSongInfoWithTag:tag start:startNum success:^(NSArray *array) {
        NSMutableArray *identifierArray = [NSMutableArray array];
        for (TNSAudioInfo *info in array) {
            NSString *identifier = [NSString stringWithFormat:@"audio@%@",info.dbSongID];
            [identifierArray addObject:identifier];
        }
        success(identifierArray);
    }];
}

- (void)refreshWithSuccessBlock:(void (^)(NSArray *))success{
    startNum += 4;
    [self.services getDBSongInfoWithTag:AudioTag start:startNum success:^(NSArray *array) {
        NSMutableArray *identifierArray = [NSMutableArray array];
        for (TNSAudioInfo *info in array) {
            NSString *identifier = [NSString stringWithFormat:@"audio@%@",info.songID];
            [identifierArray addObject:identifier];
        }
        success(identifierArray);
    }];
}

@end
