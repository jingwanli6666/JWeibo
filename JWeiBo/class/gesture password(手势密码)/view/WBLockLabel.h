//
//  WBLockLabel.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/14.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBLockLabel : UILabel

/**
 *  普通提示信息
 */
-(void)showNormalMsg:(NSString *)msg;

/**
 *  警告信息
 */
-(void)showWarnMsg:(NSString *)msg;

@end
