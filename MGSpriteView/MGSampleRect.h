//
//  MGSampleRect.m
//  MGSpriteView
//
//  Created by mokagio on 16/05/2013.
//

#import <Foundation/Foundation.h>

@interface MGSampleRect : NSObject

@property (nonatomic, readonly, assign) CGRect bounds;
@property (nonatomic, readonly, assign) CGRect contentRect;
@property (nonatomic, readonly, assign) CGPoint offset;
@property (nonatomic, readonly, assign) BOOL rotated;
@property (nonatomic, readonly, assign) CGRect sourceColorRect;
@property (nonatomic, readonly, assign) CGSize sourceSize;

- (id)initWithImageSize:(CGSize)size
                  frame:(CGRect)frame
                 offset:(CGPoint)offset
                rotated:(BOOL)rotated
        sourceColorRect:(CGRect)sourceColorRect
             sourceSize:(CGSize)sourceSize;

- (NSString *)description;

@end
