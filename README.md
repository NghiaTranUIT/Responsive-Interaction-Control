Responsive-Interaction-Control
==============================

Bring whole-new Android's animation L to iOS.

Inspired by Material Design Google.

Youtube : https://www.youtube.com/watch?v=r84BhwLcVoo&feature=youtu.be

## In Brief
Responsive Interaction Control contain many catogories and customize control.

**UILabel+ResponsiveInteraction** : UILabel Category for Material response Effect.

![GIF](http://nghiatran.me/wp-content/uploads/2014/07/UILabel_Responsive_Interaction.gif)

**UIButton+ResponsiveInteraction** : UIButton Category for Material response Effect.

![GIF](http://nghiatran.me/wp-content/uploads/2014/07/UIButton_Responsive_Interaction.gif)

**FeRadialButton** : Sublcass of UIButton for Radial Action effect.

![GIF](http://nghiatran.me/wp-content/uploads/2014/07/RadialButton.gif)

**FeRippleButton** : Sublcass of UIButton for Surface Rection effect.

![GIF](http://nghiatran.me/wp-content/uploads/2014/07/RippleButton.gif)

## Requirement

So You must ensure your project has iOS version more than iOS 7.0.

And compatible with ARC or non-ARC.

## How to use

### UIButton, UILabel catogeries
Ex :
```objc
@interface UIButton (ResponsiveInteraction) <UIGestureRecognizerDelegate>

// Active
-(void) activeResponsiveInteraction;

// Disable
-(void) disableResponsiveInteraction;

// Track Global touch
-(void) setGlobalResponsiveInteractionWithView:(UIView *) view;

@end
```
Using :
```objc
// Active effect
        [label activeResponsiveInteraction];
        [label setGlobalResponsiveInteractionWithView:self.view];
```

### Radial Button

```objc
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

```
Using :
```objc
-(void) initRadialButton
{
    // Create each option for Radial button
    FeRadialButtonOption *option_1 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_btn"] target:self action:@selector(btn_1_tapped:) forEvent:UIControlEventTouchUpInside atIndex:0];
    FeRadialButtonOption *option_2 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_option"] target:self action:@selector(btn_2_tapped:) forEvent:UIControlEventTouchUpInside atIndex:1];
    FeRadialButtonOption *option_3 = [FeRadialButtonOption radialButtonOptionWithImage:[UIImage imageNamed:@"icon_back"] target:self action:@selector(btn_3_tapped:) forEvent:UIControlEventTouchUpInside atIndex:1];
    
    // Init Radial button with these Option
    _radialBtn = [[FeRadialButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, 400, 200, 50) radialButtonOptions:@[option_1 , option_2, option_3]];
    _radialBtn.center = self.view.center;
    
    [self.view addSubview:_radialBtn];
}
```

### Ripple Button

```objc
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
```
Using :
```objc
-(void) initRippleButtonWithRippleOverBound
{
    // init
    _rippleButton_1 = [[FeRippleButton alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    _rippleButton_1.center = CGPointMake(self.view.center.x, 100);
    [_rippleButton_1 setTitle:@"Button" forState:UIControlStateNormal];
    _rippleButton_1.backgroundColor = [UIColor clearColor];
    [_rippleButton_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _rippleButton_1.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    
    // Configure
    _rippleButton_1.rippleOverBound = YES;
    
    [self.view addSubview:_rippleButton_1];
```

## MIT License
Copyright (c) 2014 Nghia Tran

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Release notes

Version 1.0

Initial release
