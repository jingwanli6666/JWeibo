//
//  WBServiceItemCacheTool.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/8.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBServiceItemCacheTool : NSObject

+ (NSArray *)itemsArray;
+ (void)saveItemsArray:(NSArray *)array;

@end
