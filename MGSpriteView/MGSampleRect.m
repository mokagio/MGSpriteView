//
//  MGSampleRect.m
//  MGSpriteView
//
//  Created by mokagio on 16/05/2013.
//

#import "MGSampleRect.h"

@interface MGSampleRect ()
@property (nonatomic, assign) CGRect    bounds;
@property (nonatomic, assign) CGRect    contentRect;
@property (nonatomic, assign) CGPoint   offset;
@property (nonatomic, assign) BOOL      rotated;
@property (nonatomic, assign) CGRect    sourceColorRect;
@property (nonatomic, assign) CGSize    sourceSize;
@property (nonatomic, retain) NSString  *name;
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
    return [self initWithImageSize:size
                             frame:frame
                            offset:offset
                           rotated:rotated
                   sourceColorRect:sourceColorRect
                        sourceSize:sourceSize
                             named:nil];
}

- (id)initWithImageSize:(CGSize)size
                  frame:(CGRect)frame
                 offset:(CGPoint)offset
                rotated:(BOOL)rotated
        sourceColorRect:(CGRect)sourceColorRect
             sourceSize:(CGSize)sourceSize
                  named:(NSString *)name
{
    self = [super init];
    if (self) {
        
        CGFloat factor = [[UIScreen mainScreen] scale] == 1.0 ? 0.5 : 1.0;
        self.rotated = rotated;
        self.name = name ? name : nil;
        
        if (self.rotated) {
            if (name) { // for atlas of iOS 7 Sprite Kit
                self.contentRect = CGRectMake(frame.origin.x * factor / size.width,
                                              frame.origin.y * factor / size.height,
                                              frame.size.width * factor / size.width,
                                              frame.size.height * factor / size.height);
                self.bounds = CGRectMake(0,
                                         0,
                                         frame.size.width * factor,
                                         frame.size.height * factor);
            }
            else {
                self.contentRect = CGRectMake(frame.origin.x * factor / size.width,
                                              frame.origin.y * factor / size.height,
                                              frame.size.height * factor / size.width,
                                              frame.size.width * factor / size.height);
                self.bounds = CGRectMake(0,
                                         0,
                                         frame.size.height * factor,
                                         frame.size.width * factor);
            }
        } else {
            self.contentRect = CGRectMake(frame.origin.x * factor / size.width,
                                          frame.origin.y * factor / size.height,
                                          frame.size.width * factor / size.width,
                                          frame.size.height * factor / size.height);
            self.bounds = CGRectMake(0,
                                     0,
                                     frame.size.width * factor,
                                     frame.size.height * factor);
        }
        
        // WHY + and - ? May be bec
        self.offset = CGPointMake(-offset.x * factor, offset.y * factor);
                
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

- (NSString *)description
{
    return [NSString stringWithFormat:@"MGSampleRect: { bounds: %@\n"
            "contentRect: %@, "
            "offset: %@, "
            "rotated: %@, "
            "sourceColorRect: %@, "
            "sourceSize: %@"
            "name: %@",
            NSStringFromCGRect(self.bounds),
            NSStringFromCGRect(self.contentRect),
            NSStringFromCGPoint(self.offset),
            self.rotated ? @"YES" : @"NO",
            NSStringFromCGRect(self.sourceColorRect),
            NSStringFromCGSize(self.sourceSize),
            self.name];
}

@end
