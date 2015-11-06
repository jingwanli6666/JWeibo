//
//  WBStatuesCell.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-24.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatuesFrame;

@interface WBStatuesCell : UITableViewCell
@property (nonatomic,strong) WBStatuesFrame *statuesframe;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
