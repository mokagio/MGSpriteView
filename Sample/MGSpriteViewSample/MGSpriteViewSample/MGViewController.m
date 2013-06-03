//
//  MGViewController.m
//  MGSpriteViewSample
//
//  Created by Gio on 29/05/2013.
//  Copyright (c) 2013 mokagio. All rights reserved.
//

#import "MGViewController.h"
#import "MGSpriteView.h"

static const CGFloat kBulbasaurWidth = 49;
static const CGFloat kBulbasaurHeight = 45;

static const CGFloat kSquirtleWidth = 55;
static const CGFloat kSquirtleHeight = 40;

@interface MGViewController ()
@property (nonatomic, strong) MGSpriteView *bulbasaur;
@property (nonatomic, strong) MGSpriteView *squirtle;
- (void)addBulbasaur;
- (void)addSquirtle;
@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addBulbasaur];
    [self addSquirtle];
    
    self.bulbasaur.view.center = CGPointMake(100, 100);
    self.squirtle.view.center = CGPointMake(200, 200);
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.bulbasaur runAnimation];
    [self.squirtle runAnimation];
}

#pragma mark - UI

- (void)addBulbasaur
{
    CGRect frame = CGRectMake(0, 0, kBulbasaurWidth, kBulbasaurHeight);
    self.bulbasaur = [[MGSpriteView alloc] initWithFrame:frame
                                     spriteSheetFileName:@"bulbasaur.png"
                                                     fps:12];
//    self.bulbasaur.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bulbasaur.view];
}

- (void)addSquirtle
{
    CGRect frame = CGRectMake(0, 0, kSquirtleWidth, kSquirtleHeight);
    self.squirtle = [[MGSpriteView alloc] initWithFrame:frame
                                     spriteSheetFileName:@"squirtle.png"
                                                     fps:12];
    [self.view addSubview:self.squirtle.view];
}

@end
