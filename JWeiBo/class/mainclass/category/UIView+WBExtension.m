//
//  UIView+WBExtension.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/5.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "UIView+WBExtension.h"

@implementation UIView (WBExtension)

-(CGFloat)wb_height
{
    return self.frame.size.height;
}

- (void)setWb_height:(CGFloat)wb_height
{
    CGRect temp = self.frame;
    temp.size.height = wb_height;
    self.frame = temp;
}

- (CGFloat)wb_width
{
    return self.frame.size.width;
}

- (void)setWb_width:(CGFloat)wb_width
{
    CGRect temp = self.frame;
    temp.size.width = wb_width;
    self.frame = temp;
}

- (CGFloat)wb_x
{
    return  self.frame.origin.x;
}

-(void)setWb_x:(CGFloat)wb_x
{
    CGRect temp = self.frame;
    temp.origin.x = wb_x;
    self.frame = temp;
}

-(CGFloat)wb_y
{
    return self.frame.origin.y;
}

-(void)setWb_y:(CGFloat)wb_y
{
    CGRect temp = self.frame;
    temp.origin.y = wb_y;
    self.frame = temp;
}

@end
