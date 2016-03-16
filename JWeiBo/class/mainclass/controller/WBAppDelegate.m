//
//  WBAppDelegate.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBAppDelegate.h"
//#import "WBTabBarViewController.h"
//#import "WBNewFeatureViewController.h"
#import "WBOauthViewController.h"
#import "WBAccount.h"
#import "WBTool.h"
#import "WBAccountTool.h"
#import "SDWebImageManager.h"

@implementation WBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //显示状态栏
    //application.statusBarHidden = NO;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    WBAccount * account = [WBAccountTool getAccount];
    
    if (account) { //之前登录成功
        [WBTool chooseController];
        
    }else{ //之前没有登录
        self.window.rootViewController =[[WBOauthViewController alloc] init];
    }
    
    // Override point for customization after application launch.
   // self.window.backgroundColor = [UIColor whiteColor];
    
    
    //tabbarviewcontroller.tabBar.hidden = NO;
    //self.window.rootViewController = tabbarviewcontroller;
    //self.window.hidden
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//app进入后台调用
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //在后台开始任务让程序持续保持运行状态(能运行保持的时间是不确定的)
    [application beginBackgroundTaskWithExpirationHandler:^{
        
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    
    //删除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
