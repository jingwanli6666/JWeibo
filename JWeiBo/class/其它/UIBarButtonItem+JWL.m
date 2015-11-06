//
//  UIBarButtonItem+JWL.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-18.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "UIBarButtonItem+JWL.h"

@implementation UIBarButtonItem (JWL)


/**
 *  快速创建一个显示图片的item
 *
 *  @param icon
 *  @param highIcon
 *  @param action   监听方法
 *
 *  @return UIBarButtonItem
 */

-(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

@end
