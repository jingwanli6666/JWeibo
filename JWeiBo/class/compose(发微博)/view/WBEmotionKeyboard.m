//
//  WBEmotionKeyboard.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-14.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBEmotionKeyboard.h"
#import "WBEmotionListView.h"
#import "WBEmotionTabBar.h"
#import "WBEmotion.h"
#import "MJExtension.h"
#import "WBEmotionTool.h"

@interface WBEmotionKeyboard() <WBEmotionTabBarDelegate>

@property (nonatomic,weak) WBEmotionListView *showingListView;
@property (nonatomic,strong) WBEmotionListView *recentlistView;
@property (nonatomic,strong) WBEmotionListView *defaultlistView;
@property (nonatomic,strong) WBEmotionListView *emojilistView;
@property (nonatomic,strong) WBEmotionListView *lxhlistView;
@property (nonatomic,strong) WBEmotionTabBar *tabBar;

@end

@implementation WBEmotionKeyboard

#pragma mark -懒加载

-(WBEmotionListView *)recentlistView
{
    if(_recentlistView == nil){
        _recentlistView = [[WBEmotionListView alloc] init];
        self.recentlistView.emotions = [WBEmotionTool RecentEmotions];
       // self.recentlistView.backgroundColor = WBRandomColor;
    }
    return _recentlistView;
}

-(WBEmotionListView *)defaultlistView
{
    if (_defaultlistView == nil) {
        _defaultlistView = [[WBEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info_default" ofType:@"plist"];
        WBLog(@"%@",path);
        NSArray *defaultEmotions = [NSArray arrayWithContentsOfFile:path];
        self.defaultlistView.emotions = [WBEmotion objectArrayWithKeyValuesArray:defaultEmotions];
        //self.defaultlistView.backgroundColor = WBRandomColor;
    }
    return _defaultlistView;
}

-(WBEmotionListView *)emojilistView
{
    if (_emojilistView == nil) {
        _emojilistView = [[WBEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info_emoji" ofType:@"plist"];
        WBLog(@"%@",path);
        NSArray *emojiEmotions = [NSArray arrayWithContentsOfFile:path];
        self.emojilistView.emotions = [WBEmotion objectArrayWithKeyValuesArray:emojiEmotions];
        //self.emojilistView.backgroundColor = WBRandomColor;
    }
    return _emojilistView;
}

-(WBEmotionListView *)lxhlistView
{
    if (_lxhlistView == nil) {
        _lxhlistView = [[WBEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"info_lxh" ofType:@"plist"];
        NSArray *lxhEmotions = [NSArray arrayWithContentsOfFile:path];
        self.lxhlistView.emotions = [WBEmotion objectArrayWithKeyValuesArray:lxhEmotions];
        //self.lxhlistView.backgroundColor = WBRandomColor;
    }
    return _lxhlistView;
}

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //1.添加EmotionListView
//        WBEmotionListView *contentView = [[WBEmotionListView alloc] init];
//        //listView.backgroundColor = [UIColor redColor];
//        [self addSubview:contentView];
//        self.contentView = contentView;
        
        WBEmotionTabBar *tabBar = [[WBEmotionTabBar alloc] init];
        tabBar.delegate = self;
        //tabBar.backgroundColor = [UIColor blueColor];
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
    }
    return self;
}

-(void)layoutSubviews
{
    //1.tabbar
    CGFloat tabBarX = 0;
    CGFloat tabBarH = 37;
    CGFloat tabBarW = self.frame.size.width;
    CGFloat tabBarY = self.frame.size.height - tabBarH;
    _tabBar.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
    
    CGFloat showingListViewX = 0;
    CGFloat showingListViewY = 0;
    CGFloat showingListViewW = tabBarW;
    CGFloat showingListViewH = tabBarY;
    _showingListView.frame = CGRectMake(showingListViewX, showingListViewY, showingListViewW, showingListViewH);
}

/**
 *  代理WBEmotionTabBarDelegate  监听Emotion按钮
 *
 *  @param tabbar     <#tabbar description#>
 *  @param ButtonType <#ButtonType description#>
 */
-(void)clickEmotionTabbar:(WBEmotionTabBar *)tabbar DidSelectBtn:(WBEmotionTabBarButtonType)ButtonType
{
    //移除contentView之前显示的控件
    [self.showingListView removeFromSuperview];
    
    switch (ButtonType) {
        case WBEmotionTabBarButtonTypeRecent:
            [self addSubview:self.recentlistView];
             break;
        case WBEmotionTabBarButtonTypeDefault:{
            [self addSubview:self.defaultlistView];
            break;
        }
        case WBEmotionTabBarButtonTypeEmoji:{
            [self addSubview:self.emojilistView];
            break;
        }
        case WBEmotionTabBarButtonTypeWave:{
            [self addSubview:self.lxhlistView];
            break;
        }
        
    }
    
    //设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    //设置frame
    [self setNeedsLayout];
  
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



@end
