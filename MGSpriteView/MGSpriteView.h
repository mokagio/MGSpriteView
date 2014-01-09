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

- (id)initWithFrame:(CGRect)frame
spriteSheetFileName:(NSString *)spriteSheetFilename
                fps:(NSUInteger)fps;

- (void)runAnimation;
- (void)runAnimationWithCompleteCallback:(MGSpriteAnimationCallback)callback;

- (CFTimeInterval)duration;

#pragma mark - Compatible with iOS 7 Sprite Kit
- (id)initWithFrame:(CGRect)frame
         atlasNamed:(NSString *)atlasName
                fps:(NSUInteger)fps;

@end
