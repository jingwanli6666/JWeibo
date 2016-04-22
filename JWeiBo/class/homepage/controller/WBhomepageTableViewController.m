//
//  WBhomepageTableViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBhomepageTableViewController.h"
#import "wbTitleButton.h"
#import "AFNetworking.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "UIImageView+WebCache.h"
#import "WBStatuses.h"
#import "WBUser.h"
#import "WBStatuesCell.h"
#import "WBStatuesFrame.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "WBStatusTool.h"
#import "WBHttpTool.h"
#import "WBWeakProxy.h"

#define WBTitleButtonDownTag 0
#define WBTitleButtonUpTag -1

@interface WBhomepageTableViewController ()
@property (nonatomic,strong) NSMutableArray *statusFrames;
@property (nonatomic,strong) WBTitleButton *titleButton;
//@property (nonatomic,strong) MJRefreshFooterView *footer;
@end

@implementation WBhomepageTableViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //0.刷新数据
    [self setupRefreshData];
    
    //1.设置导航栏内容
    
    [self setTarBar];
    
    //2.设置首页内容
    //[self setHomepagestatusData];
    //2.设置用户的昵称
    [self setupUserData];
    
   
}

/**
 *  刷新首页最新数据
 */
-(void)setupRefreshData
{
    //1.下拉刷新
    UIRefreshControl *freshControl = [[UIRefreshControl alloc] init];
    [freshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:freshControl];
    //自动进入刷新状态
    [freshControl beginRefreshing];
    [self refreshControlStateChange:freshControl];
    
    //2.上拉刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}

-(void)loadMoreData
{
    WBAccount *account = [WBAccountTool getAccount];
    //2.封装请求参数
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] =account.access_token;
    params[@"count"] = @10;
    if (self.statusFrames.count) {
        WBStatuesFrame *statusFrame = [self.statusFrames lastObject];
        long long maxId =  [statusFrame.statues.idstr longLongValue] - 1;
        //WBLog(@"%@",statusFrame.statues.idstr);
        params[@"max_id"] = @(maxId);
    }
    
    //3.加载沙盒中的数据
   
    NSArray *statues = [WBStatusTool statuesWithParams:params];
    if (statues.count) {
        //将"微博字典"数组转为 "微博模型"数组
        NSArray *newStatues = [WBStatuses objectArrayWithKeyValuesArray:statues];
        NSMutableArray *statuesArr = [NSMutableArray array];
        //将 WBStatus数组转为WBStatusFrame数组
        for (WBStatuses *status in newStatues) {
            //传递数据模型数据
            WBStatuesFrame *statuesFrame = [[WBStatuesFrame alloc] init];
            statuesFrame.statues = status;
            [statuesArr addObject:statuesFrame];
        }
        
        //将最新的数据加到临时数组的最前端
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statuesArr];
        [tempArray addObjectsFromArray:self.statusFrames];
        //WBLog(@"%@",tempArray);
        
        //赋值
        self.statusFrames = tempArray;
        
        
        //刷新表格
        [self.tableView reloadData];
        
        //[MBProgressHUD hideHUD];
        
    }else{
    //3.放松请求
        [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params   success:^( id json) {
            //NSArray *dictArray = responseObject[@"statuses"];
            NSArray *statusArray = [WBStatuses objectArrayWithKeyValuesArray:json[@"statuses"]];
            
            NSMutableArray *statuesArr = [NSMutableArray array];
            
            for (WBStatuses *status in statusArray) {
                //传递数据模型数据
                WBStatuesFrame *statuesFrame = [[WBStatuesFrame alloc] init];
                statuesFrame.statues = status;
                [statuesArr addObject:statuesFrame];
            }
            
            //将最新的数据加到临时数组的最前端
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObjectsFromArray:statuesArr];
            [tempArray addObjectsFromArray:self.statusFrames];
            //WBLog(@"%@",tempArray);
            
            //赋值
            self.statusFrames = tempArray;
            //刷新表格
            [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.footer endRefreshing];
    }];
        
    }

}

