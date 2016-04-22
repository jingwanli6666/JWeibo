//
//  NSString+File.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/16.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (File)

/**
 *  document根文件夹
 *
 *  @return <#return value description#>
 */
+(NSString *)documentFolder;

/**
 *  caches根文件夹
 *
 *  @return <#return value description#>
 */
+(NSString *)cachesFolder;


/**
 *  生成子文件夹
 *
 *  如果子文件夹不存在，则直接创建；如果已经存在，则直接返回
 *
 *  @param subFolder 子文件夹名
 *
 *  @return 文件夹路径
 */
-(NSString *)createSubFolder:(NSString *)subFolder;
@end
