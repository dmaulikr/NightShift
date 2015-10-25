//
//  TNSAudioInfo.m
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import "TNSAudioInfo.h"

@implementation TNSAudioInfo

- (void)setDoubanAudioInfo:(TNSDoubanAudioInfo *)doubanAudioInfo{
    _doubanAudioInfo = doubanAudioInfo;
    _dbSongID = doubanAudioInfo.dbSongID;
    _title = doubanAudioInfo.title[0];
}

- (void)setBaiduAudioInfo:(TNSBaiduAudioInfo *)baiduAudioInfo{
    _baiduAudioInfo = baiduAudioInfo;
    _songID = baiduAudioInfo.songID;
}

@end

@implementation TNSBaiduAudioInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"songID":@"songid"
             };
}

@end

@implementation TNSDoubanAudioInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"title":@"attrs.title",
             @"dbSongID":@"id"
             };
}


@end