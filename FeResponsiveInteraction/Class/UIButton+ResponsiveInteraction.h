//
//  UIButton+ResponsiveInteraction.h
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 6/30/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ResponsiveInteraction) <UIGestureRecognizerDelegate>

// Active
-(void) activeResponsiveInteraction;

// Disable
-(void) disableResponsiveInteraction;

// Track Global touch
-(void) setGlobalResponsiveInteractionWithView:(UIView *) view;

@end