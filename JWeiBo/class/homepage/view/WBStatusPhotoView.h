//
//  WBStatusPhotoView.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-6.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//  cell上面的配图(里面会显示多张图片)

#import <UIKit/UIKit.h>

@interface WBStatusPhotoView : UIView

@property (nonatomic,strong) NSArray *photos;

+(CGSize)photosSizeWithCount:(int)count;
@end
