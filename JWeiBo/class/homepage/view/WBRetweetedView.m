//
//  WBRetweetedView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-5.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBRetweetedView.h"
#import "WBStatuesFrame.h"
#import "WBUser.h"
#import "WBStatuses.h"
#import "UIImageView+WebCache.h"
#import "WBphoto.h"
#import "WBStatusPhotoView.h"

@interface WBRetweetedView()

/***被转发微博的昵称  **/
@property (nonatomic,weak) UILabel *repostsnameLabel;
/***被转发微博的正文  **/
@property (nonatomic,weak) UILabel *repostscontentLabel;
/***被转发微博的配图  **/
@property (nonatomic,weak) WBStatusPhotoView *repostsfigureView;

@end

@implementation WBRetweetedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"timeline_retweet_background" left:0.95 top:0.8];
        
        /*** 2.转发微博原作者的昵称 **/
        UILabel *repostsnameLabel = [[UILabel alloc] init];
        repostsnameLabel.font = WBretweetedWeiboFont;
        repostsnameLabel.backgroundColor = [UIColor clearColor];
        repostsnameLabel.textColor = WBColor(156, 154, 86);
        [self addSubview:repostsnameLabel];
        self.repostsnameLabel = repostsnameLabel;
        
        /*** 3.转发微博原作者的内容 **/
        UILabel *repostscontentLabel = [[UILabel alloc] init];
        repostscontentLabel.backgroundColor = [UIColor clearColor];
        repostscontentLabel.font = WBretweetedContentFont;
        repostscontentLabel.numberOfLines = NO;
        [self addSubview:repostscontentLabel];
        self.repostscontentLabel = repostscontentLabel;
        
        /*** 4.转发微博原作者的配图 **/
        WBStatusPhotoView *repostsfigureView = [[WBStatusPhotoView alloc] init];
        [self addSubview:repostsfigureView];
        self.repostsfigureView = repostsfigureView;

    }
    return self;
}

-(void)setRetweetedframe:(WBStatuesFrame *)retweetedframe
{
    _retweetedframe = retweetedframe;
    
    WBStatuses *retweetedstatus = retweetedframe.statues.retweeted_status;
    WBUser *retweeteduser = retweetedstatus.user;
    //2.昵称
    NSString *retweetedname = [NSString stringWithFormat:@"@%@",retweeteduser.name];
    self.repostsnameLabel.text = retweetedname;
    self.repostsnameLabel.frame = self.retweetedframe.repostsnameLabelF;
    
    //3.正文
    self.repostscontentLabel.text = retweetedstatus.text;
    self.repostscontentLabel.frame = self.retweetedframe.repostscontentLabelF;
    
    
    if (retweetedstatus.pic_urls.count) {
        self.repostsfigureView.hidden = NO;
        self.repostsfigureView.frame = self.retweetedframe.repostsfigureViewF;
        self.repostsfigureView.photos = retweetedstatus.pic_urls;
        //WBphoto *photo = retweetedstatus.pic_urls[0];
        //[self.repostsfigureView setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    }else{
        self.repostsfigureView.hidden = YES;
    }
 
}


@end
