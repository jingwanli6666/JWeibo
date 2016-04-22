//
//  WBsquareTableViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBsquareTableViewController.h"
#import "WBSearchBar.h"
#import "WBSquareTableViewHeaderItemModel.h"
#import "WBSquareTableViewHeader.h"
#import "WBSquareTableViewCell.h"
#import "WBSquareTableViewCellModel.h"
#import "UIView+WBExtension.h"

@interface WBsquareTableViewController ()

@property (nonatomic, strong) NSArray *headerDataArray;

@end

@implementation WBsquareTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
  
    self.sectionsNumber = 2;
    WBSearchBar *searchbar =[WBSearchBar searchBar];
    searchbar.frame = CGRectMake(0, 0, 300, 30);
    
    self.navigationItem.titleView = searchbar;
    
    self.cellClass = [WBSquareTableViewCell class];
    
    [self setupHeader];
    
    [self setupModel];
    
  //  self.sectionsNumber = self.dataArray.count;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setupHeader
{
    WBSquareTableViewHeaderItemModel *model0 = [WBSquareTableViewHeaderItemModel modelWithTitle:@"红包" imageName:@"adw_icon_apcoupon_normal" destinationControllerClass:[WBBasicTableViewController class]];
    
    WBSquareTableViewHeaderItemModel *model1 = [WBSquareTableViewHeaderItemModel modelWithTitle:@"电子券" imageName:@"adw_icon_coupon_normal" destinationControllerClass:[WBBasicTableViewController class]];
    
    WBSquareTableViewHeaderItemModel *model2 = [WBSquareTableViewHeaderItemModel modelWithTitle:@"行程单" imageName:@"adw_icon_travel_normal" destinationControllerClass:[WBBasicTableViewController class]];
    
    WBSquareTableViewHeaderItemModel *model3 = [WBSquareTableViewHeaderItemModel modelWithTitle:@"会员卡" imageName:@"adw_icon_membercard_normal" destinationControllerClass:[WBBasicTableViewController class]];
    
    self.headerDataArray = @[model0, model1, model2, model3];
    
    
    WBSquareTableViewHeader *squareHeader = [[WBSquareTableViewHeader alloc] init];
    squareHeader.wb_height = 90;
    squareHeader.headerItemModelsArray = self.headerDataArray;
    __weak typeof(self) weakSelf = self;
    squareHeader.buttonClickHandler = ^(NSInteger index){
        WBSquareTableViewHeaderItemModel *model = weakSelf.headerDataArray[index];
        UIViewController *vc = [[model.destinationControllerClass alloc] init];
        vc.title = model.title;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = squareHeader;
}

- (void)setupModel
{
    // section 0 的model
    WBSquareTableViewCellModel *model01 = [WBSquareTableViewCellModel modelWithTitle:@"淘宝电影" iconImageName:@"adw_icon_movie_normal" destinationControllerClass:[WBBasicTableViewController class]];
    
    WBSquareTableViewCellModel *model02 = [WBSquareTableViewCellModel modelWithTitle:@"快抢" iconImageName:@"adw_icon_flashsales_normal" destinationControllerClass:[WBBasicTableViewController class]];
    
    WBSquareTableViewCellModel *model03 = [WBSquareTableViewCellModel modelWithTitle:@"快的打车" iconImageName:@"adw_icon_taxi_normal" destinationControllerClass:[WBBasicTableViewController class]];
    
    // section 1 的model
    WBSquareTableViewCellModel *model11 = [WBSquareTableViewCellModel modelWithTitle:@"我的朋友" iconImageName:@"adw_icon_contact_normal" destinationControllerClass:[WBBasicTableViewController class]];
    
    
    
    self.dataArray = @[@[model01, model02, model03],
                       @[model11]
                       ];

}

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBSquareTableViewCellModel *model = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
    UIViewController *vc = [[model.destinationControllerClass alloc] init];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == self.dataArray.count - 1) ? 10 : 0;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
