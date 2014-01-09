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


#pragma mark - Compatible with iOS 7 Sprite Kit

// Detect iPhone5 4-inch screen
// http://stackoverflow.com/questions/12446990/how-to-detect-iphone-5-widescreen-devices
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

/**
 *  Path genetator from atlas name of iOS 7 Sprite Kit Texture
 *
 *  @param atlasName : atlas name of iOS 7 Sprite Kit
 *  @param type      : file type (extention)
 *
 *  @return return NSString path
 */
- (NSString *)bundlePathFromTextureAtlasNamed:(NSString *)atlasName
                                       ofType:(NSString *)type
{
    return [self bundlePathFromTextureAtlasNamed:atlasName ofType:type ofImageIndex:0];
}

/**
 *  Path genetator from atlas name of iOS 7 Sprite Kit Texture
 *
 *  @param atlasName : atlas name of iOS 7 Sprite Kit
 *  @param type      : file type (extention)
 *  @param index     : index of images
 *
 *  @return return NSString path
 */
- (NSString *)bundlePathFromTextureAtlasNamed:(NSString *)atlasName
                                       ofType:(NSString *)type
                                 ofImageIndex:(int)index
{
    if (atlasName == nil || type == nil) {
        return nil;
    }
    
    
    NSString *fileName = nil;
    NSString *indexString = @"";
    
    if (index) {
        indexString = [NSString stringWithFormat:@".%d", index];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        if (IS_WIDESCREEN) {
            // iPhone Retina 4-inch
            fileName = [NSString stringWithFormat:@"%@-568%@", atlasName, indexString];
            atlasName = [NSString stringWithFormat:@"%@-568.atlasc", atlasName];
        } else {
            // iPhone Retina 3.5-inch
            fileName = [NSString stringWithFormat:@"%@%@", atlasName, indexString];
            atlasName = [NSString stringWithFormat:@"%@.atlasc", atlasName];
        }
        
    } else {
        fileName = [NSString stringWithFormat:@"%@-ipad%@", atlasName, indexString];
        atlasName = [NSString stringWithFormat:@"%@-ipad.atlasc", atlasName];
    }
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:fileName
                                                           ofType:type
                                                      inDirectory:atlasName];
    
    //NSAssert([[NSFileManager defaultManager] fileExistsAtPath:bundlePath], @"MGSpriteSheetParser: no plist file in %@", bundlePath);
    
    return bundlePath;
}

/**
 *  Compatible method for iOS 7 Sprite Kit Atlasc(not atlas)
 *
 *  @param atlasName atlas name of iOS 7 Sprite Kit
 *
 *  @return NSArray
 */
- (NSArray *)sampleRectsFromTextureAtlasNamed:(NSString *)atlasName
{
    NSString *bundlePath = [self bundlePathFromTextureAtlasNamed:atlasName ofType:@"plist"];
    
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
    if (data && [[data objectForKey:@"format"] isEqualToString:@"APPL"]) {
        
        NSMutableArray *samples = [NSMutableArray array];
        
        //TODO: What about more than one images !!!
        NSDictionary *items = [[data objectForKey:@"images"] objectAtIndex:0];
        NSString *size = [items objectForKey:@"size"]; // Actual size of original texture.
        NSArray *subimages = [items objectForKey:@"subimages"];
        
        [subimages enumerateObjectsWithOptions:NSEnumerationConcurrent
                                    usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                        
                                        //NSString *name = [obj objectForKey:@"name"];
                                        NSString *offset = [obj objectForKey:@"spriteOffset"];
                                        NSString *sourceSize = [obj objectForKey:@"spriteSourceSize"];
                                        NSString *frame = [obj objectForKey:@"textureRect"];
                                        BOOL rotated = [[obj objectForKey:@"textureRotated"] boolValue];
                                        
                                        MGSampleRect *sample = [[MGSampleRect alloc] initWithImageSize:[self sizeFromString:size]
                                                                                                 frame:[self rectFromString:frame]
                                                                                                offset:[self pointFromString:offset]
                                                                                               rotated:rotated
                                                                                       sourceColorRect:[self rectFromString:sourceSize]
                                                                                            sourceSize:[self sizeFromString:sourceSize]];
                                        [samples addObject:sample];
                                        
                                    }];
        
        return samples;
    } else {
        NSLog(@"MGSpriteSheetParser: no data or not matched format of plist(APPL)");
        
        return nil;
    }
    
}

/**
 *  Make CGImageRef from atlas name
 *
 *  @param atlasName atlas name of iOS 7 Sprite Kit
 *
 *  @return CFImageRef
 */
- (CGImageRef)imageRefFromTextureAtlasNamed:(NSString *)atlasName
{
    NSString *bundlePath = [self bundlePathFromTextureAtlasNamed:atlasName ofType:@"plist"];
    
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
    if (data && [[data objectForKey:@"format"] isEqualToString:@"APPL"]) {
        
        //TODO: What about more than one images !!!
        NSDictionary *items = [[data objectForKey:@"images"] objectAtIndex:0];
        NSString *path = [items objectForKey:@"path"]; // Actual path of original texture.
        
        NSString *theFileName = [path stringByDeletingPathExtension];
        NSString *theExtension = [path pathExtension];
        NSArray *anArray = [theFileName componentsSeparatedByString:@"."];
        int imageIndex = [anArray count] ? [[anArray objectAtIndex:1] intValue] : 0;
        
        NSString *texturePath = [self bundlePathFromTextureAtlasNamed:atlasName ofType:theExtension ofImageIndex:imageIndex];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:texturePath]) {
            return [[UIImage imageWithContentsOfFile:texturePath] CGImage];
        }
        
    }
    
    return nil;
}


@end
