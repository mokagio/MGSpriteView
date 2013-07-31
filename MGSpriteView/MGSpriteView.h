//
//  MGSpriteView.h
//  MGSpriteView
//
//  Created by mokagio on 10/05/2013.
//

#import <Foundation/Foundation.h>

typedef void (^MGSpriteAnimationCallback)();

@interface MGSpriteView : NSObject

@property (nonatomic, strong) UIView *view;

// Designate Initailizer
- (id)initWithFrame:(CGRect)frame
              image:(CGImageRef)image
        sampleRects:(NSArray *)sampleRects
        scaleFactor:(CGFloat)scaleFactor
                fps:(NSUInteger)fps;

- (id)initWithFrame:(CGRect)frame
spriteSheetFileName:(NSString *)spriteSheetFilename
                fps:(NSUInteger)fps;

- (void)runAnimation;
- (void)runAnimationWithCompleteCallback:(MGSpriteAnimationCallback)callback;
- (void)runAnimationLooped;

- (CFTimeInterval)duration;

+ (CGFloat)scaleFactorForSampleRects:(NSArray *)sampleRects onRect:(CGRect)rect;

- (void)reloadWithFrame:(CGRect)frame
                  image:(CGImageRef)image
            sampleRects:(NSArray *)sampleRects
            scaleFactor:(CGFloat)scaleFactor
                    fps:(NSUInteger)fps;

@end
