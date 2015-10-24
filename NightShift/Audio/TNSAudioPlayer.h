//
//  TNSAudioPlayer.h
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import <Foundation/Foundation.h>
#import <FreeStreamer/FSAudioStream.h>

@interface TNSAudioPlayer : UIView

- (instancetype)initWithIdentifier:(NSString *)identifier;
- (void)setUpUIWithIdentifier:(NSString *)identifier;
- (void)play;
- (void)stop;
- (void)pause;
- (void)disappear;

@end
