//
//  WBAssetTableViewCell.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/3.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBAssetTableViewCell.h"
#import "WBAssetTableViewCellContentView.h"
#import "WBAssetTableViewCellModel.h"

const CGFloat kWBAssetTableViewCellHeight = 550;

@implementation WBAssetTableViewCell
{
    WBAssetTableViewCellContentView *_cellContentView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        WBAssetTableViewCellContentView *contentView = [[WBAssetTableViewCellContentView alloc] init];
        [self.contentView addSubview:contentView];
        _cellContentView = contentView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return  self;
}

//重写父类方法
-(void)setModel:(NSObject *)model
{
    [super setModel:model];
    
    WBAssetTableViewCellModel *cellModel = (WBAssetTableViewCellModel *)model;
    _cellContentView.totalMoneyAmount = cellModel.totalMoneyAmout;
    _cellContentView.yesterdayIncome = cellModel.yesterdayIncome;
}
@end
