//
//  WBAssetTableViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/3.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBAssetTableViewController.h"
#import "WBAssetTableViewCellModel.h"
#import "WBAssetTableViewCell.h"

@interface WBAssetTableViewController ()

@end

@implementation WBAssetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cellClass = [WBAssetTableViewCell class];
    
    WBAssetTableViewCellModel *model = [[WBAssetTableViewCellModel alloc] init];
    model.yesterdayIncome = 0.88;
    model.totalMoneyAmout = 8865.88;
    self.dataArray = @[model];
    
    self.refreshMode = WBBasicTableViewControllerRefeshModeHeaderRefresh;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}


// 加载数据方法

- (void)pullDownRefreshOperation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kWBAssetTableViewCellHeight;
}


extern const CGFloat kWBAssetTableViewCellHeight;


@end
