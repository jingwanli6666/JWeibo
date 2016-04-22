//
//  WBArchiveTool.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/16.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBArchiveTool : NSObject

#pragma mark - 偏好类信息存储

+(void)setStr:(NSString *)str key:(NSString *)key;
/**
 *  读取
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)strForKey:(NSString *)key;

+(void)removeStrForKey:(NSString *)key;

/**
 *  保存int
 */
+(void)setInt:(NSInteger)i key:(NSString *)key;

/**
 *  读取int
 */
+(NSInteger)intForKey:(NSString *)key;



/**
 *  保存float
 */
+(void)setFloat:(CGFloat)floatValue key:(NSString *)key;

/**
 *  读取float
 */
+(CGFloat)floatForKey:(NSString *)key;



/**
 *  保存bool
 */
+(void)setBool:(BOOL)boolValue key:(NSString *)key;

/**
 *  读取bool
 */
+(BOOL)boolForKey:(NSString *)key;

/*
 *  是否有本地密码缓存？即用户是否设置过初始密码？
 */
+(BOOL)hasPwd;

+(BOOL)hasSuccess;

#pragma mark - 文件归档

/**
 *  归档
 */
+(BOOL)archiveRootObject:(id)obj toFile:(NSString *)path;
/**
 *  删除
 */
+(BOOL)removeRootObjectWithFile:(NSString *)path;

/**
 *  解档
 */
+(id)unarchiveObjectWithFile:(NSString *)path;

@end
