//
//  WBCommonItem.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-21.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBCommonItem : NSObject

//图标
@property (nonatomic,copy) NSString *icon;
//标题
@property (nonatomic,copy) NSString *title;
//子标题
@property (nonatomic,copy) NSString *subtitle;
//右边显示的提醒数字
@property (nonatomic,copy) NSString *badgeValue;
//点击cell，需要跳转到哪个控制器
@property (nonatomic,assign) Class destVcClass;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype)itemWithTitle:(NSString *)title;

@end
