//
//  WBServiceListView.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/6.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBServiceListView.h"
#import "WBServiceItemModel.h"
#import "WBServiceListItemView.h"
#import "UIView+WBExtension.h"
#import "WBServiceItemCacheTool.h"

#define kServiceListViewPerRowItemCount  4
#define kServiceListViewTopSectionRowCount 3

@interface WBServiceListView()
@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, strong) NSMutableArray *rowSeparatorsArray;
@property (nonatomic, strong) NSMutableArray *columnSeparatorsArray;
@property (nonatomic, assign) BOOL shouldAdjustSeparators;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) UIButton *placeholderButton;
@property (nonatomic, strong) WBServiceListItemView *currentPressView;
@property (nonatomic, strong) UIButton *moreItemButton;
@property (nonatomic, assign) CGRect currentPressViewFrame;
@end

@implementation WBServiceListView

#pragma mark -懒加载
-(NSMutableArray *)itemsArray
{
    if (!_itemsArray ) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

#pragma mark -懒加载
-(NSMutableArray *)rowSeparatorsArray
{
    if (!_rowSeparatorsArray) {
        _rowSeparatorsArray = [NSMutableArray array];
    }
    return _rowSeparatorsArray;
}

#pragma mark -懒加载
- (NSMutableArray *)columnSeparatorsArray
{
    if (!_columnSeparatorsArray) {
        _columnSeparatorsArray = [NSMutableArray array];
    }
    return _columnSeparatorsArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _shouldAdjustSeparators = NO;
        
        _placeholderButton = [[UIButton alloc] init];
    }
    return  self;
}

-(void)setListModelsArray:(NSArray *)ListModelsArray
{
    _ListModelsArray = ListModelsArray;
    
    [_itemsArray removeAllObjects];
    [_rowSeparatorsArray removeAllObjects];
    [_columnSeparatorsArray removeAllObjects];
    
    [ListModelsArray enumerateObjectsUsingBlock:^(WBServiceItemModel  *model, NSUInteger idx, BOOL *  stop) {
        WBServiceListItemView *item = [[WBServiceListItemView alloc] init];
        item.itemModel = model;
        __weak typeof(self) weakSelf = self;
        item.LongPressOperationHandler = ^(UILongPressGestureRecognizer *longPress){
            [weakSelf buttonLongPress:longPress];
        };
        
        item.iconViewClickOperationHandler = ^(WBServiceListItemView *view){
            [weakSelf deleteView:view];
            
        };
        
        item.buttonClickOperationHandler =  ^(WBServiceListItemView *view){
            if(!_currentPressView.hidenIcon && _currentPressView)
            {
                _currentPressView.hidenIcon = YES;
                return;
            }
            if ([self.ListViewdelegate respondsToSelector:@selector(ServiceListView:selectItemAtIndex:)]) {
                [self.ListViewdelegate ServiceListView:self selectItemAtIndex:[_itemsArray indexOfObject:view]];
            }
        };
        
        [self addSubview:item];
        [self.itemsArray addObject:item];
    }];
    
    UIButton *more = [[UIButton alloc] init];
    [more setImage:[UIImage imageNamed:@"tf_home_more"] forState:UIControlStateNormal];
    [more addTarget:self action:@selector(moreItemBUttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
    [self.itemsArray addObject:more];
    self.moreItemButton = more;
    
    long rowCount = [self rowCountWithItem:ListModelsArray.count];
    
    UIColor *lineColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
    
    for (int i=0; i< (rowCount +1); i++) {
        UIView *rowSeparator = [[UIView alloc] init];
        rowSeparator.backgroundColor = lineColor;
        [self addSubview:rowSeparator];
        [self.rowSeparatorsArray addObject:rowSeparator];
    }

    for (int i=0; i< (kServiceListViewPerRowItemCount +1); i++ ) {
        UIView *columnSeparator = [[UIView alloc] init];
        columnSeparator.backgroundColor = lineColor;
        [self addSubview:columnSeparator];
        [self.columnSeparatorsArray addObject:columnSeparator];
    }
    
    self.shouldAdjustSeparators = YES;
}

#pragma mark -代理方法
-(void)moreItemButtonClick
{
    if ([self.ListViewdelegate respondsToSelector:@selector(ServiceListViewMoreItemButton:)]) {
        [self.ListViewdelegate ServiceListViewMoreItemButton:self];
    }
}

-(void)buttonLongPress:(UILongPressGestureRecognizer *)longPress
{
    WBServiceListItemView *pressView = (WBServiceListItemView *)longPress.view;
    CGPoint point = [longPress locationInView:self];
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        _currentPressView.hidenIcon = YES;
        _currentPressView = pressView;
        _currentPressViewFrame = pressView.frame;
        longPress.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        pressView.hidenIcon = NO;
        long index = [_itemsArray indexOfObject:longPress.view];
        [_itemsArray removeObject:longPress.view];
        [_itemsArray insertObject:_placeholderButton atIndex:index];
        _lastPoint = point;
        [self bringSubviewToFront:longPress.view];
    }
    
    CGRect temp = longPress.view.frame;
    temp.origin.x += point.x - _lastPoint.x;
    temp.origin.y += point.y - _lastPoint.y;
    longPress.view.frame = temp;
    
    _lastPoint = point;
    
    [_itemsArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (btn == _moreItemButton) {
            return ;
        }
        if (CGRectContainsPoint(btn.frame, point) && btn != longPress.view) {
            [_itemsArray removeObject:_placeholderButton];
            [_itemsArray insertObject:_placeholderButton atIndex:idx];
            *stop = YES;
            
            [UIView animateWithDuration:0.5 animations:^{
                [self setupSubViewsFrame];
            }];
        }
    }];
    
    if (longPress.state == UIGestureRecognizerStateEnded) {
        long index = [_itemsArray indexOfObject:_placeholderButton];
        [_itemsArray removeObject:_placeholderButton];
        [_itemsArray insertObject:longPress.view atIndex:index];
        [self sendSubviewToBack:longPress.view];
        
        //保存数据
        [self saveItemsSettingCache];
        
        [UIView animateWithDuration:0.4 animations:^{
            longPress.view.transform = CGAffineTransformIdentity;
            [self setupSubViewsFrame];
            }completion:^(BOOL finished) {
                if (!CGRectEqualToRect(_currentPressViewFrame, _currentPressView.frame)) {
                    _currentPressView.hidenIcon = YES;
            }
        }];
    }
}

