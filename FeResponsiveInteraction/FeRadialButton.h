//
//  FeRadialButton.h
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 6/30/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import <UIKit/UIKit.h>

// Option
@interface FeRadialButtonOption : NSObject
// UIImage
@property (strong, readonly, nonatomic) UIImage *image;

// Index
@property (assign, nonatomic) NSUInteger index;

// Target
@property (copy, nonatomic, readonly) id target;

// Action
@property (assign, nonatomic , readonly) SEL selector;

// Event
@property (assign, nonatomic, readonly) UIControlEvents controlEvent;

/////////////////////
// Method
+(FeRadialButtonOption *) radialButtonOptionWithImage:(UIImage *) image target:(id) targer action:(SEL) selector forEvent:(UIControlEvents) controlEvent atIndex:(NSUInteger) index;
@end

// Completion Block
typedef void (^FeRaidlaButtonCompletionBlock)(BOOL finish);

@interface FeRadialButton : UIButton

// Duration of animation
@property (assign, nonatomic) CGFloat durationAnimation;

// Current index
@property (assign, readonly, nonatomic) CGFloat currentIndex;

// Current Option
@property (weak, nonatomic, readonly) FeRadialButtonOption *currentRadialButton;

// Array of button
@property (strong, nonatomic, readonly) NSArray *arrayOfButton;

//////////////////////////
// init
-(instancetype) initWithFrame:(CGRect)frame radialButtonOptions:(NSArray *) arrayOfOption;

// Animate to index button
-(void) animateToIndex:(NSInteger) index withCompletionBlock:(FeRaidlaButtonCompletionBlock) completionBlock;

// Animate To next index
-(void) animateToNextIndexWithCompletionBlock:(FeRaidlaButtonCompletionBlock) completionBlock;
@end
