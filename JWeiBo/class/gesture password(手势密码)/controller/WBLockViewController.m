//
//  WBLockViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/14.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBLockViewController.h"
#import "CoreLockConst.h"
#import "WBLockLabel.h"
#import "WBLockView.h"
#import "UIView+WBExtension.h"
#import "WBArchiveTool.h"
#import "WBTabBarViewController.h"
//#import "NSString+File.h"
//#import "MBProgressHUD+MJ.h"
#import "WBLockInfoView.h"
#import "UIView+WBExtension.h"

@interface WBLockViewController()
/** 操作成功：密码设置成功、密码验证成功 */

@property (nonatomic, strong) WBLockLabel *lockLabel;

@property (nonatomic, strong) WBLockView *lockView;



@property (nonatomic,copy) NSString *modifyCurrentTitle;

/** 直接进入修改页面的 */
@property (nonatomic,assign) BOOL isDirectModify;



@end

@implementation WBLockViewController

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.view.backgroundColor = [UIColor clearColor];
//    }
//    return self;
//}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _isVerifySuccess = NO;
        self.msg = CoreLockPWDTitleFirst;
        //self.view.backgroundColor = CoreLockViewBgColor;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    //设置背景色
    self.view.backgroundColor = CoreLockViewBgColor;
    //self.view.backgroundColor = [UIColor whiteColor];
    [self initLockView];
    [self initLockLabel];
    
    //数据传输
    [self dataTransfer];
    
    //处理事件
    [self HandleEvent];
}

/*
 *  事件
 */
-(void)HandleEvent{
    
    /*
     *  设置密码
     */
    
    /** 开始输入：第一次 */
    
    __weak typeof(self) weakSelf = self;
    self.lockView.setPWBeginBlock = ^(){
        
        [weakSelf.lockLabel showNormalMsg:CoreLockPWDTitleFirst];
    };
    
    /** 开始输入：确认 */
    self.lockView.setPWConfirmlock = ^(){
        
        [weakSelf.lockLabel showNormalMsg:CoreLockPWDTitleConfirm];
    };
    
    
    /** 密码长度不够 */
    self.lockView.setPWErrorLengthTooShortBlock = ^(NSUInteger currentCount){
        
        [weakSelf.lockLabel showWarnMsg:[NSString stringWithFormat:@"请连接至少%@个点",@(CoreLockMinItemCount)]];
    };
    
    /** 两次密码不一致 */
    self.lockView.setPWErrorTwiceDiffBlock = ^(NSString *pwd1,NSString *pwdNow){
        
        [weakSelf.lockLabel showWarnMsg:CoreLockPWDDiffTitle];
        [WBArchiveTool setBool:NO key:CoreLockVerifySuccess];

        
       // weakSelf.navigationItem.rightBarButtonItem = weakSelf.resetItem;
    };
    
    /** 第一次输入密码：正确 */
    self.lockView.setPWFirstRightBlock = ^(){
        
        [weakSelf.lockLabel showNormalMsg:CoreLockPWDTitleConfirm];
    };
    
    /** 再次输入密码一致 */
    self.lockView.setPWTwiceSameBlock = ^(NSString *pwd){
        
        [weakSelf.lockLabel showNormalMsg:CoreLockPWSuccessTitle];
        
        //存储密码
        [WBArchiveTool setStr:pwd key:CoreLockPWDKey];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[WBTabBarViewController alloc] init];
        
        //禁用交互
        weakSelf.view.userInteractionEnabled = NO;
        
        if(weakSelf.successBlock != nil)
        {
            weakSelf.successBlock(weakSelf,pwd);
            //weakSelf.isVerifySuccess = YES;
            [WBArchiveTool setBool:YES key:CoreLockVerifySuccess];
            
        }
        
        if(CoreLockTypeModifyPwd == _type){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    };
    
    
    
    /*
     *  验证密码
     */
    
    /** 开始 */
    self.lockView.verifyPWBeginBlock = ^(){
        
        [weakSelf.lockLabel showNormalMsg:CoreLockVerifyNormalTitle];
    };
    
    /** 验证 */
    self.lockView.verifyPwdBlock = ^(NSString *pwd){
        
        //取出本地密码
        NSString *pwdLocal = [WBArchiveTool strForKey:CoreLockPWDKey];
        
        BOOL res = [pwdLocal isEqualToString:pwd];
        
        if(res){//密码一致
            
            [weakSelf.lockLabel showNormalMsg:CoreLockVerifySuccesslTitle];
            [WBArchiveTool setBool:YES key:CoreLockVerifySuccess];
             //[MBProgressHUD showSuccess:@"密码正确"];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[WBTabBarViewController alloc] init];
            
            if(LockTypeVeryfiPwd == _type){
                
                //禁用交互
                self.view.userInteractionEnabled = NO;
                
            }else if (CoreLockTypeModifyPwd == _type){//修改密码
                
                [weakSelf.lockLabel showNormalMsg:CoreLockPWDTitleFirst];
                
                self.modifyCurrentTitle = CoreLockPWDTitleFirst;
            }
            
            if(LockTypeVeryfiPwd == _type) {
                if(weakSelf.successBlock != nil) _successBlock(weakSelf,pwd);
            }
            
        }else{//密码不一致
            
            [weakSelf.lockLabel showWarnMsg:CoreLockVerifyErrorPwdTitle];
            [WBArchiveTool setBool:NO key:CoreLockVerifySuccess];

            
        }
        
        return res;
    };
    
    
    
    /*
     *  修改
     */
    
    /** 开始 */
    self.lockView.modifyPwdBlock =^(){
        
        [weakSelf.lockLabel showNormalMsg:weakSelf.modifyCurrentTitle];
    };
    
    
}



