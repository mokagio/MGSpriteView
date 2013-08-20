//
//  MGViewController.m
//  Example
//
//  Created by Gio on 20/08/2013.
//  Copyright (c) 2013 mokagio. All rights reserved.
//

#import "MGViewController.h"
#import "MGSpriteView.h"
#import "MGSpriteAnimationSequence.h"

static const CGFloat kBulbasaurWidth = 49;
static const CGFloat kBulbasaurHeight = 45;

static const CGFloat kCharmanderWidth = 37;
static const CGFloat kCharmanderHeight = 47;

static const CGFloat kSquirtleWidth = 55;
static const CGFloat kSquirtleHeight = 40;

@interface MGViewController ()
@property (nonatomic, strong) MGSpriteView *bulbasaur;
@property (nonatomic, strong) MGSpriteView *charmander;
@property (nonatomic, strong) MGSpriteView *squirtle;
@property (nonatomic, strong) MGSpriteAnimationSequence *blastoise;
- (void)addBulbasaur;
- (void)addCharmander;
- (void)addSquirtle;
@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addBulbasaur];
    [self addCharmander];
    [self addSquirtle];
    [self addBlastoise];
    
    [self orderElements];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.bulbasaur runAnimation];
    [self.charmander runAnimationWithCompleteCallback:^{
        NSLog(@"Charmander animation completed");
    }];
    [self.squirtle runAnimationLooped];
    [self.blastoise runLooped];
}

#pragma mark - UI

- (void)addBulbasaur
{
    CGRect frame = CGRectMake(0, 0, kBulbasaurWidth, kBulbasaurHeight);
    self.bulbasaur = [[MGSpriteView alloc] initWithFrame:frame
                                     spriteSheetFileName:@"bulbasaur.png"
                                                     fps:12];
    [self.view addSubview:self.bulbasaur.view];
}

- (void)addCharmander
{
    CGRect frame = CGRectMake(0, 0, kCharmanderWidth, kCharmanderHeight);
    self.charmander = [[MGSpriteView alloc] initWithFrame:frame
                                      spriteSheetFileName:@"charmander.png"
                                                      fps:12];
    [self.view addSubview:self.charmander.view];
}

- (void)addSquirtle
{
    CGRect frame = CGRectMake(0, 0, kSquirtleWidth, kSquirtleHeight);
    self.squirtle = [[MGSpriteView alloc] initWithFrame:frame
                                    spriteSheetFileName:@"squirtle.png"
                                                    fps:12];
    [self.view addSubview:self.squirtle.view];
}

- (void)addBlastoise
{
    CGRect frame = CGRectMake(0, 0, 33.5 * 2, 31.5 * 2);
    CGFloat fps = 24;
    MGSpriteView *blastoise0 = [[MGSpriteView alloc] initWithFrame:frame
                                               spriteSheetFileName:@"blastoise.png"
                                                               fps:fps];
    MGSpriteView *blastoise1 = [[MGSpriteView alloc] initWithFrame:frame
                                               spriteSheetFileName:@"blastoise-s.png"
                                                               fps:fps];
    MGSpriteView *blastoiseBack = [[MGSpriteView alloc] initWithFrame:CGRectMake(0, 0, 32 * 2, 31 * 2)
                                                  spriteSheetFileName:@"blastoise_back.png"
                                                                  fps:fps];
    self.blastoise = [[MGSpriteAnimationSequence alloc] initWithAnimations:@[
                      blastoise0,
//                      blastoise1,
                      blastoiseBack
                      ]];
    [self.view addSubview:self.blastoise.view];
}

- (void)orderElements
{
    CGFloat padding = 30;
    
    CGRect bFrame = self.bulbasaur.view.frame;
    bFrame.origin = CGPointMake(padding, padding);
    self.bulbasaur.view.frame = bFrame;
    
    CGRect cFrame = self.charmander.view.frame;
    cFrame.origin = CGPointMake(padding, CGRectGetMaxY(self.bulbasaur.view.frame) + padding);
    self.charmander.view.frame = cFrame;
    
    CGRect sFrame = self.squirtle.view.frame;
    sFrame.origin = CGPointMake(padding, CGRectGetMaxY(self.charmander.view.frame) + padding);
    self.squirtle.view.frame = sFrame;
    
    CGRect blFrame = self.blastoise.view.frame;
    blFrame.origin = CGPointMake(padding, CGRectGetMaxY(self.squirtle.view.frame) + padding);
    self.blastoise.view.frame = blFrame;
}

@end
