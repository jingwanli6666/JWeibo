//
//  WBEmotionButton.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-20.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBEmotionButton.h"
#import "WBEmotion.h"

@implementation WBEmotionButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }else if(emotion.code)
    {
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
        [self setup];
    }

}

-(void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted = NO;

}



@end
