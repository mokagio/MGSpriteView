//
//  MGSpriteAnimationSequence.h
//
//  Created by Gio on 19/08/2013.
//

#import <Foundation/Foundation.h>
#import "MGSpriteView.h"

@interface MGSpriteAnimationSequence : NSObject

@property (nonatomic, strong, readonly) NSArray *animations;

- (id)initWithAnimations:(NSArray *)animations;

- (void)runWithCallback:(MGSpriteAnimationCallback)callback;

- (void)runLooped;

- (UIView *)view;

- (void)reloadWithAnimations:(NSArray *)animations;

@end
