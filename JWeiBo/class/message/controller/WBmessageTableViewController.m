//
//  WBmessageTableViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBmessageTableViewController.h"
#import "WBCommonCell.h"
#import "WBCommonItem.h"
#import "WBCommonGroup.h"

@interface WBmessageTableViewController ()

@property (nonatomic,strong) NSMutableArray *groups;

@end

@implementation WBmessageTableViewController

-(NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray  array];
    }
    return _groups;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    return self;
}

-(id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    //设置tableview的属性
    //设置全局背景色
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 20;
    
    //不显示水平滚动条
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    //初始化模型数据
    [self setupGroups];
}

-(void)setupGroups
{
    //第0组
    [self setupGroups0];
    
    //第1组
    [self setupGroups1];
    
    //第2组
    [self setupGroups2];


}

-(void)setupGroups0
{
    //1.创建组
    WBCommonGroup *group = [[WBCommonGroup alloc] init];
    [self.groups addObject:group];
    
    //2.设置组的基本数据
    group.groupheader = @"第0组";
    group.groupfooter = @"第0组的尾部";
    
    //3.设置组中所有行的数据
    WBCommonItem *messagecenter = [WBCommonItem itemWithTitle:@"@我" icon:@"messagescenter_at"];
    
    
    WBCommonItem *comment = [WBCommonItem itemWithTitle:@"评论" icon:@"messagescenter_comments"];
  
    WBCommonItem *good = [WBCommonItem itemWithTitle:@"赞" icon:@"messagescenter_good"];
    
    group.items = @[messagecenter,comment,good];
    
    
}

-(void)setupGroups1
{
    //1.创建组
    WBCommonGroup *group = [[WBCommonGroup alloc] init];
    [self.groups addObject:group];
    
    //2.设置组的基本数据
    group.groupheader = @"第0组";
    group.groupfooter = @"第0组的尾部";
    
    //3.设置组中所有行的数据
    WBCommonItem *car = [WBCommonItem itemWithTitle:@"交通" icon:@"square_icon_car"];
    car.subtitle = @"实时交通";
    
    WBCommonItem *findfriends = [WBCommonItem itemWithTitle:@"找人" icon:@"square_icon_findfriends"];
    car.subtitle = @"找人";
    
    group.items = @[car,findfriends];
}

-(void)setupGroups2
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    WBCommonGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取cell
    WBCommonCell *cell = [WBCommonCell cellWithTableView:tableView];
    
    //2.设置cell的显示数据
    WBCommonGroup *group = self.groups[indexPath.section];
    WBCommonItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60.0;
//}


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
