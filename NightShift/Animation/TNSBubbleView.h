//
//  TNSBubbleView.h
//  TNSBubbleViewController
//
//  Created by Bers on 15/10/24.
//  Copyright © 2015年 Bers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TNSBubbleViewKind) {
    TNSAudioBubbleView,
    TNSVideoBubbleView,
    TNSBubbleViewNone
};

@class TNSBubbleView;

@protocol TNSBubbleViewProtocol <NSObject>

- (void)didPressedOnBubble:(TNSBubbleView*)bubble;

@end

@interface TNSBubbleView : UIView

@property TNSBubbleViewKind bubbleKind;

@property (weak, nonatomic) id<TNSBubbleViewProtocol> delegate;
@property (nonatomic, copy) NSString *url;

- (void)setTitle:(NSString*)title;
- (void)setSubTitle:(NSString*)subTitle;
- (void)setImage:(NSUInteger)index;

- (void)startFloatAnimation;

@end
