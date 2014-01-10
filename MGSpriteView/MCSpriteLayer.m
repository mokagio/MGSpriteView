//
//  MCSpriteLayer.m
//
//  Created by Miguel Angel Friginal on 8/20/10.
//  Copyright 2010 Mystery Coconut Games. All rights reserved.
//
//  See http://mysterycoconut.com/blog/2011/01/cag1/

#import "MCSpriteLayer.h"


@implementation MCSpriteLayer

#pragma mark -
#pragma mark Initialization, variable sample size


- (id)initWithImage:(CGImageRef)img;
{
    if (img == nil) {
        NSLog(@"MCSpriteLayer: there's no image");
        return nil;
    }

    self = [super init];
    if (self != nil)
    {
        self.contents = (__bridge id)img;
        self.sampleIndex = 1;
    }

    return self;
}


+ (id)layerWithImage:(CGImageRef)img;
{
    MCSpriteLayer *layer = [(MCSpriteLayer*)[self alloc] initWithImage:img];
    return layer;
}


#pragma mark -
#pragma mark Initialization, fixed sample size


- (id)initWithImage:(CGImageRef)img sampleSize:(CGSize)size;
{
    if (img == nil) {
        NSLog(@"MCSpriteLayer: there's no image");
        return nil;
    }
    
    self = [self initWithImage:img];
    if (self != nil)
    {
        CGSize sampleSizeNormalized = CGSizeMake(size.width/CGImageGetWidth(img), size.height/CGImageGetHeight(img));
        self.bounds = CGRectMake( 0, 0, size.width, size.height );
        self.contentsRect = CGRectMake( 0, 0, sampleSizeNormalized.width, sampleSizeNormalized.height );
    }
    
    return self;
}


+ (id)layerWithImage:(CGImageRef)img sampleSize:(CGSize)size;
{
    MCSpriteLayer *layer = [[self alloc] initWithImage:img sampleSize:size];
    return layer;
}


#pragma mark -
#pragma mark Frame by frame animation


+ (BOOL)needsDisplayForKey:(NSString *)key;
{
    return [key isEqualToString:@"sampleIndex"];
}


// contentsRect or bounds changes are not animated
// and transfor, frame, and position too, edit by mokagio
+ (id < CAAction >)defaultActionForKey:(NSString *)aKey;
{
    if ([aKey isEqualToString:@"bounds"] ||
        [aKey isEqualToString:@"contentsRect"] ||
        [aKey isEqualToString:@"frame"] ||
        [aKey isEqualToString:@"position"] ||
        [aKey isEqualToString:@"transform"])
        return (id < CAAction >)[NSNull null];
    
    return [super defaultActionForKey:aKey];
}


- (unsigned int)currentSampleIndex;
{
    return ((MCSpriteLayer*)[self presentationLayer]).sampleIndex;
}


// Implement displayLayer: on the delegate to override how sample rectangles are calculated; remember to use currentSampleIndex, ignore sampleIndex == 0, and set the layer's bounds
- (void)display;
{
    if ([self.delegate respondsToSelector:@selector(displayLayer:)])
    {
        [self.delegate displayLayer:self];
        return;
    }
    
    unsigned int currentSampleIndex = [self currentSampleIndex];
    if (!currentSampleIndex)
        return;
    
    CGSize sampleSize = self.contentsRect.size;
    self.contentsRect = CGRectMake(
        ((currentSampleIndex - 1) % (int)(1/sampleSize.width)) * sampleSize.width, 
        ((currentSampleIndex - 1) / (int)(1/sampleSize.width)) * sampleSize.height, 
        sampleSize.width, sampleSize.height
    );
}


@end
