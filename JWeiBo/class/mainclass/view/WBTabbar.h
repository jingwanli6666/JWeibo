//
//  WBTabbar.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabbar;

@protocol WbTabBarDelegate <NSObject>
//可选的代理方法
@optional
-(void)tabBar:(WBTabbar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
-(void)tabBarDidClickPlusButton:(WBTabbar *)tabBar;
@end

@interface WBTabbar : UIView
-(void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic,weak) id<WbTabBarDelegate> delegate;


@end
