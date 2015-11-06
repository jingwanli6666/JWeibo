//
//  WBEmotion.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBEmotion : NSObject<NSCoding>
//图片昵称字符串
@property (nonatomic,copy) NSString *chs;
//图片名
@property (nonatomic,copy) NSString *png;
@property (nonatomic,copy) NSString *code;
@end
