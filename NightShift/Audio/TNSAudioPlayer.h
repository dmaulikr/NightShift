//
//  TNSAudioPlayer.h
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import <Foundation/Foundation.h>
#import <FreeStreamer/FSAudioStream.h>
#import "TNSAudioWebServices.h"

@interface TNSAudioPlayer : FSAudioStream

@property (nonatomic) BOOL isExcuting;

- (void)getAudioInfoWithTag:(NSString *)tag success:(void (^)(NSArray *AudioIdentifierArray))success;
- (void)refreshWithSuccessBlock:(void (^)(NSArray *AudioIdentifierArray))success;


@end
