//
//  MGViewController.m
//  Example
//
//  Created by Gio on 20/08/2013.
//  Copyright (c) 2013 mokagio. All rights reserved.
//

#import "MGViewController.h"
#import "MGSpriteView.h"

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
    [self orderElements];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.bulbasaur runAnimation];
    [self.charmander runAnimationWithCompleteCallback:^{
        NSLog(@"Charmander animation completed");
    }];
    [self.squirtle runAnimationLooped];
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
}

@end
