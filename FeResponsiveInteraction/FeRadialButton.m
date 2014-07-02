//
//  FeRadialButton.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 6/30/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeRadialButton.h"
#import "FeBasicAnimationBlock.h"

@interface FeRadialButton ()
// Layer
@property (strong, nonatomic) CALayer *currentImageLayer;
@property (strong, nonatomic) CALayer *nextImageLayer;
@property (strong, nonatomic) CALayer *circleLayer;

// Basic animation
@property (strong, nonatomic) CAAnimationGroup *animationGroupFirst;
@property (strong, nonatomic) CAAnimationGroup *animationGroupSecond;
@property (strong, nonatomic) CAAnimationGroup *animationGroupOverlay;

//////////////////
-(void) initCommon;
-(void) initRadialButtonWithArr:(NSArray *) arr;
-(void) initImageLayerAtIndex:(NSInteger) index;
-(void) initCircleLayer;
-(void) initAnimation;

// Verify button
-(void) verifyWithRadialButtons:(NSArray *) arr;
@end

@implementation FeRadialButton

#pragma mark - Init
-(instancetype) initWithFrame:(CGRect)frame radialButtonOptions:(NSArray *)arrayOfOption
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _arrayOfButton = arrayOfOption;
        
        [self verifyWithRadialButtons:arrayOfOption];
        
        [self initCommon];
        
        [self initRadialButtonWithArr:arrayOfOption];
        
        [self initCircleLayer];
        
        [self initAnimation];
    }
    return self;
}
-(void) verifyWithRadialButtons:(NSArray *)arr
{
    NSAssert(arr, @"Arr of radial button should NOT be nil");
    NSAssert(arr.count > 0, @"The count of array should NOT be ZERO");
    
    // Check kind of class
    for (NSInteger i = 0 ; i < arr.count; i++)
    {
        id object = arr[i];
        
        NSAssert([object isKindOfClass:[FeRadialButtonOption class]], @"Member should be FeRaidalButtonOption class");
    }
}
-(void) initCommon
{
    _durationAnimation = 0.8f;
    _currentIndex = 0;
    self.clipsToBounds = NO;
}
-(void) initRadialButtonWithArr:(NSArray *)arr
{
    // Set index
    for (NSInteger i = 0; i < arr.count; i++)
    {
        FeRadialButtonOption *option = arr[i];
        option.index = i;
    }
    
    // Set image with action for index button = 0;
    // First object
    FeRadialButtonOption *firstOption = arr[0];
    _currentRadialButton = firstOption;
    
    // Image
    // Set image for init UIImageView itself
    // and set fake image view
    [self setImage:firstOption.image forState:UIControlStateNormal];
    
    // init CurrentImageView instead of self.imageview
    _currentImageLayer = [CALayer layer];
    _currentImageLayer.frame = self.imageView.bounds;
    _currentImageLayer.contentsGravity = kCAGravityResizeAspectFill;
    _currentImageLayer.contents = (__bridge id)(firstOption.image.CGImage);
    
    [self.imageView.layer addSublayer:_currentImageLayer];
    
    // Target
    [self addTarget:firstOption.target action:firstOption.selector forControlEvents:firstOption.controlEvent];
}
-(void) initCircleLayer
{
    _circleLayer = [CALayer layer];
    _circleLayer.frame = CGRectMake(0, 0, self.imageView.bounds.size.width + 30, self.imageView.bounds.size.height + 30);
    _circleLayer.cornerRadius = (_circleLayer.bounds.size.width) / 2;
    _circleLayer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8f].CGColor;
    _circleLayer.transform = CATransform3DMakeScale(0, 0, 0);
    _circleLayer.position = CGPointMake(self.imageView.bounds.size.width / 2, self.imageView.bounds.size.height / 2);
    
    [self.imageView.layer insertSublayer:_circleLayer atIndex:0];
}
-(void) initAnimation
{
    //Group first
    if (YES)
    {
        // Opacity
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.toValue = [NSNumber numberWithFloat:0.0f];
        opacity.fillMode = kCAFillModeForwards;
        opacity.removedOnCompletion = NO;
        opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        opacity.duration = _durationAnimation;
        
        // Transform
        CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        transform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI / 2, 0, 0, 1)];
        transform.fillMode = kCAFillModeForwards;
        transform.removedOnCompletion = NO;
        transform.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        transform.duration = _durationAnimation;
        
        // Keyframe
        CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        keyframeAnimation.values = @[
                                     [NSValue valueWithCATransform3D:CATransform3DIdentity],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI / 2, 0, 0, 1)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI , 0, 0, 1)]];
        keyframeAnimation.keyTimes = @[@0.0f, @0.5f , @1.0f];
        keyframeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        keyframeAnimation.fillMode = kCAFillModeForwards;
        keyframeAnimation.removedOnCompletion = NO;
        keyframeAnimation.duration = _durationAnimation;
        
        // Group
        _animationGroupFirst = [CAAnimationGroup animation];
        _animationGroupFirst.animations = @[opacity, keyframeAnimation];
        _animationGroupFirst.fillMode = kCAFillModeForwards;
        _animationGroupFirst.removedOnCompletion = NO;
        _animationGroupFirst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        _animationGroupFirst.duration = _durationAnimation;
    }
    
    // Group second
    //Group first
    if (YES)
    {
        // Opacity
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.toValue = [NSNumber numberWithFloat:1];
        opacity.fillMode = kCAFillModeForwards;
        opacity.removedOnCompletion = NO;
        opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        opacity.duration = _durationAnimation;
        
        // Transform
        CATransform3D t_1 = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        CATransform3D t_2 = CATransform3DRotate(t_1, M_PI, 0, 0, 1);
        
        CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform.fromValue = [NSValue valueWithCATransform3D:t_1];
        transform.toValue = [NSValue valueWithCATransform3D:t_2];
        transform.fillMode = kCAFillModeForwards;
        transform.removedOnCompletion = NO;
        transform.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        transform.duration = _durationAnimation;
        
        // Group
        _animationGroupSecond = [CAAnimationGroup animation];
        _animationGroupSecond.animations = @[opacity, transform];
        _animationGroupSecond.fillMode = kCAFillModeForwards;
        _animationGroupSecond.removedOnCompletion = NO;
        _animationGroupSecond.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        _animationGroupSecond.duration = _durationAnimation;
    }
    
    // overlay
    if (YES)
    {
        // Opacity
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        opacity.toValue = (id)[UIColor colorWithWhite:1 alpha:0].CGColor;
        opacity.fillMode = kCAFillModeForwards;
        opacity.removedOnCompletion = NO;
        opacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        opacity.duration = _durationAnimation;
        
        // Transform
        CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        transform.fillMode = kCAFillModeForwards;
        transform.removedOnCompletion = NO;
        transform.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        transform.duration = _durationAnimation;
        
        // Group
        _animationGroupOverlay = [CAAnimationGroup animation];
        _animationGroupOverlay.animations = @[opacity, transform];
        _animationGroupOverlay.fillMode = kCAFillModeForwards;
        _animationGroupOverlay.removedOnCompletion = NO;
        _animationGroupOverlay.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        _animationGroupOverlay.duration = _durationAnimation;
    }
}
#pragma mark - Action
-(void) animateToIndex:(NSInteger)index withCompletionBlock:(FeRaidlaButtonCompletionBlock)completionBlock
{
    if (_currentIndex == index)
        return;
    
    if (index < 0 || index >= _arrayOfButton.count)
    {
        NSLog(@"Index is out of range");
        return;
    }
    
    // Init
    [self initImageLayerAtIndex:index];
    
    // Set default transform
    _currentImageLayer.transform = CATransform3DIdentity;
    _nextImageLayer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    
    self.userInteractionEnabled = NO;
    
    // Set block end animtion
    FeBasicAnimationBlock *animationBlock_1 = [[FeBasicAnimationBlock alloc] init];
    _animationGroupFirst.delegate = animationBlock_1;
    animationBlock_1.blockDidStop = ^{
        // Enable
        self.userInteractionEnabled = YES;
        
        // Remove
        [self removeTarget:_currentRadialButton.target action:_currentRadialButton.selector forControlEvents:_currentRadialButton.controlEvent];
        
        // Set current option
        FeRadialButtonOption *nextOption = _arrayOfButton[index];
        _currentRadialButton = nextOption;
        
        // Add target - action
        [self addTarget:nextOption.target action:nextOption.selector forControlEvents:nextOption.controlEvent];
        
        // set current index
        _currentIndex = index;
        
        // exchange layer;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        [_currentImageLayer removeAllAnimations];
        _currentImageLayer.transform = CATransform3DIdentity;
        _currentImageLayer.opacity = 1;
        _currentImageLayer.contents = (id)nextOption.image.CGImage;
        
        [CATransaction commit];
        
        // Call block
        if (completionBlock)
            completionBlock(YES);
    };
    
    FeBasicAnimationBlock *animationBlock_2 = [[FeBasicAnimationBlock alloc] init];
    _animationGroupSecond.delegate = animationBlock_2;
    animationBlock_2.blockDidStop = ^{
        // release
        //[_nextImageLayer removeAllAnimations];
        [_nextImageLayer removeFromSuperlayer];
        _nextImageLayer = nil;
    };
    
    // Add animation
    [_currentImageLayer addAnimation:_animationGroupFirst forKey:@"first"];
    [_nextImageLayer addAnimation:_animationGroupSecond forKey:@"second"];
    [_circleLayer addAnimation:_animationGroupOverlay forKey:@"overlay"];
}
-(void) animateToNextIndexWithCompletionBlock:(FeRaidlaButtonCompletionBlock)completionBlock
{
    NSInteger nextIndex = _currentIndex + 1;
    if (nextIndex >= _arrayOfButton.count)
        nextIndex = 0;
    
    // animate
    [self animateToIndex:nextIndex withCompletionBlock:completionBlock];
}
-(void) initImageLayerAtIndex:(NSInteger)index
{
    // Release if it's exists
    if (_nextImageLayer)
    {
        if (_nextImageLayer.superlayer)
            [_nextImageLayer removeFromSuperlayer];
        
        // set is nil
        _nextImageLayer = nil;
    }
    else // init
    {
        _nextImageLayer = [CALayer layer];
        _nextImageLayer.frame = self.imageView.bounds;
        
        // Content
        FeRadialButtonOption *option = _arrayOfButton[index];
        _nextImageLayer.contentsGravity = kCAGravityResizeAspectFill;
        _nextImageLayer.contents = (id)(option.image.CGImage);
        _nextImageLayer.opacity = 0;
        
        [self.imageView.layer addSublayer:_nextImageLayer];
    }
}

