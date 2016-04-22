//
//  WBuserTableViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBuserTableViewController.h"
#import "WBUserTableViewCell.h"
#import "WBUserTableViewCellModel.h"
#import "WBUserTableViewHeader.h"
#import "WBAssetTableViewController.h"
#import "WBLockViewController.h"

@interface WBuserTableViewController ()

@end

@implementation WBuserTableViewController

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
    
    self.sectionsNumber = 3;
    self.cellClass = [WBUserTableViewCell class];
    
    [self setupModel];
    
    WBUserTableViewHeader *tableheader = [[WBUserTableViewHeader alloc] init];
    tableheader.iconHeadView.image = [UIImage imageNamed:@"tmall_icon"];
    self.tableView.tableHeaderView = tableheader;
    
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)setupModel
{
    //section 0 model
    WBUserTableViewCellModel *model01 = [WBUserTableViewCellModel modelWithTitle:@"余额宝" iconImageName:@"20000032Icon" destinationControllerClass:[WBAssetTableViewController class]];
    
    WBUserTableViewCellModel *model02= [WBUserTableViewCellModel modelWithTitle:@"招财宝" iconImageName:@"20000059Icon" destinationControllerClass:[WBBasicTableViewController class]];
    
    WBUserTableViewCellModel *model03 = [WBUserTableViewCellModel modelWithTitle:@"娱乐宝" iconImageName:@"20000077Icon" destinationControllerClass:[WBBasicTableViewController class]];
    
    // section 1 的model
    WBUserTableViewCellModel *model11 = [WBUserTableViewCellModel modelWithTitle:@"芝麻信用分" iconImageName:@"20000118Icon" destinationControllerClass:[WBBasicTableViewController class]];
    
    WBUserTableViewCellModel *model12 = [WBUserTableViewCellModel modelWithTitle:@"随身贷" iconImageName:@"20000180Icon" destinationControllerClass:[WBBasicTableViewController class]];
    
    WBUserTableViewCellModel *model13 = [WBUserTableViewCellModel modelWithTitle:@"我的保障" iconImageName:@"20000110Icon" destinationControllerClass:[WBLockViewController class]];
    
    // section 2 的model
    WBUserTableViewCellModel *model21 = [WBUserTableViewCellModel modelWithTitle:@"爱心捐赠" iconImageName:@"09999978Icon" destinationControllerClass:[WBBasicTableViewController class]];
    
    self.dataArray = @[@[model01, model02, model03],
                       @[model11, model12, model13],
                       @[model21]
                       ];

}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBUserTableViewCellModel *model = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
    
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
    return (section == self.dataArray.count -1)? 10:0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