#pragma mark 删除button
-(void)deleteView:(WBServiceListItemView *)view
{
    [_itemsArray removeObject:view];
    [view removeFromSuperview];
    [self saveItemsSettingCache];
    [UIView animateWithDuration:0.4 animations:^{
        [self setupSubViewsFrame];
    }];
}


- (void)saveItemsSettingCache
{
    NSMutableArray *tempItemsContainer = [NSMutableArray new];
    [_itemsArray enumerateObjectsUsingBlock:^(WBServiceListItemView *button, NSUInteger idx, BOOL *stop) {
        if ([button isKindOfClass:[WBServiceListItemView class]]) {
            [tempItemsContainer addObject:@{button.itemModel.title : button.itemModel.imageStr}];
        }
    }];
    [WBServiceItemCacheTool saveItemsArray:[tempItemsContainer copy]];
    if ([self.ListViewdelegate respondsToSelector:@selector(ServiceListViewDidChangeItems:)]) {
        [self.ListViewdelegate ServiceListViewDidChangeItems:self];
    }
}

-(NSInteger)rowCountWithItem:(NSInteger)count
{
    long rowCount = (count + kServiceListViewPerRowItemCount -1)/kServiceListViewPerRowItemCount;
    rowCount = (rowCount<4)?4 : ++rowCount;
    return rowCount;
}

- (void)setupSubViewsFrame
{
    CGFloat itemW = self.wb_width / kServiceListViewPerRowItemCount;
    CGFloat itemH = itemW * 1.1;
    [_itemsArray enumerateObjectsUsingBlock:^(UIView *item, NSUInteger idx, BOOL * _Nonnull stop) {
        long rowIndex = idx / kServiceListViewPerRowItemCount;
        long columnIndex = (idx+kServiceListViewPerRowItemCount) % kServiceListViewPerRowItemCount;
        
        CGFloat x = itemW * columnIndex;
        CGFloat y = 0;
        if (idx < kServiceListViewPerRowItemCount * kServiceListViewTopSectionRowCount) {
            y = itemH * rowIndex;
        }else{
            y = itemH * (rowIndex + 1);
        }
        
        item.frame = CGRectMake(x, y, itemW, itemH);
        
        if (idx == (_itemsArray.count -1)) {
            self.contentSize = CGSizeMake(0, item.wb_height+item.wb_y+64);
        }
    }];
}

#pragma mark -界面布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemW = self.wb_width / kServiceListViewPerRowItemCount;
    CGFloat itemH = itemW * 1.1;
    
    [self setupSubViewsFrame];
    
    if (_shouldAdjustSeparators) {
        [_rowSeparatorsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat w = self.wb_width;
            CGFloat h = 0.4;
            CGFloat x = 0;
            CGFloat y = idx * itemH;
            view.frame = CGRectMake(x, y, w, h);
        }];
        
        [_columnSeparatorsArray enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat w = 0.4;
            CGFloat h = MAX(self.contentSize.height, self.wb_height);
            CGFloat x = idx * itemW;
            CGFloat y = 0;
            view.frame = CGRectMake(x, y, w, h);
            
        }];
        _shouldAdjustSeparators = NO;
    }
}

#pragma mark -scroll view delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _currentPressView.hidenIcon = YES;
}

@end
