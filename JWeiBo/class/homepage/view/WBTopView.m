//
//  WBTopView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-5.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBTopView.h"
#import "WBStatuesFrame.h"
#import "WBStatuses.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "WBphoto.h"
#import "WBStatusPhotoView.h"

@interface WBTopView()

/*** 头像 **/
@property (nonatomic,weak) UIImageView *iconView;
/*** 会员图标 **/
@property (nonatomic,weak) UIImageView *vipView;
/*** 配图 **/
@property (nonatomic,weak) WBStatusPhotoView *figureView;
/*** 昵称 **/
@property (nonatomic,weak) UILabel *nameLabel;
/*** 时间 **/
@property (nonatomic,weak) UILabel *timeLabel;
/*** 来源 **/
@property (nonatomic,weak) UILabel *sourceLabel;
/*** 正文 **/
@property (nonatomic,weak) UILabel *contentLabel;

@end

@implementation WBTopView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.opaque = NO;
         self.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
        
        /*** 2.头像 **/
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        self.iconView.opaque = NO;
        
        /*** 3.vip头像 **/
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        self.vipView.opaque = NO;
        
        /*** 4.配图 **/
        WBStatusPhotoView *figureView = [[WBStatusPhotoView alloc] init];
        [self addSubview:figureView];
        self.figureView = figureView;
        self.figureView.opaque = NO;
        
        /*** 5.昵称 **/
        UILabel *nameLabel = [[UILabel alloc] init];
        //nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = WBStatuesnameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        self.nameLabel.opaque = NO;
        
        /*** 6.时间 **/
        UILabel *timeLabel = [[UILabel alloc] init];
        //timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = WBColor(240, 145, 19);
        timeLabel.font = WBtimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        self.timeLabel.opaque = NO;
        
        /*** 7.来源 **/
        UILabel *sourceLabel = [[UILabel alloc] init];
        //sourceLabel.backgroundColor = [UIColor clearColor];
        sourceLabel.font = WBsourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /*** 8.正文 **/
        UILabel *contentLabel = [[UILabel alloc] init];
        //contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.font = WBcontentFont;
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        self.contentLabel.opaque = NO;
    }
    return self;
}

-(void)setStatuesframe:(WBStatuesFrame *)statuesframe
{
    _statuesframe = statuesframe;
    
    WBStatuses *statues = statuesframe.statues;
    WBUser *user = statues.user;
    
    //2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statuesframe.iconViewF;
    
    //3.昵称
    self.nameLabel.text = statues.user.name;
    self.nameLabel.frame = self.statuesframe.nameLabelF;
    
    //4.vip
    if (user.mbtype) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:@"common_icon_membership"];
        self.vipView.frame = self.statuesframe.vipViewF;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    
    //7.正文
    self.contentLabel.text = statues.text;
    self.contentLabel.frame = self.statuesframe.contentLabelF;
    
    //5.时间
    self.timeLabel.text = statues.created_at;
//    WBLog(@"%@",statues.created_at);
    self.timeLabel.textColor = [UIColor orangeColor];
    CGFloat timeLabelX =  self.statuesframe.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statuesframe.topViewF)- 4*WBStatuesboarder;
    CGSize timeSize = [statues.created_at sizeWithFont:WBtimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeSize};
    //self.timeLabel.frame = self.statuesframe.timeLabelF;
    
    //6.来源
    self.sourceLabel.text = statues.source;
    CGFloat sourceLabelX =  CGRectGetMaxX(self.timeLabel.frame) + WBStatuesboarder;
    CGFloat sourceLabelY = CGRectGetMaxY(self.statuesframe.topViewF)- 4*WBStatuesboarder;
    CGSize sourceLabelSize = [statues.source sizeWithFont:WBtimeFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    //self.sourceLabel.frame = self.statuesframe.sourceLabelF;
    
    //8.配图
    if (statues.pic_urls.count) {
        self.figureView.hidden = NO;
        self.figureView.frame = self.statuesframe.figureViewF;
        self.figureView.photos = statues.pic_urls;
        //WBphoto *photo = statues.pic_urls[0];
        //[self.figureView setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    }else{
        self.figureView.hidden = YES;
    }
}
@end
