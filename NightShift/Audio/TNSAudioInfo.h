//
//  TNSAudioInfo.h
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface TNSDoubanAudioInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray *title;
@property (nonatomic, strong) NSString *dbSongID;

@end

@interface TNSBaiduAudioInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *songID;

@end

@interface TNSAudioInfo : NSObject

@property (nonatomic, strong) TNSBaiduAudioInfo *baiduAudioInfo;
@property (nonatomic, strong) TNSDoubanAudioInfo *doubanAudioInfo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *songID;
@property (nonatomic, strong) NSString *dbSongID;

@end
