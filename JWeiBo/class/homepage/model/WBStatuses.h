//
//  WBStatuses.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUser;
@interface WBStatuses : NSObject
//微博内容
@property (nonatomic,copy) NSString *text;
//微博创建时间
@property (nonatomic,copy) NSString *created_at;
//微博来源
@property (nonatomic,copy) NSString *source;
//微博转发数
@property (nonatomic,assign) int reposts_count;
//微博评论数
@property (nonatomic,assign) int comments_count;
//微博表态数
@property (nonatomic,assign) int attitudes_count;
//发微博人的id
@property (nonatomic,copy) NSString *idstr;
//微博配图
@property (nonatomic,strong) NSArray *pic_urls;
//@property (nonatomic,copy) NSString *thumbnail_pic;
@property (nonatomic,strong) WBUser *user;

@property (nonatomic,strong) WBStatuses *retweeted_status;

//+(instancetype)wbstatusesWithDict:(NSDictionary *)dict;
//-(instancetype)initWithDict:(NSDictionary *)dict;
@end
/* {
 "created_at": "Tue May 31 17:46:55 +0800 2011",
 "id": 11488058246,
 "text": "求关注。"，
 "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
 
 "reposts_count": 8,
 "comments_count": 9,
 "user": {
 "id": 1404376560,
 "name": "zaku",
 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
 }
 
 */