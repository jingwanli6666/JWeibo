//
//  WBEmotionAttachment.m
//  JWeiBo
//
//  Created by bcc_cae on 15-11-4.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBEmotionAttachment.h"
#import "WBEmotion.h"


@implementation WBEmotionAttachment

-(void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageWithName:emotion.png];
}
@end
