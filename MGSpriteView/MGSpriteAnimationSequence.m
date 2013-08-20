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
    MGSpriteView *newAnimation = self.animations[self.animationIndex];
    CGRect frame = newAnimation.view.frame;
    if (self.animationIndex > 0) frame.origin = self.currentAnimation.view.frame.origin;
    [self.currentAnimation reloadWithFrame:frame
                                     image:newAnimation.image
                               sampleRects:newAnimation.sampleRects
                               scaleFactor:newAnimation.scaleFactor
                                       fps:newAnimation.fps];
    
    [self.currentAnimation runAnimationWithMode:MGSpriteViewAnimationModeDisplayLink
                               completeCallback:^{
                                   self.animationIndex++;
                                   if (self.animationIndex < [self.animations count]) {
                                       [self runCurrentAnimation];
                                   } else {
                                       if (self.callback) self.callback();
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
