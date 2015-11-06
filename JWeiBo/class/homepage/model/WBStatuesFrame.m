//
//  WBStatuesFrame.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBStatuesFrame.h"
#import "WBStatuses.h"
#import "WBUser.h"
#import "WBStatusPhotoView.h"



@implementation WBStatuesFrame


-(void)setStatues:(WBStatuses *)statues
{
    _statues  = statues;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width-10;
    
    //1.topView
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    CGFloat topViewW = cellW;
    
    CGFloat maincontentViewH = 0;
    
    //2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = WBStatuesboarder;
    CGFloat iconViewY = WBStatuesboarder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + WBStatuesboarder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [statues.user.name sizeWithFont:WBStatuesnameFont];
    _nameLabelF = (CGRect){nameLabelX,nameLabelY,nameLabelSize};
    
    //4.会员图标
    if (statues.user.mbtype) {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + WBStatuesboarder;
        CGFloat vipViewY = nameLabelY;
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //5.微博正文
    CGFloat contentLabelX = CGRectGetMaxX(_iconViewF) + WBStatuesboarder;
    CGFloat contentLabelY = CGRectGetMaxY(_nameLabelF) + WBStatuesboarder;
    CGFloat contentMaxW = topViewW - 2 * WBStatuesboarder - CGRectGetMaxX(_iconViewF);
    CGSize contentLabellSize = [statues.text sizeWithFont:WBcontentFont constrainedToSize:CGSizeMake(contentMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabellSize};
    
   
    CGFloat timeLabelY = 0;
    //6.微博配图
    if (statues.pic_urls.count) {
//        CGFloat figureViewsize = 70;
//        CGFloat figureViewWH = figureViewsize;
        CGFloat figureViewX = contentLabelX;
        CGFloat figureViewY = CGRectGetMaxY(_contentLabelF) + WBStatuesboarder ;
        CGSize figureSize = [WBStatusPhotoView photosSizeWithCount:statues.pic_urls.count];
        _figureViewF = (CGRect){{figureViewX, figureViewY}, figureSize};
       //timeLabelY = CGRectGetMaxY(_figureViewF);
        
    }
    //timeLabelY += WBStatuesboarder;
    
    
    
    if (statues.retweeted_status) {
        CGFloat retweetedViewW = contentMaxW;
        CGFloat retweetedViewX = contentLabelX;
        CGFloat retweetedViewY = CGRectGetMaxY(_contentLabelF) + WBStatuesboarder;
        
        //9.被转发微博的昵称
        CGFloat retweetednameX = 0;
        CGFloat retweetednameY = WBStatuesboarder;
        CGFloat retweetedViewH = 0;
        NSString *retweetedname = [NSString stringWithFormat:@"@%@",statues.retweeted_status.user.name];
        CGSize retweetednameSize = [retweetedname sizeWithFont:WBretweetedWeiboFont];
        _repostsnameLabelF = (CGRect){{retweetednameX,retweetednameY},retweetednameSize};
        
        //10.被转发微博的内容
        CGFloat retweetedcontentX = retweetednameX;
        CGFloat retweetedcontentY = CGRectGetMaxY(_repostsnameLabelF) + WBStatuesboarder;
        CGFloat retweetedcontentMaxX = topViewW - 2 * WBStatuesboarder - CGRectGetMaxX(_iconViewF);
        CGSize retweetedcontentLabelSize = [statues.retweeted_status.text sizeWithFont:WBretweetedContentFont constrainedToSize:CGSizeMake(retweetedcontentMaxX, MAXFLOAT)];
        _repostscontentLabelF = (CGRect){{retweetedcontentX,retweetedcontentY},retweetedcontentLabelSize};
        
        //11.被转发微博的配图
        if (statues.retweeted_status.pic_urls.count) {
            //CGFloat retweetedfigureViewsize = 70;
            //CGFloat retweetedfigureViewWH = retweetedfigureViewsize;
            CGFloat figureViewX = retweetedcontentX;
            CGFloat figureViewY = CGRectGetMaxY(_repostscontentLabelF) + WBStatuesboarder ;
            CGSize figureSize = [WBStatusPhotoView photosSizeWithCount:statues.retweeted_status.pic_urls.count];
            _repostsfigureViewF = (CGRect){{figureViewX, figureViewY},figureSize};
            retweetedViewH = CGRectGetMaxY(_repostsfigureViewF) + WBStatuesboarder;
        }else //没有配图
        {
            retweetedViewH = CGRectGetMaxY(_repostscontentLabelF) + WBStatuesboarder;
        }
        _repostsViewF = CGRectMake(retweetedViewX, retweetedViewY,retweetedViewW, retweetedViewH);
        
        // 有转发微博的topViewH
        maincontentViewH = CGRectGetMaxY(_repostsViewF) ;
    }
    else { //没有转发微博
        if (statues.pic_urls.count) {//有图
            maincontentViewH = CGRectGetMaxY(_figureViewF);
        }else {
            maincontentViewH = CGRectGetMaxY(_contentLabelF);
        }
       
    }
    
    
     //topViewH += WBStatuesboarder;
    
    timeLabelY = maincontentViewH + WBStatuesboarder;
    
    //7.微博时间
    CGFloat timeLabelX = contentLabelX;
    //CGFloat timeLabelY = CGRectGetMaxY(_contentLabelF)+WBStatuesboarder;
    CGSize timeSize = [statues.created_at sizeWithFont:WBtimeFont];
    _timeLabelF = (CGRect){{timeLabelX,timeLabelY},timeSize};
    
    //8.微博来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + WBStatuesboarder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceSize = [statues.source sizeWithFont:WBsourceFont];
    _sourceLabelF = (CGRect){{sourceLabelX,sourceLabelY},sourceSize};
    
    //topViewH
    topViewH = CGRectGetMaxY(_timeLabelF) + WBStatuesboarder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //工具条
    CGFloat toolBarX =topViewX;
   
    CGFloat toolBarY = CGRectGetMaxY(_topViewF) + WBStatuesboarder;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35;
   
    _statusToolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //cell高度
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + WBCellboarder ;
   
}
@end
