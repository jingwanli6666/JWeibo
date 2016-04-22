//
//  WBLockView.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/13.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    //设置密码
    LockTypeSetPwd = 0,
    
    //输入并验证密码
    LockTypeVeryfiPwd,
    
    //修改密码
    CoreLockTypeModifyPwd,
    
}LockType;
@interface WBLockView : UIView

@property (nonatomic, assign) LockType type;


/**
 * 设置密码
 */

/**  开始输入，第一次 */
@property (nonatomic, copy) void (^setPWBeginBlock)();

/** 开始输入，确认密码**/
@property (nonatomic, copy) void (^setPWConfirmlock)();

/** 设置密码出错：长度不够 **/
@property (nonatomic, copy) void (^setPWErrorLengthTooShortBlock)(NSUInteger count);

/** 设置密码出错：再次密码不一致 **/
@property (nonatomic, copy) void (^setPWErrorTwiceDiffBlock)(NSString *frist,NSString *second);

/* 设置密码: 第一次输入正确*/
@property (nonatomic, copy) void (^setPWFirstRightBlock)();


/** 再次密码输入一致 */
@property (nonatomic,copy) void (^setPWTwiceSameBlock)(NSString *pwd);

/*
 *  重设密码
 */
-(void)resetPwd;

/**
 *  验证密码
 */

/** 验证密码开始**/
@property (nonatomic,copy) void (^verifyPWBeginBlock)();

/** 验证密码 **/
@property (nonatomic,copy) BOOL (^verifyPwdBlock)(NSString *pwd);

/*
 *  修改密码
 */
/** 再次密码输入一致 */
@property (nonatomic,copy) void (^modifyPwdBlock)();


/** 密码修改成功 */
@property (nonatomic,copy) void (^modifyPwdSuccessBlock)();

@end
