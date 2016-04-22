//
//  WBBasicTableViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/1.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBBasicTableViewController.h"
#import "WBBasicTableViewCell.h"

@interface WBBasicTableViewController()



@end

@implementation WBBasicTableViewController

-(instancetype)init
{
    if (self = [super init]) {
        _refreshMode = WBBasicTableViewControllerRefeshModeNone;
        _sectionsNumber = 1;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:(245 / 255.0) green:(245 / 255.0) blue:(245 / 255.0) alpha:1];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self setupRefreshMode];
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.tableView reloadData];
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:[self.cellClass description]];
}

- (void)setRefreshMode:(WBBasicTableViewControllerRefeshMode)refreshMode
{
    _refreshMode = refreshMode;
    [self setupRefreshMode];
}

-(void)setupRefreshMode
{
    switch (_refreshMode) {
        case WBBasicTableViewControllerRefeshModeNone:
        {
           break;
        }
            
        case WBBasicTableViewControllerRefeshModeHeaderRefresh:
        {
            UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
            [refresh addTarget:self action:@selector(pullDownRefreshOperation) forControlEvents:UIControlEventValueChanged];
            self.refreshControl = refresh;
            break;
        }
        
        case WBBasicTableViewControllerRefeshModeFooterRefresh:
        {
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - data source 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // WBLog(@"%d",self.sectionsNumber);
    return self.sectionsNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = (self.sectionsNumber==1)?self.dataArray.count:[self.dataArray[section] count];
    //WBLog(@"%d",number);
    return number;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WBBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.cellClass description]];
    if (!cell) {
        cell = [[self.cellClass alloc] init];
    }
    
    if (self.sectionsNumber == 1) {
        cell.model = self.dataArray[indexPath.row];
    }else if(self.sectionsNumber >1){
        cell.model = [self.dataArray[indexPath.section] objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark -需要子类去重写
-(void)pullDownRefreshOperation
{
    
}

@end
