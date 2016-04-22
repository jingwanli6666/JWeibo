//
//  WBSquareTableViewHeaderItemButton.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/5.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBSquareTableViewHeaderItemButton.h"

@implementation WBSquareTableViewHeaderItemButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = contentRect.size.width * 0.2;
    CGFloat y = contentRect.size.height * 0.15;
    CGFloat w = contentRect.size.width - x * 2;
    CGFloat h = contentRect.size.height * 0.5;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(0, contentRect.size.height * 0.65, contentRect.size.width, contentRect.size.height * 0.3);
    return rect;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}



@end
