//
//  CALayer+Animation.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/14.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "CALayer+Animation.h"

@implementation CALayer (Animation)

-(void)shake{
    
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 16;
    
    keyframeAni.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s)];
    
    //时长
    keyframeAni.duration = 0.1f;
    
    //重复
    keyframeAni.repeatCount = 2;
    
    //移除
    keyframeAni.removedOnCompletion = YES;
    
    [self addAnimation:keyframeAni forKey:@"shake"];
    
}

@end
