//
//  WBStatusTool.h
//  JWeiBo
//
//  Created by bcc_cae on 16/3/8.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusTool : NSObject

+(NSArray *)statuesWithParams:(NSDictionary *)params;

+(void)saveStatues:(NSArray *)statues;

@end
