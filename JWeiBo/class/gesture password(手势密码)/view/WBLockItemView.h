//
//  WBLockItemView.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/12.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WBDirectionOptions) {
    //正上
    LockItemViewDirecTop = 1,
    
    //右上
    LockItemViewDirecRightTop =2 ,
    
    //右
    LockItemViewDirecRight,
    
    //右下
    LockItemViewDiretRightBottom,
    
    //下
    LockItemViewDirecBottom,
    
    //左下
    LockItemViewDirecLeftBottom,
    
    //左
    LockItemViewDirecLeft,
    
    //左上
    LockItemViewDirecLeftTop,

};

@interface WBLockItemView : UIView

/**
 是否选中
 */
@property (nonatomic, assign) BOOL selected;

/** 方向 */
@property (nonatomic, assign) WBDirectionOptions direct;

@end
