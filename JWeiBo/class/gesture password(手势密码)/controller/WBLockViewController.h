//
//  WBLockViewController.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/14.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBLockView.h"

@interface WBLockViewController : UIViewController

@property (nonatomic,assign) LockType type;

@property (nonatomic,assign) BOOL isVerifySuccess;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic,copy) void (^successBlock)(WBLockView *lockview,NSString *pwd);

@end
