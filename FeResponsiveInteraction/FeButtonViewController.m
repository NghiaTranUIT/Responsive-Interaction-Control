//
//  FeButtonViewController.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 7/3/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeButtonViewController.h"
#import "UIColor+flat.h"
#import "UIButton+ResponsiveInteraction.h"

@interface FeButtonViewController ()

@end

@implementation FeButtonViewController

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
    
    [self initButton];
}

-(void) initButton
{

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
        [btn setGlobalResponsiveInteractionWithView:self.view];
        
        // Add subview
        [self.view addSubview:btn];
        
    }
}
-(void) btnTapped:(UIButton *) sender
{
    NSLog(@"Button tapped at tag = %ld",(long)sender.tag);
}
@end
