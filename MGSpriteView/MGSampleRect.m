//
//  MGSampleRect.m
//  MGSpriteView
//
//  Created by mokagio on 16/05/2013.
//

#import "MGSampleRect.h"

@interface MGSampleRect ()
@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, assign) BOOL rotated;
@property (nonatomic, assign) CGRect sourceColorRect;
@property (nonatomic, assign) CGSize sourceSize;
@end

@implementation MGSampleRect

#pragma mark - Designated Initializer

- (id)initWithImageSize:(CGSize)size
                  frame:(CGRect)frame
                 offset:(CGPoint)offset
                rotated:(BOOL)rotated
        sourceColorRect:(CGRect)sourceColorRect
             sourceSize:(CGSize)sourceSize
{
    self = [super init];
    if (self) {
		
        self.rotated = rotated;
		
        if (self.rotated) {
            self.contentRect = CGRectMake(frame.origin.x / size.width,
                                          frame.origin.y / size.height,
                                          frame.size.height / size.width,
                                          frame.size.width / size.height);
            self.bounds = CGRectMake(0,
                                     0,
                                     frame.size.height,
                                     frame.size.width);
        } else {
            self.contentRect = CGRectMake(frame.origin.x / size.width,
                                          frame.origin.y / size.height,
                                          frame.size.width / size.width,
                                          frame.size.height / size.height);
            self.bounds = CGRectMake(0,
                                     0,
                                     frame.size.width,
                                     frame.size.height);
        }
        
        // WHY + and - ? May be bec
        self.offset = CGPointMake(offset.x, -offset.y);
        
        self.sourceColorRect = sourceColorRect;
        self.sourceSize = sourceSize;
    }
    return self;
}

#pragma mark - NSObject

- (id)init
{
    return [self initWithImageSize:CGSizeZero
                             frame:CGRectZero
                            offset:CGPointZero
                           rotated:NO
                   sourceColorRect:CGRectZero
                        sourceSize:CGSizeZero];
}

@end
