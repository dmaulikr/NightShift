//
//  TNSBubbleView.m
//  TNSBubbleViewController
//
//  Created by Bers on 15/10/24.
//  Copyright © 2015年 Bers. All rights reserved.
//

#import "TNSBubbleView.h"
#import <BSQuickAnimation/BSQuickAnimation.h>

@interface TNSBubbleView (){
    CGFloat _radius, _maxDeltaRadius;
    CGFloat _currentDeltaRadius, _deltaOfAxis;
    BOOL _resetAnimating;
    NSTimer * _timer;
    
    NSUInteger _floatAnimFlag;
}

@property (nonatomic) UIImageView *bubbleImgV;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *subtitleLabel;

@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) NSMutableArray<NSNumber*> *axisDeltaCacheForFrames;
@property (nonatomic)  NSTimeInterval revokeDuration;
@property (nonatomic) NSUInteger currentFrame;
@property (nonatomic) NSUInteger totalFrames;



@end

@implementation TNSBubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    self.bubbleKind = TNSBubbleViewNone;
    _radius = 0;
    _maxDeltaRadius = 0;
    _currentDeltaRadius = 0.0;
    _deltaOfAxis = 0.0;
    _resetAnimating = false;
    _floatAnimFlag = arc4random() % 4;
    self.axisDeltaCacheForFrames = [NSMutableArray arrayWithCapacity:60];
    self.backgroundColor = [UIColor clearColor];
}

- (void)didMoveToSuperview {
    _radius = MIN(self.frame.size.width, self.frame.size.height)/2;
    _maxDeltaRadius = _radius * 0.1;
    [self addSubview:self.bubbleImgV];
    [self addSubview:self.titleLabel];
    
}

- (void)startFloatAnimation {
    [self animation];
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.1
                                              target:self selector:@selector(animation) userInfo:nil repeats:YES];
}

- (void)animation{
    switch (_floatAnimFlag) {
        case 0:
            [[[[[[[[[[[self moveX:-2.0] moveY:-2.0] then]
                    moveX:4.0] then]
                  moveY:4.0] then]
                moveX:-4.0] then]
              moveX:2.0] moveY:-2.0];
            break;
        case 1:
            [[[[[[[[[[[self moveX:2.0] moveY:-2.0] then]
                    moveX:-4.0] then]
                  moveY:4.0] then]
                moveX:4.0] then]
              moveX:-2.0] moveY:-2.0];
            break;
        case 2:
            [[[[[[[[[[[self moveX:-2.0] moveY:-2.0] then]
                    moveX:4.0] then]
                  moveY:4.0] then]
                moveX:-4.0] then]
              moveX:2.0] moveY:-2.0];
            break;
        case 3:
            [[[[[[[[[[[self moveX:-2.0] moveY:2.0] then]
                    moveX:4.0] then]
                  moveY:-4.0] then]
                moveX:-4.0] then]
              moveX:2.0] moveY:2.0];
            break;
        default:
            break;
    }

}

- (void)setTitle:(NSString *)title{
//    [self.titleLabel changeAlpha:0.0];
    [self.titleLabel setText:title];
//    [self.titleLabel changeAlpha:1.0];
}

- (void)setSubTitle:(NSString *)subTitle{
    if ([subTitle isEqualToString:@""]) {
        [self removeSubtitle];
    }
//    [self.subtitleLabel changeAlpha:0.0];
    [self.subtitleLabel setText:subTitle];
//    [self.subtitleLabel changeAlpha:1.0];
}

- (void)setImage:(NSUInteger)index {
    NSString *imageName = [NSString stringWithFormat:@"ball%lu.png", index + 1];
    _bubbleImgV.image = [UIImage imageNamed:imageName];
}

- (void)removeSubtitle{
    [_subtitleLabel removeFromSuperview];
    _subtitleLabel = nil;
    _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)startAnimation {
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(increaseLongerAxis)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)completeAnimation {
    self.currentFrame = 0;
    [self.displayLink invalidate];
    self.displayLink = nil;

}

- (void)startResetAnimation {
    if (self.displayLink == nil) {
        _resetAnimating = YES;
        _currentDeltaRadius = _deltaOfAxis;
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(resetAnimationTick)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)resetAnimationTick {
    if ([self.axisDeltaCacheForFrames[self.currentFrame]  isEqual:@-1000.0]) {
        self.axisDeltaCacheForFrames[self.currentFrame] = [NSNumber numberWithDouble:exp(-0.055 * ((CGFloat)self.currentFrame + 3.677)) * sin(M_PI / 8 * (self.currentFrame + 3.677) + M_PI_2)];
    }
    CGFloat delta = 2.0 * _currentDeltaRadius * [self.axisDeltaCacheForFrames[self.currentFrame++] doubleValue];
    _deltaOfAxis = delta;
    [self setNeedsDisplay];
    if (self.currentFrame == self.totalFrames && self.totalFrames != 0) {
        [self completeAnimation];
        _resetAnimating = NO;
        [self startFloatAnimation];
    }

}

- (void)increaseLongerAxis{
    if (++self.currentFrame < 10){
        _deltaOfAxis = 4 * (CGFloat)self.currentFrame / 30.0 * _maxDeltaRadius;
        [self setNeedsDisplay];
    }else{
        [self completeAnimation];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
            [self.layer removeAllAnimations];
    if (self.displayLink == nil) {
        [_timer invalidate];

        [self startAnimation];
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_resetAnimating) {
        [self completeAnimation];
        [self.delegate didPressedOnBubble:self];
        if (_deltaOfAxis < _maxDeltaRadius / 3.0) {
            self.revokeDuration = 0.5;
        }else{
            self.revokeDuration = 1.0;
        }
        [self startResetAnimation];
    }
}

- (void)drawRect:(CGRect)rect{
    CGFloat horizontalAxis = 2*(_radius+_deltaOfAxis);
    CGFloat verticalAxis = 2*(_radius-_deltaOfAxis);
    CGRect ovalFrame = CGRectOffset(CGRectMake(0, 0, horizontalAxis, verticalAxis), -_deltaOfAxis, _deltaOfAxis);
    [self.bubbleImgV setFrame:ovalFrame];
}

#pragma -mark Getters And Setters

- (UIImageView*)bubbleImgV {
    if (!_bubbleImgV) {

        NSString *imageName = [NSString stringWithFormat:@"ball%d.png",  arc4random() % 6 + 1];
        _bubbleImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [_bubbleImgV setFrame:CGRectMake(0, 0, _radius * 2, _radius * 2)];
    }
    return _bubbleImgV;
}

- (UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width /4 * 3, self.frame.size.height / 4)];
        _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel*)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height / 8)];
        _subtitleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + _subtitleLabel.frame.size.height);
        _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - _titleLabel.frame.size.height);
        _subtitleLabel.adjustsFontSizeToFitWidth = YES;
        _subtitleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_subtitleLabel];
    }
    return _subtitleLabel;
}

- (void)setRevokeDuration:(NSTimeInterval)revokeDuration {
    _revokeDuration = revokeDuration;
    self.totalFrames = (NSUInteger)(self.revokeDuration * 60);
    for (NSUInteger i = self.axisDeltaCacheForFrames.count ; i<self.totalFrames; ++i){
        [self.axisDeltaCacheForFrames addObject:[NSNumber numberWithDouble:-1000.0]];
    }
    
}

@end
