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
                        @"count":@3
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

- (void)getDBSongInfoWithID:(NSString *)identifier success:(void (^)(NSString *title))success{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/music/%@",identifier]];
    [self.manager GET:[url absoluteString]
           parameters:nil
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  NSString *title = responseObject[@"attrs"][@"title"];
                  success(title);
              } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  NSLog(@"%@",error);
              }];
}

- (void)getBDSongInfoWithInfo:(NSString *)title success:(void (^)(NSString *))callBackBlock{
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://sug.music.baidu.com/info/suggestion?format=json&version=2&from=0&word=%@&_=1405404358299",title] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"absolute string is %@",url.absoluteString);
    [self.manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [self.manager GET:[url absoluteString]
           parameters:nil
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  NSDictionary *dic = responseObject[@"data"][@"song"][0];
                  NSString *string = dic[@"songid"];
                  callBackBlock(string);
              }
              failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  NSLog(@"%@",error);
              }];
    
}

- (void)getBDSongDownloadURLWithSongID:(NSString *)songID success:(void (^)(NSString *))call{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://ting.baidu.com/data/music/links?songIds=%@",songID]];
    [self.manager GET:[url absoluteString]
           parameters:nil
              success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                  NSString *rawurl = responseObject[@"data"][@"songList"][0][@"songLink"];
                  NSString *url = [rawurl substringToIndex:[rawurl rangeOfString:@"\""].location];
                  NSLog(@"%@", url);
                  call(url);
              } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                  NSLog(@"%@",error);
              }];
}


@end
