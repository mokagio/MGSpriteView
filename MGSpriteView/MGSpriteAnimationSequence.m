//
//  MGSpriteAnimationSequence.m
//
//  Created by Gio on 19/08/2013.
//

#import "MGSpriteAnimationSequence.h"


@interface MGSpriteAnimationSequence ()
@property (nonatomic, strong) NSArray *animations;
@property (nonatomic, assign) NSUInteger animationIndex;
@property (nonatomic, strong) MGSpriteView *currentAnimation;
@property (nonatomic, strong) MGSpriteAnimationCallback callback;
@end


@implementation MGSpriteAnimationSequence

- (id)initWithAnimations:(NSArray *)animations
{
    self = [super init];
    if (self) {
        self.animations = animations;
        self.animationIndex = 0;
        self.callback = nil;
        self.currentAnimation = self.animations[self.animationIndex];
    }
    return self;
}

- (void)runWithCallback:(MGSpriteAnimationCallback)callback
{
    self.animationIndex = 0;
    self.callback = callback;
    [self runCurrentAnimation];
}

- (void)runCurrentAnimation
{
    CGRect currentFrame = self.currentAnimation.view.frame;
    
    MGSpriteView *newAnimation = self.animations[self.animationIndex];
    
    CGRect frame = newAnimation.view.frame;
    frame.origin = currentFrame.origin;
    CGImageRef image = newAnimation.image;
    NSArray *samples = newAnimation.sampleRects;
    CGFloat scaleFactor = newAnimation.scaleFactor;
    NSUInteger fps = newAnimation.fps;
    [self.currentAnimation reloadWithFrame:frame
                                     image:image
                               sampleRects:samples
                               scaleFactor:scaleFactor
                                       fps:fps];
    
    [self.currentAnimation runAnimationWithMode:MGSpriteViewAnimationModeDisplayLink
                               completeCallback:^{
                                   if (self.animationIndex + 1 == [self.animations count]) {
                                       if (self.callback) self.callback();
                                   } else {
                                       self.animationIndex++;
                                       [self runCurrentAnimation];
                                   }
                               }];
}

- (void)runLooped
{
    [self runWithCallback:^{
        [self runLooped];
    }];
}

#pragma mark - Reload

- (void)reloadWithAnimations:(NSArray *)animations
{
    self.animations = animations;
    self.animationIndex = 0;
    self.callback = nil;
    self.currentAnimation = self.animations[self.animationIndex];
}

#pragma mark - View

- (UIView *)view
{
    return self.currentAnimation.view;
}

@end
