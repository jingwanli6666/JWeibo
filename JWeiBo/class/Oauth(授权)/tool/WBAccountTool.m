//
//  WBAccountToll.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"


@implementation WBAccountTool

+(void)setAccout:(WBAccount *)account
{
    //计算账号过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    [NSKeyedArchiver archiveRootObject:account toFile:file];
}
/**
 *  返回账号信息
 *
 *  @return <#return value description#>
 */
+(WBAccount *)getAccount
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    //[NSKeyeduArchiver archiveRootObject:account toFile:file];
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime]) {
        //还没过期
        return account;
    }else
    {
        return nil;
    }
    //return account;
}

@end
