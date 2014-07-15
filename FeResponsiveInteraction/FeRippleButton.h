//
//  FeRippleButton.h
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 7/15/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeRippleButton : UIButton
// Ripple Over Bound
@property (assign, nonatomic) BOOL rippleOverBound;

// Ripple Color
@property (strong, nonatomic) UIColor *rippleColor;

// Ripple Background Color
@property (strong, nonatomic) UIColor *rippleBackgroundColor;

// Shadow Radius
@property (assign, nonatomic) CGFloat shadowRippleRadius;

// Enable
@property (assign, nonatomic) BOOL shadowRippleEnable;

// TrackTouch
@property (assign, nonatomic) BOOL trackTouchLocation;

-(id) initWithFrame:(CGRect)frame;
@end
