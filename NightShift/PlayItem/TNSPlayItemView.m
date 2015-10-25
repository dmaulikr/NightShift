//
//  TNSPlayItemView.m
//  TNSBubbleViewController
//
//  Created by Bers on 15/10/25.
//  Copyright © 2015年 Bers. All rights reserved.
//

#import "TNSPlayItemView.h"
#import <CoreMotion/CoreMotion.h>

@interface TNSPlayItemView (){
    UIBezierPath *_bezierPath;
    NSUInteger _boundaryCount;
    CGPoint _lastLocation;
    NSArray<UIColor*>* _brickColor;
}

@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIView *playItem;
@property (nonatomic) UIGravityBehavior *gravity;
@property (nonatomic) UICollisionBehavior *collision;
@property (nonatomic) UIDynamicItemBehavior *itemBehavior;

@property (nonatomic) CMMotionManager *motionManager;

@property (nonatomic) UIPanGestureRecognizer *panGesture;
@property (nonatomic) NSMutableArray<UIBezierPath*> *strokeArray;

@property (nonatomic) NSMutableArray<UIView*>* playItems;

@end

@implementation TNSPlayItemView

- (instancetype)init
{
    self = [super init];
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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    self.motionManager = [[CMMotionManager alloc] init];
    _boundaryCount = 0;
    self.playItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _brickColor = [NSArray arrayWithObjects:
                   [UIColor colorWithRed:91/255.0 green:231/255.0 blue:51/255.0 alpha:1.0f],
                   [UIColor colorWithRed:208/255.0 green:66/255.0 blue:209/255.0 alpha:1.0f],
                   [UIColor colorWithRed:85/255.0 green:102/255.0 blue:235/255.0 alpha:1.0f],
                   [UIColor colorWithRed:235/255.0 green:122/255.0 blue:45/255.0 alpha:1.0f], nil];
    self.playItem.backgroundColor = _brickColor[arc4random()%4];
    
    self.playItems = [NSMutableArray arrayWithObject:self.playItem];
    self.collision = [[UICollisionBehavior alloc] initWithItems:self.playItems];
    self.collision.translatesReferenceBoundsIntoBoundary = YES;
    self.backgroundColor = [UIColor whiteColor];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:_panGesture];
    self.strokeArray = [NSMutableArray array];
}

- (void)didMoveToSuperview {
    [self.playItem setCenter:CGPointMake(CGRectGetMidX(self.bounds), 100)];
    [self addSubview:self.playItem];

}

- (void)reset{
    [self removeAllBoundary];
    [self.animator removeAllBehaviors];
    self.animator = nil;
    [self.playItem setCenter:CGPointMake(CGRectGetMidX(self.bounds), 100)];
    for (int i = 1; i<self.playItems.count; ++i) {
        UIView *view = self.playItems[i];
        [self.gravity removeItem:view];
        [self.collision removeItem:view];
        [view removeFromSuperview];
        [self.playItems removeObjectAtIndex:i];
    }
}

- (void)startAnimation {
    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
}

- (void)startMotion {
    __weak TNSPlayItemView *wself = self;
    [self.motionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        CMAcceleration grav = motion.gravity;
        
        CGPoint point = CGPointMake(grav.x, grav.y);
        double zTheta = 90.0 - fabs(atan2(grav.z,sqrtf(grav.x*grav.x+grav.y*grav.y))/M_PI*180.0);
        
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if(orientation == UIInterfaceOrientationLandscapeLeft) {
            CGFloat t = point.x;
            point.x = -point.y;
            point.y = t;
        }else if (orientation == UIInterfaceOrientationLandscapeRight){
            CGFloat t = point.x;
            point.x = point.y;
            point.y = -t;
        }else if (orientation == UIInterfaceOrientationPortraitUpsideDown){
            point.x *= -1;
            point.y *= -1;
        }
        
        CGVector vector = CGVectorMake(point.x, -point.y);
        wself.gravity.gravityDirection = vector;
        wself.gravity.magnitude = zTheta * 0.02;
    }];
}

- (void)stopMotion {
    [self.motionManager stopDeviceMotionUpdates];
    self.gravity.magnitude = 1.0;
    self.gravity.gravityDirection = CGVectorMake(0.0, 1.0);
}

- (void)handlePan:(UIPanGestureRecognizer*)sender {
    CGPoint location = [sender locationInView:self];

    switch ([sender state]) {
        case UIGestureRecognizerStateBegan:
            _bezierPath = [UIBezierPath bezierPath];
            [_bezierPath setLineWidth:2.0f];
            [_bezierPath moveToPoint:location];
            _lastLocation = location;
            break;
            
        case UIGestureRecognizerStateChanged:
            [_bezierPath addLineToPoint:location];
            [self.collision addBoundaryWithIdentifier:[NSString stringWithFormat:@"Boundary:%lu", (unsigned long)_boundaryCount++] fromPoint:_lastLocation toPoint:location];
            _lastLocation = location;
            [self setNeedsDisplay];
            break;
            
        case UIGestureRecognizerStateEnded:
            [_bezierPath addLineToPoint:location];
            [self.strokeArray addObject:_bezierPath];
            _bezierPath = nil;
            [self.collision addBoundaryWithIdentifier:[NSString stringWithFormat:@"Boundary:%lu", (unsigned long)_boundaryCount++] fromPoint:_lastLocation toPoint:location];
            _lastLocation = location;
            [self setNeedsDisplay];
            break;
        default:
            break;
    }
    
}

- (void)removeAllBoundary {
    [self.strokeArray removeAllObjects];
    [self.collision removeAllBoundaries];
    _boundaryCount = 0;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] setStroke];
    for(UIBezierPath *path in self.strokeArray) {
        [path stroke];
    }
    if (_bezierPath) {
        [_bezierPath stroke];
    }
}

- (void)addAPlayItem{
    UIView *playItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    playItem.backgroundColor = _brickColor[arc4random()%4];
    [self.playItems addObject:playItem];
    [self addSubview:playItem];
    
    [self.gravity addItem:playItem];
    [self.collision addItem:playItem];
}

#pragma -mark Getters And Setters

- (UIDynamicAnimator*)animator{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    }
    return _animator;
}

- (UIGravityBehavior*)gravity {
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] initWithItems:self.playItems];
    }
    return _gravity;
}

- (UICollisionBehavior*)collision{
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] initWithItems:self.playItems];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collision;
}

- (UIDynamicItemBehavior*)itemBehavior {
    if (!_itemBehavior) {
        _itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.playItems];
        _itemBehavior.elasticity = 0.5;
    }
    return _itemBehavior;
}

@end
