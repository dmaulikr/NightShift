//
//  TNSBubbleManager.m
//  TNSBubbleViewController
//
//  Created by Bers on 15/10/24.
//  Copyright © 2015年 Bers. All rights reserved.
//

#import "TNSBubbleManager.h"
#import <BSQuickAnimation/BSQuickAnimation.h>

#define BUBBLECOUNT 6

@interface TNSBubbleManager ()<TNSBubbleViewProtocol>

@property (nonatomic) NSArray<NSNumber*>* bubblesRadius;
@property (nonatomic) NSArray<NSValue*>* bubblesLocation;
@property (nonatomic) NSMutableArray<NSString*>* titlesArray;
@property (nonatomic) NSMutableArray<NSString*>* subtitlesArray;
@property (nonatomic) NSMutableArray<NSString*>* urlsArray;

@end

@implementation TNSBubbleManager

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles urls:(NSArray<NSString *> *)urls
{
    self = [super init];
    if (self) {
        _urlsArray = [NSMutableArray arrayWithArray:urls];
        _titlesArray = [NSMutableArray arrayWithArray:titles];
        [self configurBubbles:urls.count];
    }
    return self;
}

- (void)resetBubblesWithTitles:(NSArray<NSString *> *)titles
                     subtitles:(NSArray<NSString *> *)subtitles
                          urls:(NSArray<NSString *> *)urls{
    _urlsArray = [NSMutableArray arrayWithArray:urls];
    _titlesArray = [NSMutableArray arrayWithArray:titles];
    _subtitlesArray = [NSMutableArray arrayWithArray:subtitles];
    for (int i = 0; i<self.bubblesArray.count; ++i) {
            [self.bubblesArray[i] setImage:arc4random() % 6];
    }
    [self configurBubbles:urls.count];

}

- (void)configurBubbles:(NSUInteger)count{
    count %= (BUBBLECOUNT + 1);
    for (int i = 0; i< count; ++i) {
        TNSBubbleView *view = self.bubblesArray[i];
        NSString *url = self.urlsArray[i];
        NSUInteger kind = [[url substringToIndex:5] isEqualToString:@"video"];
        view.bubbleKind = kind;
        [view setUrl:url];
        [view setTitle:self.titlesArray[i]];
    }
}

- (void)addBubblesToView:(UIView *)superView {
    for(int i = 0; i < self.bubblesArray.count ; ++i){
        TNSBubbleView *view = self.bubblesArray[i];
        [superView addSubview:view];
        [self moveBubbleToCenter:view index:i];
        [view startFloatAnimation];
    }
}

- (void)setInitialLocation:(TNSBubbleView*)bubble index:(NSUInteger)index{
    CGPoint loc = [self.bubblesLocation[index] CGPointValue];
    CGFloat centerX = loc.x + (index < BUBBLECOUNT/2 ? (-[UIScreen mainScreen].bounds.size.width / 2): [UIScreen mainScreen].bounds.size.width / 2);
    [bubble setCenter:CGPointMake(centerX, loc.y + bubble.frame.size.height )];
}


- (void)moveBubbleToCenter:(TNSBubbleView*)bubble index:(NSUInteger)index{
    CGFloat deltaY = -bubble.frame.size.height;
    CGFloat deltaX = index < BUBBLECOUNT/2 ?
    ([UIScreen mainScreen].bounds.size.width / 2) :
    -([UIScreen mainScreen].bounds.size.width / 2);
    CGFloat offsetY = (arc4random()%2 ? -1 : 1) * 10;
    [[[[[bubble moveX:deltaX + (index < BUBBLECOUNT/2 ? 5 : -5)] moveY:deltaY + offsetY]
       then] moveX:index < BUBBLECOUNT/2 ? -5 : 5] moveY:-offsetY];

}

#pragma -mark delegate method

- (void)didPressedOnBubble:(TNSBubbleView*)bubble{
    [self.playerView sendIdentifier:[bubble url]];
}


#pragma -mark Getters And Setters

- (NSMutableArray<TNSBubbleView*>*)bubblesArray {
    if (!_bubblesArray) {
        _bubblesArray = [NSMutableArray arrayWithCapacity:BUBBLECOUNT];
        for (int i = 0; i< BUBBLECOUNT; ++i) {
            TNSBubbleView *view = [[TNSBubbleView alloc] initWithFrame:CGRectMake(0, 0, [self.bubblesRadius[i] doubleValue], [self.bubblesRadius[i] doubleValue])];
            view.delegate = self;
            view.bubbleKind = TNSBubbleViewNone;
            [_bubblesArray addObject:view];
            [self setInitialLocation:view index:i];
        }
    }
    return _bubblesArray;
}

- (NSMutableArray<NSString*>*)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [NSMutableArray array];
    }
    return _titlesArray;
}

- (NSMutableArray<NSString*>*)subtitlesArray {
    if (!_subtitlesArray) {
        _subtitlesArray = [NSMutableArray array];
    }
    return _subtitlesArray;
}

- (NSMutableArray<NSString*>*)urlsArray {
    if (!_urlsArray) {
        _urlsArray = [NSMutableArray array];
    }
    return _urlsArray;
}

- (NSArray<NSNumber*>*)bubblesRadius{
    if (!_bubblesRadius){
        _bubblesRadius = @[@67.0, @141.0, @111.0, @91.0, @128.0, @91.0];
    }
    return _bubblesRadius;
}

- (NSArray<NSValue*>*)bubblesLocation{
    if (!_bubblesLocation){
        _bubblesLocation = @[[NSValue valueWithCGPoint:CGPointMake(125, 136)],
                             [NSValue valueWithCGPoint:CGPointMake(124, 290)],
                             [NSValue valueWithCGPoint:CGPointMake(93, 477)],
                             [NSValue valueWithCGPoint:CGPointMake(238, 222)],
                             [NSValue valueWithCGPoint:CGPointMake(240, 392)],
                             [NSValue valueWithCGPoint:CGPointMake(290, 526)]];
    }
    return _bubblesLocation;
}

@end
