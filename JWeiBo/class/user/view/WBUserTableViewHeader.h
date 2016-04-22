//
//  WBUserTableViewHeader.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/1.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBUserTableViewHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconHeadView;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *cardNumber;
@property (weak, nonatomic) IBOutlet UILabel *username;

@end
