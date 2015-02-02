//
//  FeBasicAnimationBlock.h
//  AlbumCouple
//
//  Created by Nghia Tran on 4/17/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^FeBasicAnimationDidStartBlock)();
typedef void (^FeBasicAnimationDidStopBlock)();

@interface FeBasicAnimationBlock : NSObject
@property (copy, nonatomic) FeBasicAnimationDidStartBlock blockDidStart;
@property (copy, nonatomic) FeBasicAnimationDidStopBlock blockDidStop;

-(void) animationDidStart:(CAAnimation *)anim;
-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
@end
