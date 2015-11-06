//
//  WBAccount.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-23.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount 

+(instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

/**
 *  从文件中解析对象的时候调用
 
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
        self.name = [decoder decodeObjectForKey:@"name"];

    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *
 *  @param encoder <#encoder description#>
 */

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [encoder encodeObject:self.name forKey:@"name"];
    
}
@end
