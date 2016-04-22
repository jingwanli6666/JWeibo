//
//  WBSquareTableViewHeader.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/5.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WBbuttonClickHandler)(NSInteger index);

@interface WBSquareTableViewHeader : UIView

@property (nonatomic, strong) NSArray *headerItemModelsArray;

@property (nonatomic, copy) WBbuttonClickHandler buttonClickHandler;

@end
