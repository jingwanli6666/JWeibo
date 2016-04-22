//
//  WBArchiveTool.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/16.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBArchiveTool.h"
#import "CoreLockConst.h"

@implementation WBArchiveTool

+(void)setStr:(NSString *)str key:(NSString *)key
{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setObject:str forKey:key];
    
    //立即同步
    [defaults synchronize];
}

+(NSString *)strForKey:(NSString *)key
{
    //获取perference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSString *str = (NSString *)[defaults objectForKey:key];
    return str;
}

//删除
+(void)removeStrForKey:(NSString *)key
{
    [self setStr:nil key:key];
}

//保存int
+(void)setInt:(NSInteger)i key:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setInteger:i forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}

//读取
+(NSInteger)intForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSInteger i=[defaults integerForKey:key];
    
    return i;
}

//保存float
+(void)setFloat:(CGFloat)floatValue key:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setFloat:floatValue forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}
//读取
+(CGFloat)floatForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    CGFloat floatValue=[defaults floatForKey:key];
    
    return floatValue;
}


//保存bool
+(void)setBool:(BOOL)boolValue key:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setBool:boolValue forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}
//读取
+(BOOL)boolForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    BOOL boolValue=[defaults boolForKey:key];
    
    return boolValue;
}




#pragma mark - 文件归档
//归档
+(BOOL)archiveRootObject:(id)obj toFile:(NSString *)path{
    return [NSKeyedArchiver archiveRootObject:obj toFile:path];
}
//删除
+(BOOL)removeRootObjectWithFile:(NSString *)path{
    return [self archiveRootObject:nil toFile:path];
}
//解档
+(id)unarchiveObjectWithFile:(NSString *)path{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}


/*
 *  是否有本地密码缓存？即用户是否设置过初始密码？
 */
+(BOOL)hasPwd{
    
    NSString *pwd = [self strForKey:CoreLockPWDKey];
    
    return pwd !=nil;
}

+(BOOL)hasSuccess
{
    NSString *success = [self strForKey:CoreLockVerifySuccess];
    return success != nil;
}



@end
