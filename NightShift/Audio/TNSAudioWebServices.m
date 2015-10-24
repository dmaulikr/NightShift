//
//  TNSAudioWebServices.m
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import "TNSAudioWebServices.h"
#import <AFNetworking/AFNetworking.h>

@interface TNSAudioWebServices()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation TNSAudioWebServices

- (instancetype)init{
    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (void)getDBSongInfoWithTag:(NSString *)tag start:(NSInteger)start success:(void (^)(NSArray *))callBackBlcok{
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/music/search"];
    [self.manager GET:[url absoluteString]
           parameters:@{
                        @"tag":tag,
                        @"start":[NSNumber numberWithInteger:start],
                        @"count":@10
                        }
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  NSArray *audionArray = responseObject[@"musics"];
                  NSMutableArray *array = [NSMutableArray array];
                  NSError *error;
                  for (NSDictionary *dic in audionArray) {
                      TNSAudioInfo *audioInfo = [[TNSAudioInfo alloc] init];
                      audioInfo.doubanAudioInfo = [MTLJSONAdapter modelOfClass:[TNSDoubanAudioInfo class]
                                                            fromJSONDictionary:dic
                                                                         error:&error];
                      if (error) {
                          NSLog(@"%@",error);
                      }
                      [array addObject:audioInfo];
                  }
                  callBackBlcok(array);
              }
              failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  NSLog(@"%@",error);
              }];
}

- (void)getBDSongInfoWithInfo:(TNSAudioInfo *)info success:(void (^)(TNSAudioInfo *info))callBackBlock{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://sug.music.baidu.com/info/suggestion?format=json&version=2&from=0&word=%@&_=1405404358299",info.title]];
    [self.manager GET:[url absoluteString]
           parameters:nil
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  NSError *error;
                  NSDictionary *dic = responseObject[@"data"][@"song"][0];
                  info.baiduAudioInfo = [MTLJSONAdapter modelOfClass:[TNSBaiduAudioInfo class]
                                                  fromJSONDictionary:dic
                                                               error:&error];
                  if (error) {
                      NSLog(@"%@",error);
                  }
                  callBackBlock(info);
              }
              failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  NSLog(@"%@",error);
              }];
    
}


@end
