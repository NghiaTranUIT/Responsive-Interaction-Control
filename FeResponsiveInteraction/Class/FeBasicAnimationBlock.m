//
//  FeBasicAnimationBlock.m
//  AlbumCouple
//
//  Created by Nghia Tran on 4/17/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "FeBasicAnimationBlock.h"

@implementation FeBasicAnimationBlock
-(void) animationDidStart:(CAAnimation *)anim
{
    if (_blockDidStart)
        _blockDidStart();
}
-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_blockDidStop)
        _blockDidStop();
}
@end
