//
//  MGSpriteSheetParser.m
//  MGSpriteView
//
//  Created by Gio on 16/05/2013.
//

#import "MGSpriteSheetParser.h"

#import "MGSampleRect.h"

@implementation MGSpriteSheetParser

- (NSArray *)sampleRectsFromFileAtPath:(NSString *)path
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
    if (data) {
        
        NSMutableArray *samples = [NSMutableArray array];
        
        NSDictionary *frames = [data objectForKey:@"frames"];
        NSArray *keys = [frames allKeys];
        NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

        CGSize size = CGSizeMake(CGImageGetWidth(self.imageRef), CGImageGetHeight(self.imageRef));
        for (NSString *key in sortedKeys) {
            NSString *frame = [[frames objectForKey:key] objectForKey:@"frame"];
            NSString *offset = [[frames objectForKey:key] objectForKey:@"offset"];
            BOOL rotated = [[[frames objectForKey:key] objectForKey:@"rotated"] boolValue];
            NSString *sourceColorRect = [[frames objectForKey:key] objectForKey:@"sourceColorRect"];
            NSString *sourceSize = [[frames objectForKey:key] objectForKey:@"sourceSize"];
            MGSampleRect *sample = [[MGSampleRect alloc] initWithImageSize:size
                                                                     frame:[self rectFromString:frame]
                                                                    offset:[self pointFromString:offset]
                                                                   rotated:rotated
                                                           sourceColorRect:[self rectFromString:sourceColorRect]
                                                                sourceSize:[self sizeFromString:sourceSize]];
            [samples addObject:sample];
        }
        
        return samples;
    } else {
        return nil;
    }
}

- (CGRect)rectFromString:(NSString *)string
{
    NSString *rectString = [string stringByReplacingOccurrencesOfString:@"{" withString:@""];
    rectString = [rectString stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSArray *coords = [rectString componentsSeparatedByString:@","];
    if ([coords count] == 4) {
        return CGRectMake([coords[0] floatValue],
                          [coords[1] floatValue],
                          [coords[2] floatValue],
                          [coords[3] floatValue]);
    } else {
        return CGRectZero;
    }
}

- (CGPoint)pointFromString:(NSString *)string
{
    NSString *pointString = [string stringByReplacingOccurrencesOfString:@"{" withString:@""];
    pointString = [pointString stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSArray *coords = [pointString componentsSeparatedByString:@","];
    if ([coords count] == 2) {
        return CGPointMake([coords[0] floatValue],
                          [coords[1] floatValue]);
    } else {
        return CGPointZero;
    }
}

- (CGSize)sizeFromString:(NSString *)string
{
    NSString *sizeString = [string stringByReplacingOccurrencesOfString:@"{" withString:@""];
    sizeString = [sizeString stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSArray *dimensions = [sizeString componentsSeparatedByString:@","];
    if ([dimensions count] == 2) {
        return CGSizeMake([dimensions[0] floatValue],
                           [dimensions[1] floatValue]);
    } else {
        return CGSizeZero;
    }
}

@end
