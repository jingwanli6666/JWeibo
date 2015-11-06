//
//  WBEmotionBarBarButton.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-15.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBEmotionBarBarButton.h"

@implementation WBEmotionBarBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
