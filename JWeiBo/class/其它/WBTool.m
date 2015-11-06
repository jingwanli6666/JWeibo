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

@implementation WBTool

+(void)chooseController
{
    NSString *currentVesion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //WBLog(@"%@",currentVesion);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *LastVersion = [defaults stringForKey:@"LastVersion"];
    
    if ([currentVesion isEqualToString:LastVersion]) {
        WBTabBarViewController *tabbarviewcontroller = [[WBTabBarViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabbarviewcontroller;
    }else{
        
        WBNewFeatureViewController *newFeatureviewcontroller = [[WBNewFeatureViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = newFeatureviewcontroller;
        
        //存储新版本
        [defaults setValue:currentVesion forKey:@"LastVersion"];
        [defaults synchronize];
    }
}

@end
