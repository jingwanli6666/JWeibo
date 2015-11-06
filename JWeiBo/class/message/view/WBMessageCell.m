//
//  WBMessageCell.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-14.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBMessageCell.h"

@interface WBMessageCell()

@end

@implementation WBMessageCell

//-(NSMutableArray *)messageCellArr
//{
//    if (_messageCellArr == nil) {
//        _messageCellArr = [NSMutableArray array];
//    }
//    return  _messageCellArr;
//}
//
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *id = @"message";
    WBMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:id ];
    if (messageCell == nil) {
        messageCell = [[WBMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id];
    }
    return messageCell;
    
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//        [self setupCellSubView];
//    }
//    return self;
//}

-(WBMessageCell *)initWithImage:(NSString *)imagename title:(NSString *)title
{

    WBMessageCell *cell = [[WBMessageCell alloc] init];
    cell.imageView.image = [UIImage imageWithName:imagename];
    cell.textLabel.text = title;
    return cell;
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
