//
//  UIImage+Jimg.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Jimg)

+(UIImage *)imageWithName:(NSString *)imageName;
/**
 *  返回一张自由拉伸的图片
 *
 *  @param name name description
 *
 *  @return <#return value description#>
 */
+(UIImage *)resizeImageWithName:(NSString *)name;

+(UIImage *)resizeImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
@end
