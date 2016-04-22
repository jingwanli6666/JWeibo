//
//  WBBasicTableViewController.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/1.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum:NSUInteger{
    WBBasicTableViewControllerRefeshModeNone = 0,
    WBBasicTableViewControllerRefeshModeHeaderRefresh = 1<<0,
    WBBasicTableViewControllerRefeshModeFooterRefresh = 1<<1
    
}WBBasicTableViewControllerRefeshMode;

@interface WBBasicTableViewController : UITableViewController
@property (nonatomic,assign) NSInteger sectionsNumber;
@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,copy) Class cellClass;
@property (nonatomic,copy) Class cellModelClass;
@property (nonatomic,assign) WBBasicTableViewControllerRefeshMode refreshMode;

//如果需要刷新,子类须重写此方法
- (void)pullDownRefreshOperation;
@end
