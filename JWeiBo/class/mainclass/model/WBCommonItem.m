//
//  WBCommonItem.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-21.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBCommonItem.h"

@implementation WBCommonItem

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    WBCommonItem *item = [[self alloc] init];
    item.title = title;
    if(IOS7)
    {
        icon = [NSString stringWithFormat:@"%@_os7",icon];
    }
    item.icon = icon;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
