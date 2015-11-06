//
//  WBAccountTool.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBAccount;

@interface WBAccountTool : NSObject

+(void)setAccout:(WBAccount *)account;
+(WBAccount *)getAccount;
@end
