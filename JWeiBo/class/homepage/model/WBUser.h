//
//  WBUser.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject
@property (nonatomic,copy) NSString* idstr;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* profile_image_url;
@property (nonatomic,assign) int mbrank;
@property (nonatomic,assign) int mbtype;
//+(instancetype)userWithDict:(NSDictionary *)dict;
//-(instancetype)initWithDict:(NSDictionary *)dict;
@end
