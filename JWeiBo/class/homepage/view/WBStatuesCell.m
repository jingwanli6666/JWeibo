//
//  WBStatuesCell.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBStatuesCell.h"
#import "WBStatuses.h"
#import "WBUser.h"
#import "WBStatuesFrame.h"
#import "UIImageView+WebCache.h"
#import "WBToolbarButton.h"
#import "WBRetweetedView.h"
#import "WBTopView.h"

@interface WBStatuesCell ()
/*** 顶部的view **/
@property (nonatomic,weak) WBTopView *topView;

/***被转发微博的view(父控件)  **/
@property (nonatomic,weak) WBRetweetedView *repostsView;

/***工具条  **/
@property (nonatomic,weak) WBToolbarButton *ToolBarView;

@end

@implementation WBStatuesCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    WBStatuesCell *statuescell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (statuescell == nil) {
        statuescell = [[WBStatuesCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return statuescell;
}

/**
 *  拦截frame的设置方法
 *
 *  @param frame
 */
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = WBCellboarder;
    frame.size.width -= 2 * WBCellboarder;
    frame.size.height -= WBCellboarder;
    [super setFrame:frame];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //1.添加原始微博
        [self setupOriginalSubviews];
        
        //2.添加被转发微博
        [self setuprepostsSubviews];
        
        //3.添加工具条
        [self setupToolSubviews];
    }
    return self;
}

/**
 *  添加原始微博的子控件
 */
-(void)setupOriginalSubviews
{
    /*** 1.顶部的view **/
    WBTopView *topView = [[WBTopView alloc] init];
    self.selectedBackgroundView = [[UIView alloc] init];
    
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
}

-(void)setuprepostsSubviews
{
    /*** 1.转发微博的view **/
    WBRetweetedView *repostsView = [[WBRetweetedView alloc] init];
    
    [self.topView addSubview:repostsView];
    self.repostsView = repostsView;
    
   }

-(void)setupToolSubviews
{
    
    WBToolbarButton *toolbarView = [[WBToolbarButton alloc] init];
    [self.contentView addSubview:toolbarView];
    //WBLog(@"%@",toolbarView);
    self.ToolBarView = toolbarView;
}

-(void)setStatuesframe:(WBStatuesFrame *)statuesframe
{
    _statuesframe = statuesframe;
    //1.原始微博
    [self setupOriginalData];
    
    //2.被转发微博
    [self setuprepostsData];
    
    //3.工具条
    [self setupToolBarData];
    
   }

-(void)setupOriginalData
{
   // WBStatuses *statues = self.statuesframe.statues;
    //WBUser *user = statues.user;
    
    //1.topView
    self.topView.frame = self.statuesframe.topViewF;
    
   //2.传递模型
    self.topView.statuesframe = self.statuesframe;
}

-(void)setuprepostsData
{
    WBStatuses *retweetedstatus = self.statuesframe.statues.retweeted_status;
    //WBUser *retweeteduser = retweetedstatues.user;
    
    
    //1.父控件
    if(retweetedstatus){
        self.repostsView.hidden = NO;
        self.repostsView.frame = self.statuesframe.repostsViewF;
      
    //2.传递模型
        self.repostsView.retweetedframe = self.statuesframe;
       
    }else{
        self.repostsView.hidden = YES;
    }

    
}

-(void)setupToolBarData
{
    self.ToolBarView.frame = self.statuesframe.statusToolBarF;
    self.ToolBarView.toolbarstatues = self.statuesframe.statues;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
