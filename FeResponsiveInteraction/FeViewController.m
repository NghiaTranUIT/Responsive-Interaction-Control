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

@interface FeViewController () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSMutableArray *arrLabels;
@property (strong, nonatomic) CAAnimationGroup *groupAnimation;

///////////////////
-(void) initCommon;
-(void) initSampleLabel;

@end

@implementation FeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initCommon];
    
    //[self initSampleLabel];
    
    [self initButton];
    
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
    self.view.backgroundColor = [UIColor colorWithHexCode:@"#fafafa"];
    
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
    NSLog(@"gesture = %@",self.view.gestureRecognizers);
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
    NSLog(@"gesture = %@",self.view.gestureRecognizers);
}

#pragma mark - Action
- (IBAction)liftEffectBtnTapped:(id)sender
{
    
    ////////////
    // Define
    CGFloat duration = 0.6f;
    
    /////////////
    // Transform
    CATransform3D t = CATransform3DIdentity;
    t.m34 = - 1.0f / 800.0f;
    t = CATransform3DTranslate(t, 0, 0, 13);
    
    CABasicAnimation *liftAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    liftAnimation.toValue = (id) [NSValue valueWithCATransform3D:t];
    liftAnimation.duration = duration;
    liftAnimation.fillMode = kCAFillModeForwards;
    liftAnimation.removedOnCompletion = NO;
    
    
    // Shadow Offset
    CABasicAnimation *shadowOffsetAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    shadowOffsetAnimation.toValue = (id) [NSValue valueWithCGSize:CGSizeMake(0, 7)];
    shadowOffsetAnimation.duration = duration;
    shadowOffsetAnimation.fillMode = kCAFillModeForwards;
    shadowOffsetAnimation.removedOnCompletion = NO;
    

    // Shadow Radius
    CABasicAnimation *shadowRaidusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    shadowRaidusAnimation.toValue = (id) [NSNumber numberWithFloat:5];
    shadowRaidusAnimation.duration = duration;
    shadowRaidusAnimation.fillMode = kCAFillModeForwards;
    shadowRaidusAnimation.removedOnCompletion = NO;

    
    _groupAnimation = [CAAnimationGroup animation];
    _groupAnimation.duration = duration;
    _groupAnimation.animations = @[liftAnimation, shadowOffsetAnimation, shadowRaidusAnimation];
    _groupAnimation.fillMode = kCAFillModeForwards;
    _groupAnimation.removedOnCompletion = NO;
    
    CGFloat delay = 0;
    for (NSInteger i = 0; i < _arrLabels.count; i++)
    {
        UILabel *label = _arrLabels[i];
        [label.layer addAnimation:_groupAnimation forKey:@"group"];
        label.layer.beginTime = CACurrentMediaTime() + delay;
        
        delay += 0.2f;
    }
    //[_sampleLabel_2.layer addAnimation:group forKey:@"group"];
}
-(void) btnTapped:(UIButton *) sender
{
    NSLog(@"Button tapped at tag = %ld",(long)sender.tag);
}
@end
