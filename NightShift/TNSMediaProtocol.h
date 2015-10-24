//
//  TNSMediaProtocol.h
//  NightShift
//
//  Created by 李超 on 15/10/24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TNSMediaProtocol <NSObject>

- (void)getMediaInfoWithSuccessBlock:(void (^)(NSArray *IdentifierArray))successBlock;
- (void)refreshWithSuccessBlock:(void (^)(NSArray *AudioIdentifierArray))success;
//- (void)showPlayerViewWithIdentifier:(NSString *)identifier;

@end
