//
//  WBEmotionTabBar.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-14.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    WBEmotionTabBarButtonTypeRecent,//最近
    WBEmotionTabBarButtonTypeDefault, //默认
    WBEmotionTabBarButtonTypeEmoji,  //emoji
    WBEmotionTabBarButtonTypeWave    //浪小花
}WBEmotionTabBarButtonType;
@class WBEmotionTabBar;

@protocol WBEmotionTabBarDelegate <NSObject>

@optional
-(void)clickEmotionTabbar:(WBEmotionTabBar *)tabbar DidSelectBtn:(WBEmotionTabBarButtonType)ButtonType;
@end

@interface WBEmotionTabBar : UIView
@property (nonatomic,weak) id<WBEmotionTabBarDelegate> delegate;
@end
