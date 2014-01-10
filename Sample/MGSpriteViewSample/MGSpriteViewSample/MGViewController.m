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

static const CGFloat kCharmanderWidth = 37;
static const CGFloat kCharmanderHeight = 47;

static const CGFloat kSquirtleWidth = 55;
static const CGFloat kSquirtleHeight = 40;

@interface MGViewController ()
@property (nonatomic, strong) MGSpriteView *bulbasaur;
@property (nonatomic, strong) MGSpriteView *charmander;
@property (nonatomic, strong) MGSpriteView *squirtle;
@property (nonatomic, strong) MGSpriteView *ninja;
- (void)addBulbasaur;
- (void)addCharmander;
- (void)addSquirtle;
- (void)addNinja;
@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addBulbasaur];
    [self addCharmander];
    [self addSquirtle];
    [self addNinja];
    
    self.bulbasaur.view.center = CGPointMake(50, 100);
    self.charmander.view.center = CGPointMake(150, 200);
    self.squirtle.view.center = CGPointMake(250, 300);
    self.ninja.view.center = CGPointMake(100, 300);
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [self.bulbasaur runAnimation];
    [self.charmander runAnimation];
    [self.squirtle runAnimation];
    [self.ninja runAnimation];
    
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

/**
 *  Add Ninja Shinbi Sprite
 *  License: Creative Commos attribution license
 * http://www.36peas.com/blog/2010/9/13/free-japanese-ninja-shinobi-sprite-sheet.html
 * Additional resource could check out following location:
 * Sample/MGSpriteViewSample/MGSpriteViewSample/TextureAtlases/iPhone/original_master_ninja_shinobi_sprite.psd
 */
- (void)addNinja
{
    CGRect frame = CGRectZero;
    frame.origin = CGPointMake(0, 0);
    frame.size = CGSizeMake(150, 150);
    
    self.ninja = [[MGSpriteView alloc] initWithFrame:frame
                                                atlasNamed:@"ninja_shinbi"
                                                       fps:7];
    
    [self.view addSubview:self.ninja.view];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.ninja pauseAnimation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.ninja runAnimation];
}

@end
