//
//  WBSquareTableViewHeader.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/5.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBSquareTableViewHeader.h"
#import "WBSquareTableViewHeaderItemModel.h"
#import "WBSquareTableViewHeaderItemButton.h"

@implementation WBSquareTableViewHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setHeaderItemModelsArray:(NSArray *)headerItemModelsArray
{
    _headerItemModelsArray = headerItemModelsArray;
    
    [headerItemModelsArray enumerateObjectsUsingBlock:^(WBSquareTableViewHeaderItemModel  *model, NSUInteger idx, BOOL * _Nonnull stop) {
        WBSquareTableViewHeaderItemButton *btn = [[WBSquareTableViewHeaderItemButton alloc] init];
        btn.tag = idx;
        btn.title = model.title;
        btn.imageName = model.imageName;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.subviews.count == 0) {
        return;
    }
    
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    
    [self.subviews enumerateObjectsUsingBlock:^( UIView * btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.frame = CGRectMake(idx * btnW, 0, btnW, btnH);
    }];
}

- (void)buttonClick:(WBSquareTableViewHeaderItemButton *)btn
{
    if (self.buttonClickHandler) {
        self.buttonClickHandler(btn.tag);
    }
}

@end
