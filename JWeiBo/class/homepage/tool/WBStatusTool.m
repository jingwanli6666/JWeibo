//
//  WBStatusTool.m
//  JWeiBo
//
//  Created by bcc_cae on 16/3/8.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBStatusTool.h"
#import "FMDB.h"

@implementation WBStatusTool

static FMDatabase *_db;

+ (void)initialize
{
    //1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"statues.sqlite"];
    
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    //2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY,status blob NOT NULL,idstr text NOT NULL)"];
}

+(NSArray *)statuesWithParams:(NSDictionary *)params
{
    //根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER by idstr DESC LIMIT 20",params[@"since_id"]];
    }else if(params[@"max_id"]){
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr < %@ ORDER by idstr DESC LIMIT 20",params[@"max_id"]];
    }else{
        sql = @"SELECT * FROM t_status ORDER By idstr DESC LIMIT 20";
    }
    //NSString *sql = "SELECT * FROM t_status WHERE "
    
    //执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statues = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statues addObject:status];
    }
    return statues;
}

+ (void)saveStatues:(NSArray *)statues
{
    //将原有的NSDictionary转化为NSData再存入数据库
    //要将一个对象存入数据库的blob字段，最好先转为NSData 对象要遵守NSCoding协议
    for (NSDictionary *status in statues) {
        //如果不进行转化，存入的status为字符串不是NSDictionary
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status,idstr) VALUES(%@,%@)",statusData,status[@"idstr"]];
    }
}

@end
