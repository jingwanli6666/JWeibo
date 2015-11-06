//
//  WBStatusPhotoView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-6.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBStatusPhotoView.h"
#import "WBphoto.h"

#import "WBStatusPhotoGif.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define WBStatusPhotoWH 70
#define WBStatusPhotoMargin 10
#define WBStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation WBStatusPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = photos.count;
    
    //创建足够数量的图片控件
    int i = -1;
    while (self.subviews.count < photosCount) {
        ++i;
        WBStatusPhotoGif *photoView = [[WBStatusPhotoGif alloc] init];
        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
        //[self addGestureRecognizer:([UITapGestureRecognizer alloc] initWithTarget:self action:@selector((photoTap:)]);
        photoView.userInteractionEnabled = YES;
        photoView.tag = i;

        [self addSubview:photoView];
    }
    
    //遍历所有图片控件，设置图片
    for (int i=0; i<self.subviews.count; i++) {
        WBStatusPhotoGif *photoView = self.subviews[i];
        if (i < photosCount) {
           photoView.hidden = NO;
           photoView.photo = photos[i];          
        }else{
            photoView.hidden = YES;
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int photocount = self.photos.count;
    int maxcol = WBStatusPhotoMaxCol(photocount);
   // CGSize photosize =
    for (int i=0; i<photocount; i++) {
        WBStatusPhotoGif *photoView = self.subviews[i];
        int col = i % maxcol ;
       CGFloat photoViewX = col * (WBStatusPhotoWH + WBStatusPhotoMargin);
        int row = i/maxcol ;
        CGFloat photoViewY = row *(WBStatusPhotoWH + WBStatusPhotoMargin);
        CGFloat photoViewW = WBStatusPhotoWH;
        CGFloat photoviewH = WBStatusPhotoWH;
        photoView.frame = CGRectMake(photoViewX, photoViewY, photoViewW, photoviewH);

    }
}

+(CGSize)photosSizeWithCount:(int)count
{
#warning TODO  配图尺寸
    // 列数
    int maxcol = WBStatusPhotoMaxCol(count);
    int cols = (count >= maxcol) ? maxcol:count;
    CGFloat photosW = cols *WBStatusPhotoWH + (cols - 1) *WBStatusPhotoMargin;
    
    //行数
    int rows = (count + maxcol -1)/maxcol;
    CGFloat photosH = rows * WBStatusPhotoWH + (rows - 1) *WBStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}


-(void)photoTap:(UITapGestureRecognizer *)recognizer
{
    //WBLog(@"点击了图片---%d",recognizer.view.tag);
    int count = self.photos.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        //NSString *url = [_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        //一个MJPhoto应显示一张图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        WBphoto *wbphoto = self.photos[i];
        NSString *url = wbphoto.thumbnail_pic;
        url = [url stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        mjphoto.url = [NSURL URLWithString:url]; // 图片路径
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];

}

@end
