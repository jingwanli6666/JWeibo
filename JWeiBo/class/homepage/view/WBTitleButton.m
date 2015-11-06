//
//  WBTitleButton.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-18.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBTitleButton.h"

#define WBTitleButtonImageW 20

@implementation WBTitleButton

+(instancetype)titleButon
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode =  UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //背景
        [self setBackgroundImage:[UIImage resizeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
   
    CGFloat imageY = 0;
    CGFloat imageW =  WBTitleButtonImageW;
    CGFloat imageX =contentRect.size.width -imageW;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width -WBTitleButtonImageW;;
    CGFloat titleX =0;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    CGFloat titleW = [title sizeWithFont:self.titleLabel.font].width;
    
    CGRect frame = self.frame;
    frame.size.width = titleW + WBTitleButtonImageW + 5;
    self.frame = frame;
    
    [super setTitle:title forState:state];
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
