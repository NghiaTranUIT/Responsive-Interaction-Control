//
//  FeRippleButton.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 7/15/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeRippleButton.h"
#import <QuartzCore/QuartzCore.h>

@interface FeRippleButton ()
// Ripple View
@property (strong, nonatomic) UIView *rippleView;

// Ripple background view
@property (strong, nonatomic) UIView *rippleBackgroundView;

@property (assign, nonatomic) CGFloat tempShadowRadius;

@property (assign, nonatomic) CGFloat tempShadowOpacity;

////////
-(void) initCommon;
-(void) initRippleView;

@end

@implementation FeRippleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        [self initRippleView];
        
        [self initCommon];
    }
    return self;
}
-(void) initCommon
{
    _rippleOverBound = NO;
    [self setRippleColor:[UIColor colorWithWhite:0.9f alpha:1.0f]];
    [self setBackgroundColor:[UIColor colorWithWhite:0.95f alpha:1]];
    
    _shadowRippleRadius = 5;
    _shadowRippleEnable = YES;
    _trackTouchLocation = NO;
    
    _tempShadowOpacity = 0;
    _tempShadowRadius = 0;
}
-(void) initRippleView
{
    CGFloat rippleWidthPercent = 0.9f;
    CGFloat size = CGRectGetWidth(self.bounds) * rippleWidthPercent;
    CGFloat x = (CGRectGetWidth(self.bounds)/2) - (size/2);
    CGFloat y = (CGRectGetHeight(self.bounds)/2) - (size/2);
    CGFloat corner = size / 2.0f;
    
    // Ripple View
    _rippleView = [[UIView alloc] init];
    _rippleView.backgroundColor = _rippleColor;
    _rippleView.frame = CGRectMake(x, y, size, size);
    _rippleView.layer.cornerRadius = corner;
    
    // Ripple Backfround view
    _rippleBackgroundView = [[UIView alloc] init];
    _rippleBackgroundView.backgroundColor = _rippleBackgroundColor;
    _rippleBackgroundView.frame = self.bounds;
    _rippleBackgroundView.alpha = 0;
    
    [self setRippleOverBound:NO];
    
    [self.layer addSublayer:_rippleBackgroundView.layer];
    [_rippleBackgroundView.layer addSublayer:_rippleView.layer];
    
    self.layer.shadowRadius = 0;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5f].CGColor;
    
}
#pragma mark - Getter / setter
-(void) setRippleOverBound:(BOOL)rippleOverBound
{
    _rippleOverBound = rippleOverBound;
    
    if (rippleOverBound)
    {
        _rippleBackgroundView.layer.mask = nil;
    }
    else
    {
        // Path
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius];
        
        CAShapeLayer *maskShapeLayer = [CAShapeLayer layer];
        maskShapeLayer.path = path.CGPath;
        
        _rippleBackgroundView.layer.mask = maskShapeLayer;
    }

}
-(void) setRippleColor:(UIColor *)rippleColor
{
    if (_rippleColor == rippleColor)
        return;
    
    _rippleColor = rippleColor;
    
    _rippleView.backgroundColor = _rippleColor;
}
-(void) setRippleBackgroundColor:(UIColor *)rippleBackgroundColor
{
    if (_rippleBackgroundColor == rippleBackgroundColor)
        return;
    
    _rippleBackgroundColor = rippleBackgroundColor;
    
    _rippleBackgroundView.backgroundColor = _rippleBackgroundColor;
}
-(BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (_trackTouchLocation)
    {
        _rippleView.center = [touch locationInView:self];
    }
    
    [UIView animateWithDuration:0.1f animations:^{
        _rippleBackgroundView.alpha = 1;
    }];
    
    _rippleView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    
    [UIView animateWithDuration:-.7f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _rippleView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    if (_shadowRippleEnable)
    {
        _tempShadowRadius = self.layer.shadowRadius;
        _tempShadowOpacity = self.layer.shadowOpacity;
        
        CABasicAnimation *shadowAnim = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        shadowAnim.toValue = [NSNumber numberWithFloat:_shadowRippleRadius];
        
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        opacityAnim.toValue = [NSNumber numberWithFloat:1.0f];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 0.7f;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.animations = @[shadowAnim, opacityAnim];
        
        [self.layer addAnimation:group forKey:@"shadow"];
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}
-(void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    
    [UIView animateWithDuration:0.1f animations:^{
        _rippleBackgroundView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6f animations:^{
            _rippleBackgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    [UIView animateWithDuration:0.7f delay:0 options:UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
        _rippleView.transform = CGAffineTransformIdentity;
        
        CABasicAnimation *shadowAnim = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        shadowAnim.toValue = [NSNumber numberWithFloat:_tempShadowRadius];
        
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
        opacityAnim.toValue =[NSNumber numberWithFloat:_tempShadowOpacity];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = 0.7f;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.animations = @[shadowAnim, opacityAnim];
        
        [self.layer addAnimation:group forKey:@"shadowBack"];
        
        
    } completion:nil];
}
@end
