//
//  WBBadgeButton.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-17.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBBadgeButton.h"

@implementation WBBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizeImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    if (badgeValue) {
            self.hidden = NO;
            //设置文字
            [self setTitle:badgeValue forState:UIControlStateNormal];
            //设置frame
            CGRect frame = self.frame;
            
            CGFloat badgeW = self.currentBackgroundImage.size.width;
            
            CGFloat badgeH = self.currentBackgroundImage.size.height;
            if (badgeValue.length >1) {
                CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
                badgeW = badgeSize.width + 10;
            }
            frame.size.width = badgeW;
            frame.size.height = badgeH;
            self.frame = frame;
        }else{
        self.hidden = YES;
    }
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
