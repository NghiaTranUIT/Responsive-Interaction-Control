//
//  UILabel+ResponsiveInteraction.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 6/27/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "UILabel+ResponsiveInteraction.h"
#import "FeBasicAnimationBlock.h"
#import <objc/runtime.h>

// Key
static char key_isActive;
static char key_groupAnimation_lift_up;
static char key_groupAnimation_lift_down;
static char key_animation_state;
static char key_current_touch;

// Define State
#define kFe_State_Stop_InGround 1
#define kFe_State_Stop_InAir 2
#define kFe_State_Lifting_Up 3
#define kFe_State_Lifting_Down 4

@implementation UILabel (ResponsiveInteraction)

#pragma mark - Init
-(void) initDefault
{
    [self initCommon];
    
    [self initShadow];
    
    //[self initGesture];
    
    [self initAnimationLift];
}
-(void) initCommon
{
    
    [self set_isActive:YES];
    
    [self set_animation_state:kFe_State_Stop_InGround];
    
    self.userInteractionEnabled = YES;
}
-(void) initShadow
{
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.4f;
    self.layer.shadowOffset = CGSizeMake(0, 2);
}
-(void) initAnimationLift
{
    ////////////////////////////////////////////
    ////////////////////////////////////////////////
    // Define
    CGFloat duration = 0.3f;
    
    if (YES)
    {
        /////////////
        // Transform
        CATransform3D t = CATransform3DIdentity;
        t.m34 = - 1.0f / 800.0f;
        t = CATransform3DTranslate(t, 0, 0, 200);
        
        CABasicAnimation *liftAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        liftAnimation.toValue = (id) [NSValue valueWithCATransform3D:t];
        liftAnimation.duration = duration;
        liftAnimation.fillMode = kCAFillModeForwards;
        liftAnimation.removedOnCompletion = NO;
        liftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Shadow Offset
        CABasicAnimation *shadowOffsetAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
        shadowOffsetAnimation.toValue = (id) [NSValue valueWithCGSize:CGSizeMake(0, 7)];
        shadowOffsetAnimation.duration = duration;
        shadowOffsetAnimation.fillMode = kCAFillModeForwards;
        shadowOffsetAnimation.removedOnCompletion = NO;
        shadowOffsetAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Shadow Radius
        CABasicAnimation *shadowRaidusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        shadowRaidusAnimation.toValue = (id) [NSNumber numberWithFloat:5];
        shadowRaidusAnimation.duration = duration;
        shadowRaidusAnimation.fillMode = kCAFillModeForwards;
        shadowRaidusAnimation.removedOnCompletion = NO;
        shadowRaidusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group = [CAAnimationGroup animation];
        group.duration = duration;
        group.animations = @[liftAnimation, shadowOffsetAnimation, shadowRaidusAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Set
        [self set_groupAnimation_lift_up:group];
    }
    /////////////////////////////////////////
    ////////////////////////////////////////
    if (YES)
    {
        /////////////
        // Transform
        CATransform3D t = CATransform3DIdentity;
        t.m34 = - 1.0f / 800.0f;
        
        CABasicAnimation *liftAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        liftAnimation.toValue = (id) [NSValue valueWithCATransform3D:t];
        liftAnimation.duration = duration;
        liftAnimation.fillMode = kCAFillModeForwards;
        liftAnimation.removedOnCompletion = NO;
        liftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Shadow Offset
        CABasicAnimation *shadowOffsetAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
        shadowOffsetAnimation.toValue = (id) [NSValue valueWithCGSize:CGSizeMake(0, 2)];
        shadowOffsetAnimation.duration = duration;
        shadowOffsetAnimation.fillMode = kCAFillModeForwards;
        shadowOffsetAnimation.removedOnCompletion = NO;
        shadowOffsetAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Shadow Radius
        CABasicAnimation *shadowRaidusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        shadowRaidusAnimation.toValue = (id) [NSNumber numberWithFloat:3];
        shadowRaidusAnimation.duration = duration;
        shadowRaidusAnimation.fillMode = kCAFillModeForwards;
        shadowRaidusAnimation.removedOnCompletion = NO;
        shadowRaidusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group = [CAAnimationGroup animation];
        group.duration = duration;
        group.animations = @[liftAnimation, shadowOffsetAnimation, shadowRaidusAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Set
        [self set_groupAnimation_lift_down:group];
    }
}
-(void) initGesture
{
    UILongPressGestureRecognizer *panGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    panGesture.minimumPressDuration = 0.05f;
    
    [self addGestureRecognizer:panGesture];
}

#pragma mark - Getter / Setter

// isActive
-(void) set_isActive:(BOOL) isActive
{
    objc_setAssociatedObject(self, &key_isActive, [NSNumber numberWithBool:isActive], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL) get_isActive
{
    NSNumber *isActive = (NSNumber *) objc_getAssociatedObject(self, &key_isActive);
    return isActive.boolValue;
}

// groupAnimation
-(void) set_groupAnimation_lift_up:(CAAnimationGroup *) groupAnimation
{
    objc_setAssociatedObject(self, &key_groupAnimation_lift_up, groupAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CAAnimationGroup *) get_groupAnimation_lift_up
{
    CAAnimationGroup *group = objc_getAssociatedObject(self, &key_groupAnimation_lift_up);
    
    return group;
}
-(void) set_groupAnimation_lift_down:(CAAnimationGroup *) groupAnimation
{
    objc_setAssociatedObject(self, &key_groupAnimation_lift_down, groupAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CAAnimationGroup *) get_groupAnimation_lift_down
{
    CAAnimationGroup *group = objc_getAssociatedObject(self, &key_groupAnimation_lift_down);
    
    return group;
}

// Animation State
-(void) set_animation_state:(NSInteger) state
{
    objc_setAssociatedObject(self, &key_animation_state, [NSNumber numberWithInteger:state], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger) get_isAnimate_state
{
    NSNumber *state = (NSNumber *)objc_getAssociatedObject(self, &key_animation_state);
    return state.integerValue;
}
// Current touch
-(void) set_current_touch:(CGPoint) point
{
    objc_setAssociatedObject(self, &key_current_touch, [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGPoint) get_current_touch
{
    NSValue *value = (NSValue *)objc_getAssociatedObject(self, &key_current_touch);
    return value.CGPointValue;
}
#pragma mark - Gesture
-(void) handleGesture:(UILongPressGestureRecognizer *) sender
{
    
    //NSLog(@"tap label");
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint locationTouch = [sender locationInView:self.superview];
            if (CGRectContainsPoint(self.frame, locationTouch))
            {
                if ([self get_isAnimate_state] == kFe_State_Stop_InGround)
                {
                    CGPoint locationInside = [sender locationInView:self];
                    [self liftUpAnimationAtPoint:locationInside];
                }
            }
            
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint locationTouch = [sender locationInView:self.superview];
            CGPoint locationInside = [sender locationInView:self];
            
            // Save current touch's point
            [self set_current_touch:locationTouch];
            
            
            if (CGRectContainsPoint(self.frame, locationTouch))
            {
                if ([self get_isAnimate_state] == kFe_State_Stop_InGround)
                {
                    [self liftUpAnimationAtPoint:locationInside];
                }
                if ([self get_isAnimate_state] == kFe_State_Stop_InAir)
                {
                    
                }
            }
            else // Out-side
            {
                //NSLog(@"out-side - %@",[self get_isAnimate] ? @"YES" : @"NO");
                
                if ([self get_isAnimate_state] == kFe_State_Lifting_Up)
                {
                    
                }
                else if ([self get_isAnimate_state] == kFe_State_Stop_InAir)
                {
                    [self liftDownAnimationAtPoint:locationInside];
                }
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if ([self get_isAnimate_state] == kFe_State_Stop_InAir)
            {
                CGPoint locationInside = [sender locationInView:self];
                [self liftDownAnimationAtPoint:locationInside];
            }
            if ([self get_isAnimate_state] == kFe_State_Lifting_Up)
            {
                CGPoint locationInside = [sender locationInView:self];
                [self liftDownAnimationAtPoint:locationInside];
            }
            
            // Release Current touch
            [self set_current_touch:CGPointMake(-100, -100)];
            
            break;
        }
        default:
            break;
    }
    
}

-(void) liftUpAnimationAtPoint:(CGPoint) point
{
    CAAnimationGroup *groupLift = [self get_groupAnimation_lift_up];
    
    // Delegate object
    FeBasicAnimationBlock *blockObj = [[FeBasicAnimationBlock alloc] init];
    groupLift.delegate = blockObj;
    blockObj.blockDidStop = ^
    {
        // Check if animation is stopped, and current touch is not inside cell
        // Just fire lift down animation.
        if (!CGRectContainsPoint(self.frame, [self get_current_touch]))
        {
            [self liftDownAnimationAtPoint:point];
        }
        else
        {
            // Save state
            [CATransaction begin];
            [CATransaction disableActions];
            
            CATransform3D t = CATransform3DIdentity;
            t.m34 = - 1.0f / 800.0f;
            t = CATransform3DTranslate(t, 0, 0, 200);
            
            self.layer.transform = t;
            self.layer.shadowOffset = CGSizeMake(0, 7);
            self.layer.shadowRadius = 5;
            
            // REMOVE
            [self.layer removeAllAnimations];
            
            [CATransaction commit];
            
            // State
            [self set_animation_state:kFe_State_Stop_InAir];
        }
        
        
    };
    

    
    // Add animation
    [self.layer addAnimation:groupLift forKey:@"liftUP"];

    // is Animating
    [self set_animation_state:kFe_State_Lifting_Up];
}
-(void) liftDownAnimationAtPoint:(CGPoint) point
{
    // Reverse animate at end animation
    CAAnimationGroup *group = [self get_groupAnimation_lift_down];

    // Set position
    //circleLayer.position = point;
    
    // Delegate object
    FeBasicAnimationBlock *blockObj = [[FeBasicAnimationBlock alloc] init];
    group.delegate = blockObj;
    blockObj.blockDidStop = ^
    {
        // Save state
        [CATransaction begin];
        [CATransaction disableActions];
        
        CATransform3D t = CATransform3DIdentity;
        
        self.layer.transform = t;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowRadius = 3;
        
        // REMOVE
        [self.layer removeAllAnimations];
        
        [CATransaction commit];
        
        
        
        // State
        [self set_animation_state:kFe_State_Stop_InGround];
    };
    
    [self.layer addAnimation:group forKey:@"liftDown"];
    [self set_animation_state:kFe_State_Lifting_Down];
}

#pragma mark - Action
-(void) activeResponsiveInteraction
{
    [self initDefault];
}
-(void) disableResponsiveInteraction
{
    
}
-(void) setGlobleResponsiveInteractionWithView:(UIView *)view
{
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    longGesture.minimumPressDuration = 0.01f;
    longGesture.delegate = self;
    
    [view addGestureRecognizer:longGesture];
}

#pragma mark - Gesture Delegate
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
