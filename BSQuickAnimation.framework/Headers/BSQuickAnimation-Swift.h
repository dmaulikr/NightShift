// Generated by Apple Swift version 2.0 (swiftlang-700.0.59 clang-700.0.72)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import Foundation;
@import QuartzCore;
@import CoreGraphics;
@import UIKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIView;

SWIFT_CLASS("_TtC16BSQuickAnimation22BSQuickCustomAnimation")
@interface BSQuickCustomAnimation : NSObject
@property (nonatomic) UIView * __nullable animView;
@property (nonatomic) double fromValue;
@property (nonatomic) double toValue;
@property (nonatomic) double value;
- (void)startAnimation:(NSTimeInterval)duration;
- (void)stopAnimation;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC16BSQuickAnimation29BSQuickCustomElasticAnimation")
@interface BSQuickCustomElasticAnimation : BSQuickCustomAnimation
@property (nonatomic) double elasticFactor;
@property (nonatomic) double period;
- (void)startAnimation:(NSTimeInterval)periodFactor;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC16BSQuickAnimation26BSQuickCustomLoopAnimation")
@interface BSQuickCustomLoopAnimation : BSQuickCustomAnimation
@property (nonatomic) double period;
- (void)startAnimation:(NSTimeInterval)period;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface CALayer (SWIFT_EXTENSION(BSQuickAnimation))

/// frequency = 0 for repeating forever
- (CALayer * __nonnull)flicker:(NSInteger)frequency period:(NSTimeInterval)period;
- (CALayer * __nonnull)stopFlicker;

/// frequency = 0 for repeating forever
- (CALayer * __nonnull)shake:(NSInteger)frequency period:(NSTimeInterval)period amplitude:(double)amplitude transverse:(BOOL)transverse;
- (CALayer * __nonnull)stopShake;
@end

@class UIColor;

@interface CALayer (SWIFT_EXTENSION(BSQuickAnimation))
- (CALayer * __nonnull)moveX:(CGFloat)offset duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)moveX:(CGFloat)offset;
- (CALayer * __nonnull)moveY:(CGFloat)offset duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)moveY:(CGFloat)offset;
- (CALayer * __nonnull)changeOpacity:(CGFloat)toVal duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)changeOpacity:(CGFloat)toVal;
- (CALayer * __nonnull)strokeEndfrom:(CGFloat)fromVal to:(CGFloat)toVal duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)strokeEndfrom:(CGFloat)fromVal to:(CGFloat)toVal;
- (CALayer * __nonnull)scale:(CGFloat)factor duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)scale:(CGFloat)factor;
- (CALayer * __nonnull)rotateZ:(CGFloat)degree duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)rotateZ:(CGFloat)degree;
- (CALayer * __nonnull)rotateY:(CGFloat)degree duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)rotateY:(CGFloat)degree;
- (CALayer * __nonnull)rotateX:(CGFloat)degree duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)rotateX:(CGFloat)degree;
- (CALayer * __nonnull)resettransformWithDuration:(NSTimeInterval)duration;
- (CALayer * __nonnull)resetTranform;
- (CALayer * __nonnull)changeLineWidthTo:(CGFloat)toVal duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)changeLineWidthTo:(CGFloat)toVal;
- (CALayer * __nonnull)changeStrokeColorTo:(UIColor * __nonnull)color duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)changeStrokeColorTo:(UIColor * __nonnull)color;
- (CALayer * __nonnull)changeFillColorTo:(UIColor * __nonnull)color duration:(NSTimeInterval)duration;
- (CALayer * __nonnull)changeFillColorTo:(UIColor * __nonnull)color;
@end


@interface CALayer (SWIFT_EXTENSION(BSQuickAnimation))
- (CALayer * __nonnull)commitAnimationForKey:(NSString * __nonnull)key;
@property (nonatomic, readonly) CALayer * __nonnull removeOnCompletion;
@property (nonatomic, readonly) CALayer * __nonnull then;
@property (nonatomic, readonly) CALayer * __nonnull barrier;
@property (nonatomic, readonly, getter=and) CALayer * __nonnull and_;
- (CALayer * __nonnull)bs_remoevAnim:(NSInteger)atIndex;
- (CALayer * __nonnull)bs_removeAll;
- (CALayer * __nonnull)after:(NSTimeInterval)period;
- (CALayer * __nonnull)delay:(NSTimeInterval)period;
- (CALayer * __nonnull)completion:(void (^ __nonnull)(BOOL))clourse;
@property (nonatomic, readonly) CALayer * __nonnull repeatingForever;
@property (nonatomic, readonly) CALayer * __nonnull linear;
@property (nonatomic, readonly) CALayer * __nonnull easeIn;
@property (nonatomic, readonly) CALayer * __nonnull easeOut;
@property (nonatomic, readonly) CALayer * __nonnull easeInOut;
@end


@interface CALayer (SWIFT_EXTENSION(BSQuickAnimation))
@end


@interface UIView (SWIFT_EXTENSION(BSQuickAnimation))
@end


@interface UIView (SWIFT_EXTENSION(BSQuickAnimation))
- (UIView * __nonnull)moveX:(CGFloat)offset duration:(NSTimeInterval)duration;
- (UIView * __nonnull)moveX:(CGFloat)offset;
- (UIView * __nonnull)moveY:(CGFloat)offset duration:(NSTimeInterval)duration;
- (UIView * __nonnull)moveY:(CGFloat)offset;
- (UIView * __nonnull)scale:(CGFloat)factor duration:(NSTimeInterval)duration;
- (UIView * __nonnull)scale:(CGFloat)factor;
- (UIView * __nonnull)rotate:(CGFloat)degree duration:(NSTimeInterval)duration;
- (UIView * __nonnull)rotate:(CGFloat)degree;
- (UIView * __nonnull)resetTransfromWithDuration:(NSTimeInterval)duration;
- (UIView * __nonnull)resetTranform;
- (UIView * __nonnull)changeAlpha:(CGFloat)factor duration:(NSTimeInterval)duration;
- (UIView * __nonnull)changeAlpha:(CGFloat)factor;
@end


@interface UIView (SWIFT_EXTENSION(BSQuickAnimation))
@property (nonatomic, readonly) UIView * __nonnull then;
@property (nonatomic, readonly) UIView * __nonnull barrier;
@property (nonatomic, readonly, getter=and) UIView * __nonnull and_;
- (UIView * __nonnull)after:(NSTimeInterval)period;
- (UIView * __nonnull)delay:(NSTimeInterval)period;
- (UIView * __nonnull)completion:(void (^ __nonnull)(BOOL))clourse;
@property (nonatomic, readonly) UIView * __nonnull linear;
@property (nonatomic, readonly) UIView * __nonnull easeIn;
@property (nonatomic, readonly) UIView * __nonnull easeOut;
@property (nonatomic, readonly) UIView * __nonnull easeInOut;
@end


@interface UIView (SWIFT_EXTENSION(BSQuickAnimation))
@end

#pragma clang diagnostic pop
