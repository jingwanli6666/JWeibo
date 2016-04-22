//
//  WBServiceListItemView.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/6.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBServiceItemModel;
@class WBServiceListItemView;

typedef void(^itemLongPressOperationBlock)(UILongPressGestureRecognizer *longPress);
typedef void(^buttonClickOperationBlock)(WBServiceListItemView *item);
typedef void(^iconViewClickOperationBlock)(WBServiceListItemView *view);

@interface WBServiceListItemView : UIView

@property (nonatomic, strong) WBServiceItemModel *itemModel;
@property (nonatomic, assign) BOOL hidenIcon;

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, copy) itemLongPressOperationBlock LongPressOperationHandler;
@property (nonatomic, copy) buttonClickOperationBlock buttonClickOperationHandler;
@property (nonatomic, copy) iconViewClickOperationBlock iconViewClickOperationHandler;

@end
