//
//  WBComposePhotoView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-12.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBComposePhotoView.h"

@implementation WBComposePhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _photos = [NSMutableArray array];
    }
    return self;
}

-(void)addPhoto:(UIImage *)image
{
    UIImageView *photo = [[UIImageView alloc] init];
    photo.image = image;
    [self.photos addObject:image];
    [self addSubview:photo];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger photocount = self.subviews.count;
    int maxcol = 4;
    CGFloat WBComposePhotoWH = 70;
    CGFloat WBComposePhotoMargin = 10;
    // CGSize photosize =
    for (int i=0; i<photocount; i++) {
        UIImageView *photoView = self.subviews[i];
        int col = i % maxcol ;
        CGFloat photoViewX = col * (WBComposePhotoWH + WBComposePhotoMargin);
        int row = i/maxcol ;
        CGFloat photoViewY = row *(WBComposePhotoWH + WBComposePhotoMargin);
        CGFloat photoViewW = WBComposePhotoWH;
        CGFloat photoviewH = WBComposePhotoWH;
        photoView.frame = CGRectMake(photoViewX, photoViewY, photoViewW, photoviewH);
        
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
