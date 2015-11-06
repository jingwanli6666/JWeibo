//
//  WBCommonCell.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-21.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBCommonItem;
@interface WBCommonCell : UITableViewCell
@property (nonatomic,strong) WBCommonItem *item;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
