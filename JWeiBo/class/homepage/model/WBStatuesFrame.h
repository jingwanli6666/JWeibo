//
//  WBStatuesFrame.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>
#define WBStatuesboarder  5
#define WBStatuesnameFont [UIFont systemFontOfSize:15]
#define WBretweetedWeiboFont WBStatuesnameFont
#define WBcontentFont [UIFont systemFontOfSize:12]
#define WBretweetedContentFont WBcontentFont
#define WBtimeFont [UIFont systemFontOfSize:12]
#define WBsourceFont  WBtimeFont

#define WBCellboarder 5

@class WBStatuses;

@interface WBStatuesFrame : NSObject
@property (nonatomic,strong) WBStatuses *statues;

/*** 顶部的view **/
@property (nonatomic,assign,readonly) CGRect topViewF;
/*** 头像 **/
@property (nonatomic,assign,readonly)  CGRect iconViewF;
/*** 会员图标 **/
@property (nonatomic,assign,readonly)  CGRect vipViewF;
/*** 配图 **/
@property (nonatomic,assign,readonly)  CGRect figureViewF;
/*** 昵称 **/
@property (nonatomic,assign,readonly) CGRect nameLabelF;
/*** 时间 **/
@property (nonatomic,assign,readonly) CGRect timeLabelF;
/*** 来源 **/
@property (nonatomic,assign,readonly) CGRect sourceLabelF;
/*** 正文 **/
@property (nonatomic,assign,readonly) CGRect contentLabelF;

/***被转发微博的view(父控件)  **/
@property (nonatomic,assign,readonly)  CGRect repostsViewF;

/***被转发微博的昵称  **/
@property (nonatomic,assign,readonly) CGRect repostsnameLabelF;
/***被转发微博的正文  **/
@property (nonatomic,assign,readonly) CGRect repostscontentLabelF;
/***被转发微博的配图  **/
@property (nonatomic,assign,readonly)  CGRect repostsfigureViewF;

/***工具条  **/
@property (nonatomic,assign,readonly) CGRect statusToolBarF;

@property (nonatomic,assign,readonly) CGFloat cellHeight;


@end
