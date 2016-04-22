//
//  WBServiceItemCacheTool.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/8.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBServiceItemCacheTool.h"

#define kItemsArrayCacheKey @"ItemsArrayCacheKey"

@implementation WBServiceItemCacheTool

+(NSArray *)itemsArray
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kItemsArrayCacheKey];
}

+ (void)saveItemsArray:(NSArray *)array
{
    [[NSUserDefaults standardUserDefaults] setObject:[array copy] forKey:kItemsArrayCacheKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
