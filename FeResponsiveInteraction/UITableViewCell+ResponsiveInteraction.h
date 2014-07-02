//
//  UITableViewCell+ResponsiveInteraction.h
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 7/2/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ResponsiveInteraction)
// Active
-(void) activeResponsiveInteraction;

// Disable
-(void) disableResponsiveInteraction;

// Globel
-(void) setGlobleResponsiveInteractionWithView:(UIView *) view;

@end