#pragma mark - Override method

-(void) setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // Create fake transparent layer
    UIView *fakeView = [[UIView alloc] initWithFrame:self.imageView.bounds];
    fakeView.backgroundColor = [UIColor clearColor];
    
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, [UIScreen mainScreen].scale);
    [fakeView drawViewHierarchyInRect:self.imageView.bounds afterScreenUpdates:YES];
    
    UIImage *fakeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //
    UIGraphicsEndImageContext();
    
    [super setImage:fakeImage forState:UIControlStateNormal];
    self.imageView.clipsToBounds = NO;
}

@end


@interface FeRadialButtonOption ()

-(FeRadialButtonOption *) initWithImage:(UIImage *)image target:(id)targer action:(SEL)selector forEvent:(UIControlEvents)controlEvent atIndex:(NSUInteger)index;
@end

@implementation FeRadialButtonOption
+(FeRadialButtonOption *) radialButtonOptionWithImage:(UIImage *)image target:(id)targer action:(SEL)selector forEvent:(UIControlEvents)controlEvent atIndex:(NSUInteger)index
{
    FeRadialButtonOption *radialBtn = [[FeRadialButtonOption alloc] initWithImage:image target:targer action:selector forEvent:controlEvent atIndex:index];
    
    return radialBtn;
}
-(FeRadialButtonOption *) initWithImage:(UIImage *)image target:(id)targer action:(SEL)selector forEvent:(UIControlEvents)controlEvent atIndex:(NSUInteger)index
{
    self = [super init];
    if (self)
    {
        // Verify
        NSAssert(image, @"Image shouls NOT be nil");
        NSAssert(targer, @"Target shouls NOT be nil");
        NSAssert(selector, @"Selector shouls NOT be nil");
        NSAssert(controlEvent, @"ControlEvent shouls NOT be nil");
        NSAssert(index >= 0, @"Button's Index shouls more than zro");
        
        _image = image;
        
        _target = targer;
        
        _selector = selector;
        
        _index = index;
        
        _controlEvent = controlEvent;
    }
    return self;
}
@end