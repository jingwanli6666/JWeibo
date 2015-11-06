//
//  WBSearchBar.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-18.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBSearchBar.h"

@interface WBSearchBar()

@property (nonatomic,weak) UIImageView *iconView;

@end

@implementation WBSearchBar


+ (instancetype)searchBar
{
    return [[self alloc] init];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //UITextField *searchBar = [[UITextField alloc] init];
        //背景
        //self.disabledBackground = [UIImage resizeImageWithName:@"square_search_bg"];
        self.background =[UIImage resizeImageWithName:@"square_search_input"];
        //尺寸
        //self.frame = CGRectMake(0,0,300,30);
        //searchBar.image = []
        //左边放大镜图标
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"square_icon_search"]];
        //iconView.frame = CGRectMake(0,0,30,30);
        
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        iconView.contentMode = UIViewContentModeCenter;
        //字体大小
        self.font = [UIFont systemFontOfSize:14];
        
        //左边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        //设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        //attrs[NSTextAlignmentCenter] = UIViewContentModeCenter;
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        
        //设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置左边图标的frame
    self.leftView.frame = CGRectMake(0, 0, 30  , self.frame.size.height);
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
