//
//  FeRadialButtonViewController.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 7/3/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeRadialButtonViewController.h"
#import "UIColor+flat.h"
#import "FeRadialButton.h"

@interface FeRadialButtonViewController ()
@property (strong, nonatomic) FeRadialButton *radialBtn;
@end

@implementation FeRadialButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set background
    self.view.backgroundColor = [UIColor colorWithHexCode:@"#19B5FE"];

    [self initRadialButton];
}

-(void) initRadialButton
{
    FeRadialButtonOption *option_1 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_btn"] target:self action:@selector(btn_1_tapped:) forEvent:UIControlEventTouchUpInside atIndex:0];
    FeRadialButtonOption *option_2 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_option"] target:self action:@selector(btn_2_tapped:) forEvent:UIControlEventTouchUpInside atIndex:1];
    FeRadialButtonOption *option_3 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_back"] target:self action:@selector(btn_3_tapped:) forEvent:UIControlEventTouchUpInside atIndex:1];
    
    
    _radialBtn = [[FeRadialButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, 400, 200, 50) radialButtonOptions:@[option_1 , option_2, option_3]];
    
    [self.view addSubview:_radialBtn];
}
-(void) btn_1_tapped:(UIButton *) sender
{
    NSLog(@"btn 1 tapped");
    [_radialBtn animateToNextIndexWithCompletionBlock:^(BOOL finish) {
        
    }];
}
-(void) btn_2_tapped:(UIButton *) sender
{
    NSLog(@"btn 2 tapped");
    [_radialBtn animateToNextIndexWithCompletionBlock:^(BOOL finish) {
        
    }];
}
-(void) btn_3_tapped:(UIButton *) sender
{
    NSLog(@"btn 3 tapped");
    [_radialBtn animateToNextIndexWithCompletionBlock:^(BOOL finish) {
        
    }];
}
@end
