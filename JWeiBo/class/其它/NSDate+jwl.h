//
//  NSDate+jwl.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-29.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (jwl)

/**
 * 判断某个时间是否为今天
 */
-(BOOL)isToday;
/**
 * 判断某个时间是否为昨天
 */
-(BOOL)isYesterday;
/**
 * 判断某个时间是否为今年
 */
-(BOOL)isYear;
/**
 * 将某个时间格式化为yyyy-MM-dd
 */
-(NSDate *)dateWithYMD;
/**
 * 计算某个时间与当前时间的时间差
 */
-(NSDateComponents *)deltaWithNow;

@end
