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
@property (nonatomic, copy) MGSpriteAnimationCallback callback;
@end


@implementation MGSpriteAnimationSequence

- (id)initWithAnimations:(NSArray *)animations
{
    self = [super init];
    if (self) {
        self.animations = animations;
        self.animationIndex = 0;
        self.callback = nil;
        
        // We need another instance of the animation because we're gonna reload it's settings
        // and we don't want to change the original ones, as doing this would do:
        // self.currentAnimation = self.animations[self.animationIndex];
        self.currentAnimation = [[MGSpriteView alloc] initWithFrame:CGRectZero
                                                spriteSheetFileName:nil
                                                                fps:0];
        MGSpriteView *newAnimation = self.animations[self.animationIndex];
        [self.currentAnimation reloadWithFrame:newAnimation.view.frame
                                         image:newAnimation.image
                                   sampleRects:newAnimation.sampleRects
                                   scaleFactor:newAnimation.scaleFactor
                                           fps:newAnimation.fps];
    }
    return self;
}

- (void)dealloc
{
	NSLog(@"### dealloc %@",NSStringFromClass([self class]));
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
    frame.origin = self.currentAnimation.view.frame.origin;
    [self.currentAnimation reloadWithFrame:frame
                                     image:newAnimation.image
                               sampleRects:newAnimation.sampleRects
                               scaleFactor:newAnimation.scaleFactor
                                       fps:newAnimation.fps];
    
	__weak typeof(self) bself = self;
    [self.currentAnimation runAnimationWithMode:MGSpriteViewAnimationModeDisplayLink
                               completeCallback:^{
                                   bself.animationIndex++;
                                   if (bself.animationIndex < [bself.animations count]) {
                                       [bself runCurrentAnimation];
                                   } else {
                                       if (bself.callback) bself.callback();
                                   }
                               }];
}

- (void)runLooped
{
	__weak typeof(self) bself = self;
    [self runWithCallback:^{
        [bself runLooped];
    }];
}

#pragma mark - Reload

- (void)reloadWithAnimations:(NSArray *)animations
{
    self.animations = animations;
    self.animationIndex = 0;
    self.callback = nil;
    MGSpriteView *newAnimation = self.animations[self.animationIndex];
    CGRect frame = newAnimation.view.frame;
    frame.origin = self.currentAnimation.view.frame.origin;
    [self.currentAnimation reloadWithFrame:frame
                                     image:newAnimation.image
                               sampleRects:newAnimation.sampleRects
                               scaleFactor:newAnimation.scaleFactor
                                       fps:newAnimation.fps];
}

#pragma mark - Pause

- (void)pause
{
    [self.currentAnimation pause];
}

#pragma mark - View

- (UIView *)view
{
    return self.currentAnimation.view;
}

@end
