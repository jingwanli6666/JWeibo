//
//  WBAssetTableViewCellContentView.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/2.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAssetTableViewCellContentView : UIView

@property (nonatomic, assign) float yesterdayIncome;
@property (nonatomic, assign) float totalMoneyAmount;

@property (nonatomic, weak) IBOutlet UILabel *yesterdayIncomeLabel;

@property (nonatomic, weak) IBOutlet UILabel *totalMoneyAmountLabel;

@end
