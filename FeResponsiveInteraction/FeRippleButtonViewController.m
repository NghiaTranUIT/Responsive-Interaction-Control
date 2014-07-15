//
//  FeRippleButtonViewController.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 7/15/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeRippleButtonViewController.h"
#import "FeRippleButton.h"
#import "UIColor+flat.h"

@interface FeRippleButtonViewController ()
@property (strong, nonatomic) FeRippleButton *rippleButton_1;
@property (strong, nonatomic) FeRippleButton *rippleButton_2;
@property (strong, nonatomic) FeRippleButton *rippleButton_3;
@property (strong, nonatomic) FeRippleButton *rippleButton_4;

-(void) initRippleButtonWithRippleOverBound;
-(void) initRippleButtonWithTrackTouchLocation;
-(void) initRippleButtonWithShadowRippleEffect;
-(void) initRippleButtonWithTransparentBackground;

-(void) initHindWithText:(NSString *) text below:(FeRippleButton *) btn;
@end

@implementation FeRippleButtonViewController

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
    
    // Ripple Over Bound
    [self initRippleButtonWithRippleOverBound];;
    
    // Shadow Ripple Effect
    [self initRippleButtonWithShadowRippleEffect];
    
    // Track Touch Location
    [self initRippleButtonWithTrackTouchLocation];
    
    [self initRippleButtonWithTransparentBackground];
}
-(void) initRippleButtonWithRippleOverBound
{
    // init
    _rippleButton_1 = [[FeRippleButton alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        _rippleButton_1.center = CGPointMake(self.view.center.x, 200);
    }
    else
    {
        _rippleButton_1.center = CGPointMake(self.view.center.x, 100);
    }
    [_rippleButton_1 setTitle:@"Button" forState:UIControlStateNormal];
    _rippleButton_1.backgroundColor = [UIColor clearColor];
    [_rippleButton_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rippleButton_1.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    
    // Configure
    _rippleButton_1.rippleOverBound = YES;
    
    [self.view addSubview:_rippleButton_1];
    
    // Hint Label
    [self initHindWithText:@"Ripple Over Bounds" below:_rippleButton_1];
}
-(void) initRippleButtonWithShadowRippleEffect
{
    // init
    _rippleButton_2 = [[FeRippleButton alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        _rippleButton_2.center = CGPointMake(self.view.center.x, 400);
    }
    else
    {
        _rippleButton_2.center = CGPointMake(self.view.center.x, 220);
    }
    
    [_rippleButton_2 setTitle:@"Button" forState:UIControlStateNormal];
    _rippleButton_2.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:134.0f/255.0f blue:235.0f/255.0f alpha:1];
    [_rippleButton_2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rippleButton_2.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    
    // Configure
    _rippleButton_2.rippleColor = [UIColor colorWithRed:33.0f/255.0f green:101.0f/255.0f blue:196.0f/255.0f alpha:1];
    _rippleButton_2.rippleBackgroundColor = [UIColor colorWithRed:42.0f/255.0f green:119.0f/255.0f blue:218.0f/255.0f alpha:1];
    
    [self.view addSubview:_rippleButton_2];
    
    // Hint Label
    [self initHindWithText:@"Shadow Ripple Effect" below:_rippleButton_2];
}
-(void) initRippleButtonWithTrackTouchLocation
{
    // init
    _rippleButton_3 = [[FeRippleButton alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        _rippleButton_3.center = CGPointMake(self.view.center.x, 600);
    }
    else
    {
        _rippleButton_3.center = CGPointMake(self.view.center.x, 340);
    }
    
    [_rippleButton_3 setTitle:@"Button" forState:UIControlStateNormal];
    _rippleButton_3.backgroundColor = [UIColor colorWithRed:47.0f/255.0f green:134.0f/255.0f blue:235.0f/255.0f alpha:1];
    [_rippleButton_3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rippleButton_3.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    
    // Configure
    // Configure
    _rippleButton_3.rippleColor = [UIColor colorWithRed:33.0f/255.0f green:101.0f/255.0f blue:196.0f/255.0f alpha:1];
    _rippleButton_3.rippleBackgroundColor = [UIColor colorWithRed:42.0f/255.0f green:119.0f/255.0f blue:218.0f/255.0f alpha:1];
    _rippleButton_3.trackTouchLocation = YES;
    
    [self.view addSubview:_rippleButton_3];
    
    // Hint Label
    [self initHindWithText:@"Track Location Touch" below:_rippleButton_3];
}
-(void) initRippleButtonWithTransparentBackground
{
    // init
    _rippleButton_4 = [[FeRippleButton alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        _rippleButton_4.center = CGPointMake(self.view.center.x, 800);
    }
    else
    {
        _rippleButton_4.center = CGPointMake(self.view.center.x, 460);
    }
    
    [_rippleButton_4 setTitle:@"Button" forState:UIControlStateNormal];
    _rippleButton_4.backgroundColor = [UIColor clearColor];
    [_rippleButton_4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rippleButton_4.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    
    // Configure
    _rippleButton_4.rippleOverBound = NO;
    _rippleButton_4.rippleBackgroundColor = [UIColor colorWithWhite:0.95f alpha:1];
    
    [self.view addSubview:_rippleButton_4];
    
    // Hint Label
    [self initHindWithText:@"Transparent Background" below:_rippleButton_4];

}
-(void) initHindWithText:(NSString *)text below:(FeRippleButton *)btn
{
    UILabel *hintTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    hintTitle.textColor = [UIColor blackColor];
    hintTitle.text = text;
    hintTitle.textAlignment = NSTextAlignmentCenter;
    
    
    [hintTitle sizeToFit];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        hintTitle.font = [UIFont italicSystemFontOfSize:18];
       hintTitle.center = CGPointMake(btn.center.x, btn.center.y + btn.bounds.size.height / 2 + 40);
    }else
    {
        hintTitle.font = [UIFont italicSystemFontOfSize:12];
        hintTitle.center = CGPointMake(btn.center.x, btn.center.y + btn.bounds.size.height / 2 + 12);
    }
    
    hintTitle.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:hintTitle];
}
@end
