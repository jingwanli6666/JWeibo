//
//  WBServiceListView.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/6.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBServiceListView;

@protocol WBServiceListViewDelegate <NSObject>
- (void)ServiceListView:(WBServiceListView *)ListView selectItemAtIndex:(NSInteger)index;
- (void)ServiceListViewMoreItemButton:(WBServiceListView *)ListView;
- (void)ServiceListViewDidChangeItems:(WBServiceListView *)ListView;

@end

@interface WBServiceListView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id<WBServiceListViewDelegate> ListViewdelegate;
@property (nonatomic, strong) NSArray *ListModelsArray;
@property (nonatomic, strong) NSArray *scrollADImageURLStringsArray;;

@end
