//
//  FeViewController.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 6/27/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeViewController.h"
#import "UILabel+ResponsiveInteraction.h"
#import "UIColor+flat.h"
#import "UIButton+ResponsiveInteraction.h"
#import "FeRadialButton.h"

@interface FeViewController () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSMutableArray *arrLabels;
@property (strong, nonatomic) CAAnimationGroup *groupAnimation;
@property (strong, nonatomic) FeRadialButton *radialBtn;

///////////////////
-(void) initCommon;
-(void) initSampleLabel;
-(void) initRadialButton;

@end

@implementation FeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initCommon];
    
    //[self initSampleLabel];
    
    //[self initButton];
    
    
    [self initRadialButton];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    [btn setImage:[UIImage imageNamed:@"icon_btn"] forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
-(void) initCommon
{
    // Set background
    self.view.backgroundColor = [UIColor colorWithHexCode:@"#19B5FE"];
    
}
-(void) initSampleLabel
{
    _arrLabels = [NSMutableArray arrayWithCapacity:5];
    
    for (NSInteger i = 0 ; i < 8 ; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
        label.center = CGPointMake(self.view.center.x, 300 + i * 80);
        label.backgroundColor = [UIColor flatCarrotColor];
        label.tag = i;
        
        // Active effect
        [label activeResponsiveInteraction];
        [label setGlobleResponsiveInteractionWithView:self.view];
        
        // Add subview
        [_arrLabels addObject:label];
        [self.view addSubview:label];
        
    }
}
-(void) initButton
{
    _arrLabels = [NSMutableArray arrayWithCapacity:5];
    
    for (NSInteger i = 0 ; i < 8 ; i++)
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
        btn.center = CGPointMake(self.view.center.x, 300 + i * 80);
        btn.backgroundColor = [UIColor flatCarrotColor];
        btn.tag = i;
        
        // Action
        [btn addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"Button" forState:UIControlStateNormal];
        
        // Active effect
        [btn activeResponsiveInteraction];
        [btn setGlobleResponsiveInteractionWithView:self.view];
        
        // Add subview
        [_arrLabels addObject:btn];
        [self.view addSubview:btn];
        
    }
}
-(void) initRadialButton
{
    FeRadialButtonOption *option_1 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_btn"] target:self action:@selector(btn_1_tapped:) forEvent:UIControlEventTouchUpInside atIndex:0];
    FeRadialButtonOption *option_2 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_option"] target:self action:@selector(btn_2_tapped:) forEvent:UIControlEventTouchUpInside atIndex:1];
    FeRadialButtonOption *option_3 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_back"] target:self action:@selector(btn_3_tapped:) forEvent:UIControlEventTouchUpInside atIndex:1];
    
    
    _radialBtn = [[FeRadialButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, 400, 200, 50) radialButtonOptions:@[option_1 , option_2, option_3]];
    
    [self.view addSubview:_radialBtn];
}
#pragma mark - Action
-(void) btn_1_tapped:(UIButton *) sender
{
    NSLog(@"btn 1 tapped");
    [_radialBtn animateToIndex:1 withCompletionBlock:^(BOOL finish) {
        NSLog(@"animate completion");
    }];
}
-(void) btn_2_tapped:(UIButton *) sender
{
    NSLog(@"btn 2 tapped");
    [_radialBtn animateToIndex:2 withCompletionBlock:^(BOOL finish) {
        NSLog(@"animate completion");
    }];
}
-(void) btn_3_tapped:(UIButton *) sender
{
    NSLog(@"btn 3 tapped");
    [_radialBtn animateToIndex:0 withCompletionBlock:^(BOOL finish) {
        NSLog(@"animate completion");
    }];
}
-(void) btnTapped:(UIButton *) sender
{
    NSLog(@"Button tapped at tag = %ld",(long)sender.tag);
}
@end
