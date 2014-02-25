//
//  MGSpriteView.h
//  MGSpriteView
//
//  Created by mokagio on 10/05/2013.
//

#import <Foundation/Foundation.h>

typedef void (^MGSpriteAnimationCallback)();

typedef enum : NSUInteger {
    MGSpriteViewAnimationModeDisplayLink = 0,
    MGSpriteViewAnimationModeCoreAnimation
} MGSpriteViewAnimationMode;

@interface MGSpriteView : NSObject

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong, readonly) NSArray *sampleRects;
@property (nonatomic, assign, readonly) CGImageRef image;
@property (nonatomic, assign, readonly) CGFloat scaleFactor;
@property (nonatomic, assign, readonly) NSUInteger fps;

// Designate Initailizer
- (id)initWithFrame:(CGRect)frame
              image:(CGImageRef)image
        sampleRects:(NSArray *)sampleRects
        scaleFactor:(CGFloat)scaleFactor
                fps:(NSUInteger)fps;

- (id)initWithFrame:(CGRect)frame
spriteSheetFileName:(NSString *)spriteSheetFilename
                fps:(NSUInteger)fps;

// Base animation method
- (void)runAnimationWithMode:(MGSpriteViewAnimationMode)mode
            completeCallback:(MGSpriteAnimationCallback)callback;
// Shorthands animation methods
- (void)runAnimation;
- (void)runAnimationWithCompleteCallback:(MGSpriteAnimationCallback)callback;
- (void)runAnimationLooped;

- (void)pause;
- (void)stop;

- (CFTimeInterval)duration;

+ (CGFloat)scaleFactorForSampleRects:(NSArray *)sampleRects onRect:(CGRect)rect;

- (void)reloadWithFrame:(CGRect)frame
                  image:(CGImageRef)image
            sampleRects:(NSArray *)sampleRects
            scaleFactor:(CGFloat)scaleFactor
                    fps:(NSUInteger)fps;

@end
