//
//  WBTabbar.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBTabbar.h"
#import "WBTabbarbutton.h"

@interface WBTabbar()
@property (nonatomic,strong) NSMutableArray *TabbarButtons;
@property (nonatomic,weak) WBTabbarbutton *selectedButton;
@property (nonatomic,weak) UIButton *plusButton;

@end

@implementation WBTabbar


-(NSMutableArray *)TabbarButtons
{
    if (_TabbarButtons == nil) {
        _TabbarButtons = [NSMutableArray array];
    }
    return _TabbarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (!IOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
                }
        
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton addTarget:self action:@selector(ClickPlusButton) forControlEvents:UIControlEventTouchDown];
        
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        self.plusButton = plusButton;
            }
    
    return self;
}

#pragma mark - 加号按钮点击事件处理器
-(void)ClickPlusButton
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1.创建按钮
    WBTabbarbutton *button = [[WBTabbarbutton alloc]init];
    [self addSubview:button];
    
    
    [self.TabbarButtons addObject:button];
    
    //2.设置数据
    button.item = item;
    
//    [button setTitle:item.title forState:UIControlStateNormal];
//    [button setImage:item.image forState:UIControlStateNormal];
//    [button setImage:item.selectedImage forState:UIControlStateSelected];
//    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
    
    //3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //4.默认选中第0个按钮
    if (self.TabbarButtons.count == 1) {
        [self buttonClick:button];
    }
    
}

//监听按钮点击

- (void)buttonClick:(WBTabbarbutton *)button
{
    //1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews
{
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w*0.5, h*0.5);
    
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
 
    CGFloat buttonY = 0;
    for (int index =0; index<self.TabbarButtons.count; index++) {
      //1.取出按钮
        WBTabbarbutton *button = self.TabbarButtons[index];
        
        //2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //3.绑定tag
        button.tag = index;
    }
   }



@end
