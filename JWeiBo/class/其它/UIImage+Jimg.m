//
//  UIImage+Jimg.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "UIImage+Jimg.h"

@implementation UIImage (Jimg)

+(UIImage *)imageWithName:(NSString *)imageName
{
    if (IOS7) {
        NSString *newimagename = [imageName stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newimagename];
        if (image == nil) { //没有_os7后缀的图片
            image = [UIImage imageNamed:imageName];
        }
        return image;
    }
    //非ios7
    return [UIImage imageNamed:imageName];
}

+(UIImage *)resizeImageWithName:(NSString *)name
{
    return [UIImage resizeImageWithName:name left:0.5 top:0.5];
}

+(UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}


@end
