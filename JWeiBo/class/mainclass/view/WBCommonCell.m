//
//  WBCommonCell.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-21.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBCommonCell.h"
#import "WBCommonItem.h"

@implementation WBCommonCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ID";
    WBCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell == nil) {
        cell = [[WBCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(void)setItem:(WBCommonItem *)item
{
    _item = item;
    
    //设置基本数据
    self.imageView.image = [UIImage imageWithName:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
