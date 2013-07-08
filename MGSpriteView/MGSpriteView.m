//
//  MGSpriteView.m
//  MGSpriteView
//
//  Created by mokagio on 10/05/2013.
//

#import "MGSpriteView.h"
#import "MGSpriteSheetParser.h"
#import "MGSampleRect.h"
#import "MCSpriteLayer.h"

@interface MGSpriteView ()
@property (nonatomic, strong) MCSpriteLayer *animatedLayer;
@property (nonatomic, strong) NSArray *sampleRects;
@property (nonatomic, assign) NSUInteger fps;
@property (nonatomic, assign) CGFloat scaleFactor;
@property (nonatomic, strong) MGSpriteAnimationCallback completeCallback;
- (NSUInteger)numberOfFrames;
- (void)setPositionWithSample:(MGSampleRect *)sample;
- (void)setTransformWithSample:(MGSampleRect *)sample;
@end

@implementation MGSpriteView

#pragma mark - Designated Initializer

- (id)initWithFrame:(CGRect)frame
              image:(CGImageRef)image
        sampleRects:(NSArray *)sampleRects
        scaleFactor:(CGFloat)scaleFactor
                fps:(NSUInteger)fps
{
    self = [super init];
    if (self) {
        
        self.view = [[UIView alloc] initWithFrame:frame];
        self.fps = fps;
        self.completeCallback = nil;
        self.sampleRects = sampleRects;
        self.scaleFactor = scaleFactor;
        self.animatedLayer = [MCSpriteLayer layerWithImage:image];
        self.animatedLayer.delegate = self;
        
        [self.view.layer addSublayer:self.animatedLayer];
        [self.animatedLayer setNeedsDisplay];
    }
    return self;
}

#pragma mark -


- (id)initWithFrame:(CGRect)frame
spriteSheetFileName:(NSString *)spriteSheetFilename
                fps:(NSUInteger)fps
{
    CGImageRef image = [[UIImage imageNamed:spriteSheetFilename] CGImage];
    NSString *plistFileName = [spriteSheetFilename stringByDeletingPathExtension];
    plistFileName = [plistFileName stringByAppendingPathExtension:@"plist"];
    MGSpriteSheetParser *parser = [[MGSpriteSheetParser alloc] init];
    parser.imageRef = image;
    NSArray *sampleRects = [parser sampleRectsFromFileAtPath:plistFileName];
    CGFloat scaleFactor = [MGSpriteView scaleFactorForSampleRects:sampleRects
                                                           onRect:frame];
    
    return [self initWithFrame:frame
                         image:image
                   sampleRects:sampleRects
                   scaleFactor:scaleFactor
                           fps:fps];
}

- (void)runAnimation
{
    [self runAnimationWithCompleteCallback:nil];
}

- (void)runAnimationWithCompleteCallback:(MGSpriteAnimationCallback)callback
{
    self.completeCallback = callback;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"sampleIndex"];
    anim.fromValue = [NSNumber numberWithInt:1];
    anim.toValue = [NSNumber numberWithInt:self.numberOfFrames + 1];
    anim.duration = [self duration];
    anim.repeatCount = 1;
    [self.animatedLayer addAnimation:anim forKey:nil];
}

- (void)runAnimationLooped
{
    [self runAnimationWithCompleteCallback:^{
        [self runAnimationLooped];
    }];
}

#pragma mark - Getters

- (CFTimeInterval)duration
{
    return (1.0 / self.fps) * self.numberOfFrames;
}

- (NSUInteger)numberOfFrames
{
    return [self.sampleRects count];
}

#pragma mark - CALayer Delegate

- (void)displayLayer:(CALayer *)layer;
{
    if (layer == self.animatedLayer) {
        MCSpriteLayer *spriteLayer = (MCSpriteLayer*)layer;
        unsigned int index = [spriteLayer currentSampleIndex];
        MGSampleRect *sample = nil;
        
        if (index == 0) {
            sample = self.sampleRects[index];
        } else {
            sample = self.sampleRects[index - 1];
        }
        
        [self displayAnimatedLayerWithSample:sample];
        
        if (index >= [self.sampleRects count] && self.completeCallback) {
            MGSpriteAnimationCallback refToCallback = self.completeCallback;
            // HACK---
            // The callback runs 5 times! How is that?!
            //NSLog(@"Animation complete. Index %d", index);
            self.completeCallback = nil;
            // ---HACK
            refToCallback();
        }
    }
}

#pragma mark - 

- (void)displayAnimatedLayerWithSample:(MGSampleRect *)sample
{
    self.animatedLayer.bounds = sample.bounds;
    self.animatedLayer.contentsRect = sample.contentRect;
    [self setPositionWithSample:sample];
    [self setTransformWithSample:sample];
}

- (void)setPositionWithSample:(MGSampleRect *)sample
{
    CGFloat evaluatedOffsetX = 0;
    CGFloat evaluatedOffsetY = 0;
    
    evaluatedOffsetX = sample.offset.x;
    evaluatedOffsetY = sample.offset.y;
    
    CGFloat x = self.view.layer.frame.size.width / 2 + evaluatedOffsetX * self.scaleFactor;
    CGFloat y = self.view.layer.frame.size.height / 2 + evaluatedOffsetY * self.scaleFactor;
    self.animatedLayer.position = CGPointMake(x, y);
}

- (void)setTransformWithSample:(MGSampleRect *)sample
{
    CATransform3D rotation = CATransform3DIdentity;
    if (sample.rotated) {
        rotation = CATransform3DMakeRotation(-M_PI_2, 0.0, 0.0, 1.0);
    }
    
    CATransform3D scale = CATransform3DMakeScale(self.scaleFactor, self.scaleFactor, 0.0);
    
    self.animatedLayer.transform = CATransform3DConcat(rotation, scale);
}

#pragma mark - Scaling

+ (CGFloat)scaleFactorForSampleRects:(NSArray *)sampleRects onRect:(CGRect)rect
{
    CGFloat maxWidth = 0;
    CGFloat maxHeight = 0;
    for (MGSampleRect *sampleRect in sampleRects) {
        CGFloat width = sampleRect.rotated ? sampleRect.bounds.size.height : sampleRect.bounds.size.width;
        CGFloat height = sampleRect.rotated ? sampleRect.bounds.size.width : sampleRect.bounds.size.height;
        if (width > maxWidth) {
            maxWidth = width;
        }
        if (height > maxHeight) {
            maxHeight = height;
        }
    }
    
    CGFloat scaleFactorWidth = rect.size.width / maxWidth;
    CGFloat scaleFactorHeight = rect.size.height / maxHeight;
    
    CGFloat scaleFactor = MIN(scaleFactorHeight, scaleFactorWidth);
    return scaleFactor;
}

@end
