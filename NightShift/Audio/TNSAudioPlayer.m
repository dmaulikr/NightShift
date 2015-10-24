//
//  TNSAudioPlayer.m
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import "TNSAudioPlayer.h"

@interface TNSAudioPlayer(){
    NSInteger startNum;
    NSString *AudioTag;
}
@property (nonatomic, strong) TNSAudioWebServices *services;
@end

@implementation TNSAudioPlayer

- (instancetype)init{
    self = [super init];
    if (self) {
        startNum = 0;
        _isExcuting = NO;
        _services = [[TNSAudioWebServices alloc] init];
        AudioTag = [NSString string];
    }
    return self;
}

- (void)getAudioInfoWithTag:(NSString *)tag success:(void (^)(NSArray *))success{
    startNum = 0;
    AudioTag = tag;
    self.isExcuting = YES;
    [self.services getDBSongInfoWithTag:tag start:startNum success:^(NSArray *array) {
        NSMutableArray *identifierArray = [NSMutableArray array];
        for (TNSAudioInfo *info in array) {
            NSString *identifier = [NSString stringWithFormat:@"audio@%@",info.dbSongID];
            [identifierArray addObject:identifier];
        }
        self.isExcuting = NO;
        success(identifierArray);
    }];
}

- (void)refreshWithSuccessBlock:(void (^)(NSArray *))success{
    startNum += 10;
    self.isExcuting = YES;
    [self.services getDBSongInfoWithTag:AudioTag start:startNum success:^(NSArray *array) {
        NSMutableArray *identifierArray = [NSMutableArray array];
        for (TNSAudioInfo *info in array) {
            NSString *identifier = [NSString stringWithFormat:@"audio@%@",info.songID];
            [identifierArray addObject:identifier];
        }
        self.isExcuting = NO;
        success(identifierArray);
    }];
}

@end
