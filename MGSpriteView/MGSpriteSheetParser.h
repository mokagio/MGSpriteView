//
//  MGSpriteSheetParser.h
//  MGSpriteView
//
//  Created by Gio on 16/05/2013.
//

#import <Foundation/Foundation.h>

@interface MGSpriteSheetParser : NSObject

@property (nonatomic, assign) CGImageRef imageRef;

- (NSArray *)sampleRectsFromFileAtPath:(NSString *)path;

@end