-(void)refreshControlStateChange:(UIRefreshControl *)freshControl
{
    //WBLog(@"-----刷新最新数据");
    //取微博数据
    //1.创建请求管理对象
    WBAccount *account = [WBAccountTool getAccount];
    //2.封装请求参数
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] =account.access_token;
    params[@"count"] = @10;
    if (self.statusFrames.count) {
        WBStatuesFrame *statusFrame = self.statusFrames[0];
        params[@"since_id"] = statusFrame.statues.idstr;
    }
    
    
    //3.先尝试从数据库中加载微博数据
    NSArray *statues = [WBStatusTool statuesWithParams:params];
    if (statues.count) {
        //将"微博字典"数组转为 "微博模型"数组
        NSArray *newStatues = [WBStatuses objectArrayWithKeyValuesArray:statues];
        NSMutableArray *statuesArr = [NSMutableArray array];
        //将 WBStatus数组转为WBStatusFrame数组
        for (WBStatuses *status in newStatues) {
            //传递数据模型数据
            WBStatuesFrame *statuesFrame = [[WBStatuesFrame alloc] init];
            statuesFrame.statues = status;
            [statuesArr addObject:statuesFrame];
        }
        
        //将最新的数据加到临时数组的最前端
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statuesArr];
        [tempArray addObjectsFromArray:self.statusFrames];
        //WBLog(@"%@",tempArray);
        
        //赋值
        self.statusFrames = tempArray;
        
        
        //刷新表格
        [self.tableView reloadData];
        
        //[MBProgressHUD hideHUD];
        
        [freshControl endRefreshing];
        
        //显示最新微博的数量(给用户一些友善的提示)
        [self showNewStatusCount:statuesArr.count];

    }else{
         //3.放松请求
        [WBHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params   success:^( id json) {
        //NSArray *dictArray = responseObject[@"statuses"];
        NSArray *statusArray = [WBStatuses objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        NSMutableArray *statuesArr = [NSMutableArray array];
        
        for (WBStatuses *status in statusArray) {
            //传递数据模型数据
            WBStatuesFrame *statuesFrame = [[WBStatuesFrame alloc] init];
            statuesFrame.statues = status;
            [statuesArr addObject:statuesFrame];
        }
        
        //将最新的数据加到临时数组的最前端
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statuesArr];
        [tempArray addObjectsFromArray:self.statusFrames];
        //WBLog(@"%@",tempArray);
        
        //赋值
        self.statusFrames = tempArray;
        //刷新表格
        [self.tableView reloadData];
        
        //[MBProgressHUD hideHUD];
        
        [freshControl endRefreshing];
        
        //显示最新微博的数量(给用户一些友善的提示)
        [self showNewStatusCount:statuesArr.count];
        
        [WBStatusTool saveStatues:json[@"statuses"]];
        
    } failure:^( NSError *error) {
        //[MBProgressHUD hideHUD];
        //        WBLog(@"%@",error);
       [freshControl endRefreshing];
    }];

    }
}

/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
-(void)showNewStatusCount:(int)count
{
    //1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    //below 下面 self.navigationController.navigationBar
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    //2.设置图片和文字
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizeImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条更新微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有微博更新" forState:UIControlStateNormal];
    }
    
    //3.设置btn的frame
    CGFloat btnX = 0;
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnW = self.view.frame.size.width;
    
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    //4.通过动画移动按钮(按钮向下移动 btnH+1)
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH + 2);
    }completion:^(BOOL finished) { //向下移动的动画执行完毕后
        //建议:尽量使用animateWithDuration
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //将btn从内存中移除
            [btn removeFromSuperview];
        }];
    }];
    
}

/**
 *  设置导航的内容
 */
-(void)setTarBar
{
    //左边按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageWithName:@"navigationbar_friendsearch"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageWithName:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
    leftBtn.frame = (CGRect){CGPointZero,leftBtn.currentBackgroundImage.size};
    [leftBtn addTarget:self action:@selector(findFriend) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageWithName:@"navigationbar_pop"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageWithName:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    rightBtn.frame = (CGRect){CGPointZero,leftBtn.currentBackgroundImage.size};
    [rightBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    //中间按钮
    WBTitleButton *titleButton = [WBTitleButton titleButon];
    //图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //文字
    if ([WBAccountTool getAccount].name) {
        [titleButton setTitle:[WBAccountTool getAccount].name forState:UIControlStateNormal];
    }else{
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    
    titleButton.frame = CGRectMake(0, 0, 0, 30);
    titleButton.tag = WBTitleButtonDownTag;
    
    [titleButton addTarget:self action:@selector(titleclick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    
    self.tableView.backgroundColor = WBColor(226, 226, 226);
    //self.tableView.contentInset = UIEdgeInsetsMake(0, 0, WBStatuesboarder, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)setHomepagestatusData
{
    WBAccount *account = [WBAccountTool getAccount];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    //
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
   params[@"access_token"] =account.access_token;
    params[@"count"]= @5;
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSArray *dictArray = responseObject[@"statuses"];
        NSArray *statusArray = [WBStatuses objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
       
        NSMutableArray *statuesArr = [NSMutableArray array];
        
        for (WBStatuses *status in statusArray) {
            //传递数据模型数据
            WBStatuesFrame *statuesFrame = [[WBStatuesFrame alloc] init];
            statuesFrame.statues = status;
            [statuesArr addObject:statuesFrame];
        }
        
        //赋值
        self.statusFrames = statuesArr;
     
        
        //刷新表格
        [self.tableView reloadData];
        
        //[MBProgressHUD hideHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[MBProgressHUD hideHUD];
        //        WBLog(@"%@",error);
    }];

}

-(void)setupUserData
{
    WBAccount *account = [WBAccountTool getAccount];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    //
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] =account.access_token;
    params[@"uid"] = @(account.uid);
    //params[@"count"]= @5;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        WBUser *user = [WBUser objectWithKeyValues:responseObject];
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        account.name = user.name;
        [WBAccountTool setAccout:account];
             //[MBProgressHUD hideHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[MBProgressHUD hideHUD];
        //        WBLog(@"%@",error);
    }];

}

-(void)titleclick:(WBTitleButton *)titleButton
{
    if (titleButton.tag == WBTitleButtonUpTag) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = WBTitleButtonDownTag;
    }else{
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = WBTitleButtonUpTag;
    }
}

-(void)findFriend
{
    WBLog(@"hello");
}


-(void)pop
{
    WBLog(@"pop");
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
  
    return self.statusFrames.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建cell
    WBStatuesCell *cell = [WBStatuesCell cellWithTableView:tableView];

    //2.传递frame模型
   // WBLog(@"%d",indexPath.row);
    cell.statuesframe = self.statusFrames[indexPath.row];
    //WBLog(@"%@",self.statusFrames[indexPath.row]);
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    //vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatuesFrame  *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;

}




@end
