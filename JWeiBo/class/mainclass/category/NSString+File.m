//
//  NSString+File.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/16.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)

+(NSString *)documentFolder{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


+(NSString *)cachesFolder
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSString *)createSubFolder:(NSString *)subFolder
{
    NSString *subFolderPath = [NSString stringWithFormat:@"%@/%@",self,subFolder];
    BOOL isDir = NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:subFolder isDirectory:&isDir];
    if (!(isDir && isExist)) {
        [fileManager createDirectoryAtPath:subFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return subFolder;
}
@end
