//
//  MGViewController.m
//  MGSpriteViewSample
//
//  Created by Gio on 29/05/2013.
//  Copyright (c) 2013 mokagio. All rights reserved.
//

#import "MGViewController.h"
#import "MGSpriteView.h"

@interface MGViewController ()
@property (nonatomic, strong) MGSpriteView *squirtle;
@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat side = 30;
    CGRect frame = CGRectMake((self.view.frame.size.width - side) / 2,
                              (self.view.frame.size.height - side) / 2,
                              side,
                              side);
    self.squirtle = [[MGSpriteView alloc] initWithFrame:frame
                                             spriteSheetFileName:@"squirtle.png"
                                                             fps:12];
    [self.view addSubview:self.squirtle.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.squirtle runAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
