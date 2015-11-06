//
//  WBEmotionTool.m
//  JWeiBo
//
//  Created by bcc_cae on 15-11-4.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//


#define WBRecentEmotionFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"Emotion.data"]

#import "WBEmotionTool.h"


@implementation WBEmotionTool

+(void)addRecentEmotion:(WBEmotion *)emotion
{
    //加载沙盒中的表情数据
    NSMutableArray *emotions = (NSMutableArray *)[self RecentEmotions];
    if (emotions == nil) {
        emotions = [NSMutableArray array];
    }
    //将表情放到数组的最前面
    [emotions insertObject:emotion atIndex:0];
    
    //将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:emotions toFile:WBRecentEmotionFilePath];
}

+(NSArray *)RecentEmotions
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:WBRecentEmotionFilePath];
}

@end
