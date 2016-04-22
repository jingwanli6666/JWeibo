//
//  WBTool.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-23.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBTool.h"
#import "WBTabBarViewController.h"
#import "WBNewFeatureViewController.h"
#import "WBLockViewController.h"
#import "WBArchiveTool.h"
#import "CoreLockConst.h"

@implementation WBTool

+(void)chooseController
{
    NSString *currentVesion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //WBLog(@"%@",currentVesion);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *LastVersion = [defaults stringForKey:@"LastVersion"];
    
    if ([currentVesion isEqualToString:LastVersion]) {
       
        //[UIApplication sharedApplication].keyWindow.rootViewController = tabbarviewcontroller;
        WBLockViewController *lockviewController = [[WBLockViewController alloc] init];
        
        if (![WBArchiveTool hasPwd]) {
            lockviewController.type = LockTypeSetPwd;
            lockviewController.msg = CoreLockPWDTitleFirst;
        }else{
            lockviewController.type = LockTypeVeryfiPwd;
            lockviewController.msg = CoreLockVerifyNormalTitle;
        }
        
        
            [UIApplication sharedApplication].keyWindow.rootViewController = lockviewController;
        
    }else{
        
        WBNewFeatureViewController *newFeatureviewcontroller = [[WBNewFeatureViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = newFeatureviewcontroller;
        
        //存储新版本
        [defaults setValue:currentVesion forKey:@"LastVersion"];
        [defaults synchronize];
    }
}

@end
