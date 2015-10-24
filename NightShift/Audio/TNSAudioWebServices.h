//
//  TNSAudioWebServices.h
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "TNSAudioInfo.h"

@interface TNSAudioWebServices : NSObject

- (void)getDBSongInfoWithTag:(NSString *)tag start:(NSInteger)start success:(void (^)(NSArray *array))callBackBlcok;
- (void)getDBSongInfoWithID:(NSString *)identifier success:(void (^)(NSString *title))success;
- (void)getBDSongInfoWithInfo:(NSString *)title success:(void (^)(NSString *identifier))callBackBlock;
- (void)getBDSongDownloadURLWithSongID:(NSString *)songID success:(void (^)(NSString *downloadURL))success;

@end
