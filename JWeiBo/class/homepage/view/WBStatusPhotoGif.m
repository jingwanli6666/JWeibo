//
//  WBStatusPhotoGif.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-7.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBStatusPhotoGif.h"
#import "UIImageView+WebCache.h"
#import "WBphoto.h"

@interface WBStatusPhotoGif()
@property (nonatomic,weak) UIImageView *gif;
@end

@implementation WBStatusPhotoGif

-(UIImageView *)gif
{
    if (_gif == nil) {
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gif = [[UIImageView alloc] initWithImage:image];
        
        [self addSubview:gif];
        _gif = gif;
    }
    return _gif;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
           }
    return self;
}

-(void)setPhoto:(WBphoto *)photo
{
    _photo = photo;
    
    //设置图片
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
         //显示或者隐藏gif控件
    
    //WBLog(@"---%@",photo.thumbnail_pic);
    
    self.gif.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
    
}


-(void)layoutSubviews
{
    CGFloat gifX = self.frame.size.width - self.gif.frame.size.width;
    CGFloat gifY = self.frame.size.height - self.gif.frame.size.height;
    self.gif.frame = CGRectMake(gifX, gifY, self.gif.frame.size.width, self.gif.frame.size.height);
}


@end
