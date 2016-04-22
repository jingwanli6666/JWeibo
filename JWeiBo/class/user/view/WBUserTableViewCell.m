//
//  WBUserTableViewCell.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/1.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBUserTableViewCell.h"
#import "WBUserTableViewCellModel.h"

@implementation WBUserTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

-(void)setModel:(NSObject *)model
{
    [super setModel:model];
    
    WBUserTableViewCellModel *cellModel = (WBUserTableViewCellModel *)model;
    
    self.textLabel.text = cellModel.title;
    self.imageView.image = [UIImage imageNamed:cellModel.iconImageName];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
