//
//  WBServiceListItemButton.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/6.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBServiceListItemButton.h"
#import "UIView+WBExtension.h"

@implementation WBServiceListItemButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = self.wb_height * 0.3;
    CGFloat w = h;
    CGFloat x = (self.wb_width - w) * 0.5;
    CGFloat y = self.wb_height * 0.3;
    return CGRectMake(x, y, w, h);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.wb_height * 0.6, self.wb_width, self.wb_height * 0.3);
}
@end
