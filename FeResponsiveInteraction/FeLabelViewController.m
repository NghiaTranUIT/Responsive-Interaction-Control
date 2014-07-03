//
//  FeViewController.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 6/27/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeLabelViewController.h"
#import "UILabel+ResponsiveInteraction.h"
#import "UIColor+flat.h"
#import "UIButton+ResponsiveInteraction.h"
#import "FeRadialButton.h"

@interface FeLabelViewController () <UIGestureRecognizerDelegate>


///////////////////
-(void) initCommon;
-(void) initSampleLabel;

@end

@implementation FeLabelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initCommon];
    
    [self initSampleLabel];
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
    for (NSInteger i = 0 ; i < 8 ; i++)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
        label.center = CGPointMake(self.view.center.x - 250, 300 + i * 80);
        label.backgroundColor = [UIColor flatCarrotColor];
        label.tag = i;
        
        // Active effect
        [label activeResponsiveInteraction];
        [label setGlobalResponsiveInteractionWithView:self.view];
        
        // Add subview
        [self.view addSubview:label];
        
    }
}

#pragma mark - Action

@end
