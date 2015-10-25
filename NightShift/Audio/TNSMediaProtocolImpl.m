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
        _isLoading = NO;
    }
    return self;
}

- (void)getMediaInfoWithSuccessBlock:(void (^)(NSArray *))successBlock{
    self.isLoading = YES;
    NSMutableArray *array = [NSMutableArray array];
    [TNSQiubaiVideoCrawler fetchVideosWhenOK:^(BOOL success, NSArray *identifiers, NSError *error) {
        [array addObjectsFromArray:identifiers];
        if (array.count == 6) {
            successBlock(array);
            self.isLoading = NO;
        }
    }];
    [self.audioCatcher getAudioInfoWithTag:@"轻音乐" success:^(NSArray *AudioIdentifierArray) {
        [array addObjectsFromArray:AudioIdentifierArray];
        if (array.count == 6) {
            successBlock(array);
            self.isLoading = NO;
        }
    }];
}

- (void)refreshWithSuccessBlock:(void (^)(NSArray *))successBlock{
    self.isLoading = YES;
    NSMutableArray *array = [NSMutableArray array];
    [TNSQiubaiVideoCrawler fetchVideosWhenOK:^(BOOL success, NSArray *identifiers, NSError *error) {
        [array addObjectsFromArray:identifiers];
        if (array.count == 6) {
            successBlock(array);
            self.isLoading = NO;
        }
    }];
    [self.audioCatcher refreshWithSuccessBlock:^(NSArray *AudioIdentifierArray) {
        [array addObjectsFromArray:AudioIdentifierArray];
        if (array.count == 6) {
            successBlock(array);
            self.isLoading = NO;
        }
    }];
    
}

@end
