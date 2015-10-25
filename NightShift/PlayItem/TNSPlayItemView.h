//
//  TNSPlayItemView.h
//  TNSBubbleViewController
//
//  Created by Bers on 15/10/25.
//  Copyright © 2015年 Bers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNSPlayItemView : UIView

- (void)startMotion;
- (void)stopMotion;

- (void)removeAllBoundary;

- (void)reset;
- (void)startAnimation;
- (void)addAPlayItem;

@end
