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
static char key_groupAnimation;
static char key_isAnimate;

@implementation UILabel (ResponsiveInteraction)

#pragma mark - Init
-(void) initDefault
{
    [self initCommon];
    
    [self initShadow];
    
    [self initGesture];
    
    [self initAnimation];
}
-(void) initCommon
{
    [self set_isActive:YES];
    
    [self set_isAnimate:NO];
    
    self.userInteractionEnabled = YES;
}
-(void) initShadow
{
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.4f;
    self.layer.shadowOffset = CGSizeMake(0, 2);
}
-(void) initAnimation
{
    ////////////
    // Define
    CGFloat duration = 0.3f;
    
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
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group = [CAAnimationGroup animation];
    group.duration = duration;
    group.animations = @[liftAnimation, shadowOffsetAnimation, shadowRaidusAnimation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    // Set
    [self set_groupAnimation:group];
}
-(void) initGesture
{
    UILongPressGestureRecognizer *panGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
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
-(void) set_groupAnimation:(CAAnimationGroup *) groupAnimation
{
    objc_setAssociatedObject(self, &key_groupAnimation, groupAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CAAnimationGroup *) get_groupAnimation
{
    CAAnimationGroup *group = objc_getAssociatedObject(self, &key_groupAnimation);
    
    return group;
}

// isAnimate
-(void) set_isAnimate:(BOOL) isAnimate
{
    objc_setAssociatedObject(self, &key_isAnimate, [NSNumber numberWithBool:isAnimate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL) get_isAnimate
{
    NSNumber *isAnimate = (NSNumber *)objc_getAssociatedObject(self, &key_isAnimate);
    return isAnimate.boolValue;
}
#pragma mark - Gesture
-(void) handleTapGesture:(UILongPressGestureRecognizer *) sender
{
    
    //NSLog(@"tap label");
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            CAAnimationGroup *group = [self get_groupAnimation];
            
            // Delegate object
            FeBasicAnimationBlock *blockObj = [[FeBasicAnimationBlock alloc] init];
            group.delegate = blockObj;
            blockObj.blockDidStop = ^
            {
                [self set_isAnimate:NO];
            };
            
            // Add animation
            [self.layer addAnimation:group forKey:@"group"];
            
            // is Animating
            [self set_isAnimate:YES];
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint locationTouch = [sender locationInView:self.superview];
            
            if (CGRectContainsPoint(self.frame, locationTouch))
            {
                
            }
            else // Out-side
            {
                NSLog(@"out-side - %@",[self get_isAnimate] ? @"YES" : @"NO");
                
                if ([self get_isAnimate])
                {
                    
                }
                else
                {
                    // Reverse animate at end animation
                    self.layer.speed = -1;
                }
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            
            break;
        }
        default:
            break;
    }
    
}




#pragma mark - Action
-(void) activeResponsiveInteraction
{
    [self initDefault];
}
-(void) disableResponsiveInteraction
{
    
}


@end
