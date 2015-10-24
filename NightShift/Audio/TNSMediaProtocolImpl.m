//
//  TNSMediaProtocolImpl.m
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import "TNSMediaProtocolImpl.h"
#import "TNSQiubaiVideoCrawler.h"
#import "TNSAudioVIewModel.h"

@interface TNSMediaProtocolImpl()
@property (nonatomic, strong) TNSAudioViewModel *audioCatcher;

@end

@implementation TNSMediaProtocolImpl

- (instancetype)init{
    self = [super init];
    if (self) {
        _audioCatcher = [[TNSAudioViewModel alloc] init];
    }
    return self;
}

- (void)getMediaInfoWithSuccessBlock:(void (^)(NSArray *))successBlock{
    NSMutableArray *array = [NSMutableArray array];
    [TNSQiubaiVideoCrawler fetchVideosWhenOK:^(BOOL success, NSArray *identifiers, NSError *error) {
        [array addObjectsFromArray:identifiers];
        if (array.count == 8) {
            successBlock(array);
        }
    }];
    [self.audioCatcher getAudioInfoWithTag:@"轻音乐" success:^(NSArray *AudioIdentifierArray) {
        [array addObjectsFromArray:AudioIdentifierArray];
        if (array.count == 8) {
            successBlock(array);
        }
    }];
}

- (void)refreshWithSuccessBlock:(void (^)(NSArray *))successBlock{
    NSMutableArray *array = [NSMutableArray array];
    [TNSQiubaiVideoCrawler fetchVideosWhenOK:^(BOOL success, NSArray *identifiers, NSError *error) {
        [array addObjectsFromArray:identifiers];
        if (array.count == 8) {
            successBlock(array);
        }
    }];
    [self.audioCatcher refreshWithSuccessBlock:^(NSArray *AudioIdentifierArray) {
        [array addObjectsFromArray:AudioIdentifierArray];
        if (array.count == 8) {
            successBlock(array);
        }
    }];
    
}

@end
