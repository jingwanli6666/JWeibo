//
//  WBServiceViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/8.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBServiceViewController.h"
#import "UIView+WBExtension.h"
#import "WBServiceListView.h"
#import "WBScanViewController.h"
#import "WBServiceItemModel.h"
#import "WBServiceItemCacheTool.h"

#define KServiceHeaderViewHeight 110

@interface WBServiceViewController()<WBServiceListViewDelegate>
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, strong) WBServiceListView *listView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation WBServiceViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //扫一扫和付款码
    [self setupHeader];
    [self setupListView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat tabbarHeight = [[self.tabBarController tabBar] wb_height];
    
    CGFloat headerY = 0;
    headerY = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) ? 64 : 0;
    
//    WBLog(@"%d",headerY);
//    WBLog(@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]);
    
    _headerView.frame = CGRectMake(0, headerY, self.view.wb_width, KServiceHeaderViewHeight);
    
    _listView.frame = CGRectMake(0, _headerView.wb_y+KServiceHeaderViewHeight, self.view.wb_width, self.view.wb_height- KServiceHeaderViewHeight - tabbarHeight);
}

-(void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    header.bounds = CGRectMake(0, 0, self.view.wb_width, KServiceHeaderViewHeight);
    header.backgroundColor = [UIColor colorWithRed:(38/255.0) green:(42/255) blue:(59/255) alpha:1];
    [self.view addSubview:header];
    _headerView = header;
    
    UIButton *scan = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, header.wb_width*0.5, header.wb_height)];
    [scan setImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
    [scan addTarget:self action:@selector(scanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:scan];
    
    UIButton *pay = [[UIButton alloc] initWithFrame:CGRectMake(scan.wb_width, 0, header.wb_width * 0.5, header.wb_height)];
    [pay setImage:[UIImage imageNamed:@"home_pay"] forState:UIControlStateNormal];
    [header addSubview:pay];
    
}

-(void)scanButtonClick
{
    WBScanViewController *scanViewController = [[WBScanViewController alloc] init];
    [self.navigationController pushViewController:scanViewController animated:YES];
    //[self.navigationController pop]
}

-(void)setupListView
{
    WBServiceListView *listView = [[WBServiceListView alloc] init];
    listView.ListViewdelegate = self;
    listView.showsVerticalScrollIndicator = NO;
    [self setupDataArray];
    listView.ListModelsArray =_dataArray;
    
    [self.view addSubview:listView];
    _listView = listView;
}

-(void)setupDataArray
{
    NSArray *itemsArray = [WBServiceItemCacheTool itemsArray];
    
    NSMutableArray *temp = [NSMutableArray array];
    if (itemsArray.count) {
            for (NSDictionary *itemDict in itemsArray ) {
                WBServiceItemModel *model = [[WBServiceItemModel alloc] init];
                model.destinationClass = [WBBasicViewController class];
                model.imageStr =[itemDict.allValues firstObject];
                model.title = [itemDict.allKeys firstObject];
                [temp addObject:model];
            }
    }else{
    NSArray *titleArray = @[@"淘宝",
                            @"生活缴费",
                            @"教育缴费",
                            @"红包",
                            @"物流",
                            @"信用卡",
                            @"转账",
                            @"爱心捐款",
                            @"彩票",
                            @"当面付",
                            @"余额宝",
                            @"AA付款",
                            @"国际汇款",
                            @"淘点点",
                            @"淘宝电影",
                            @"亲密付",
                            @"股市行情",
                            @"汇率换算",
                            ];
        
        for (int i = 0; i < 18; i++) {
            WBServiceItemModel *model = [[WBServiceItemModel alloc] init];
            model.destinationClass = [WBBasicViewController class];
            model.imageStr = [NSString stringWithFormat:@"i%02d", i];
            model.title = titleArray[i];
            [temp addObject:model];
        }

    }
    //NSMutableArray *temp = [NSMutableArray array];
    

    _dataArray = [temp copy];
    //_listView.ListModelsArray = [temp copy];
}

#pragma mark -代理方法
-(void)ServiceListView:(WBServiceListView *)ListView selectItemAtIndex:(NSInteger)index
{
    WBServiceItemModel *model = _dataArray[index];
    UIViewController *vc = [[model.destinationClass alloc] init];
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ServiceListViewDidChangeItems:(WBServiceListView *)ListView
{
    [self setupDataArray];
}

-(void)ServiceListViewMoreItemButton:(WBServiceListView *)ListView
{
    //WBAddItemViewController *addVc = [w]
}
@end