-(void)initLockLabel{
    WBLockInfoView *lockInfo = [[WBLockInfoView alloc] init];
    //lockInfo.backgroundColor =  CoreLockViewBgColor;
    CGFloat lockInfoH = 60;
    lockInfo.center = CGPointMake(self.view.wb_width/2, lockInfoH*0.7f);
    lockInfo.bounds = CGRectMake(0, 0, 30, 30);
    //lockInfo.ali
    [self.view addSubview:lockInfo];
    
    
    WBLockLabel *lockLabel = [[WBLockLabel alloc] init];
    lockLabel.frame = CGRectMake(0,60, self.view.frame.size.width, 100);
    lockLabel.center = CGPointMake(self.view.wb_width/2, 120);
    lockLabel.textAlignment = NSTextAlignmentCenter;
    
    //lockLabel.backgroundColor = CoreLockViewBgColor;
    lockLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:lockLabel];
    _lockLabel = lockLabel;
}

-(void)initLockView
{
    WBLockView *lockview  = [[WBLockView alloc] init];
    lockview.frame = CGRectMake(0, 160, self.view.wb_width,self.view.frame.size.height - 160);
    lockview.backgroundColor = CoreLockViewBgColor;
    //lockview.type = LockTypeSetPwd;
    _lockView = lockview;
    
    [self.view addSubview:lockview];
}

/*
 *  数据传输
 */
-(void)dataTransfer{
    
    [self.lockLabel showNormalMsg:self.msg];
    
    //传递类型
    self.lockView.type = self.type;
}


-(void)setType:(LockType)type{
    
    _type = type;
    
    //根据type自动调整label文字
    [self labelWithType];
}


-(void)setMsg:(NSString *)msg
{
    _msg = msg;
    
    [_lockLabel showNormalMsg:msg];
}



/*
 *  根据type自动调整label文字
 */
-(void)labelWithType{
    
    if(LockTypeSetPwd == _type){//设置密码
        
        self.msg = CoreLockPWDTitleFirst;
        
    }else if (LockTypeVeryfiPwd == _type){//验证密码
        
        self.msg = CoreLockVerifyNormalTitle;
        
    }else if (CoreLockTypeModifyPwd == _type){//修改密码
        
        self.msg = CoreLockModifyNormalTitle;
    }
}



@end
