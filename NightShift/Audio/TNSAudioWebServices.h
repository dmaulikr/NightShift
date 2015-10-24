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
- (void)getBDSongInfoWithInfo:(TNSAudioInfo *)info success:(void (^)(TNSAudioInfo *info))callBackBlock;

@end
