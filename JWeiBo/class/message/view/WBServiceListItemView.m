//
//  WBServiceListItemView.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/6.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBServiceListItemView.h"
#import "WBServiceListItemButton.h"
#import "WBServiceItemModel.h"
#import "UIButton+WebCache.h"
#import "UIView+WBExtension.h"

@interface WBServiceListItemView()
@property (nonatomic, strong) WBServiceListItemButton *itemButton;
@property (nonatomic, strong) UIButton *iconView;
@end

@implementation WBServiceListItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return  self;
}

- (void)initialization
{
    self.backgroundColor = [UIColor whiteColor];
    
    WBServiceListItemButton *button = [[WBServiceListItemButton alloc] init];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    _itemButton = button;
    
    
    UIButton *icon = [[UIButton alloc] init];
    [icon setImage:[UIImage imageNamed:@"Home_delete_icon"] forState:UIControlStateNormal];
    [icon addTarget:self action:@selector(iconViewClick) forControlEvents:UIControlEventTouchUpInside];
    icon.hidden = YES;
    [self addSubview:icon];
    _iconView = icon;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(itemLongPress:)];
    [self addGestureRecognizer:longPress];
}

#pragma mark - actions

-(void)itemLongPress:(UILongPressGestureRecognizer *)longPress
{
    if (self.LongPressOperationHandler) {
        self.LongPressOperationHandler(longPress);
    }
}

-(void)btnClick
{
    if (self.buttonClickOperationHandler) {
        self.buttonClickOperationHandler(self);
    }
}

-(void)iconViewClick
{
    if (self.iconViewClickOperationHandler) {
        self.iconViewClickOperationHandler(self);
    }
}

#pragma mark - 模型赋值
-(void)setItemModel:(WBServiceItemModel *)itemModel
{
    _itemModel = itemModel;
    
    if (itemModel.title) {
        [_itemButton setTitle:itemModel.title forState:UIControlStateNormal];
    }
    
    if ([itemModel.imageStr hasPrefix:@"http:"] ||[itemModel.imageStr hasPrefix:@"https:"]) {
        [_itemButton setImageWithURL:[NSURL URLWithString:itemModel.imageStr] forState:UIControlStateNormal placeholderImage:nil];
    }else{
        [_itemButton setImage:[UIImage imageNamed:itemModel.imageStr] forState:UIControlStateNormal];
    }
    
}

-(void)setHidenIcon:(BOOL)hidenIcon
{
    _hidenIcon = hidenIcon;
    _iconView.hidden = hidenIcon;
}

-(void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    
    [_iconView setImage:iconImage forState:UIControlStateNormal];
}

#pragma  mark - 布局  

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    _itemButton.frame = self.bounds;
    _iconView.frame = CGRectMake(self.wb_width - self.iconView.wb_width - margin, margin, 20, 20);
}

@end
