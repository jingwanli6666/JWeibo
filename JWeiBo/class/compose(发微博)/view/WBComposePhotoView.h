//
//  WBComposePhotoView.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-12.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBComposePhotoView : UIView
-(void)addPhoto:(UIImage *)image;
@property (nonatomic,copy,readonly) NSMutableArray *photos;
@end
