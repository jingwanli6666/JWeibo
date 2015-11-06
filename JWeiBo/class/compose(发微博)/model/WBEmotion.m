//
//  WBEmotion.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBEmotion.h"

@implementation WBEmotion

/**
 *  读取文件里的数据
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    return self;
}

/**
 *  将数据存入文件
 *
 *  @param aCoder <#aCoder description#>
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
}

@end
