//
//  MGSpriteView.h
//  MGSpriteView
//
//  Created by mokagio on 10/05/2013.
//

#import <Foundation/Foundation.h>

@interface MGSpriteView : NSObject

@property (nonatomic, strong) UIView *view;

- (id)initWithFrame:(CGRect)frame
spriteSheetFileName:(NSString *)spriteSheetFilename
                fps:(NSUInteger)fps;

- (void)runAnimation;

- (CFTimeInterval)duration;

@end
