//
//  WBEmotionTool.h
//  JWeiBo
//
//  Created by bcc_cae on 15-11-4.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBEmotion;

@interface WBEmotionTool:NSObject

+(void)addRecentEmotion:(WBEmotion *)emotion;
+(NSArray *)RecentEmotions;

@end
