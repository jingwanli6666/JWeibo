//
//  WBNavigationViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-18.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBNavigationViewController.h"

@interface WBNavigationViewController ()

@end

@implementation WBNavigationViewController


/**
 *  第一次使用这个类的时候会调用
 */
+ (void)initialize
{
    
    //1.设置导航栏主题
    [self setupNavBarTheme];
    
    //2.设置导航栏按钮主题
    
    [self setupBarButtonTheme];
}



/**
 *  1.设置导航栏主题
 */

+(void)setupNavBarTheme
{
    //1.设置导航栏主题
    //取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置背景
    if (!IOS7) {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    //设置标题属性
    NSMutableDictionary *textArrs = [NSMutableDictionary dictionary];
    textArrs[UITextAttributeTextColor] = [UIColor orangeColor];
    textArrs[UITextAttributeTextShadowOffset] =  [NSValue valueWithUIOffset:UIOffsetZero];
    textArrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:textArrs];
}

+(void)setupBarButtonTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置背景
    if (!IOS7) {
        [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    //设置普通文字属性
    NSMutableDictionary *textArrs = [NSMutableDictionary dictionary];
    textArrs[UITextAttributeTextColor] = IOS7 ?[UIColor orangeColor]:[UIColor grayColor];
    textArrs[UITextAttributeTextShadowOffset] =  [NSValue valueWithUIOffset:UIOffsetZero];
    textArrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:IOS7?16:12];
    [item setTitleTextAttributes:textArrs forState:UIControlStateNormal];
    
    //设置不可用文字属性
    NSMutableDictionary *disableArrs = [NSMutableDictionary dictionary];
    disableArrs[UITextAttributeTextColor] = [UIColor grayColor];
    disableArrs[UITextAttributeTextShadowOffset] =  [NSValue valueWithUIOffset:UIOffsetZero];
    disableArrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:IOS7?16:12];
   
    [item setTitleTextAttributes:disableArrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
         viewController.hidesBottomBarWhenPushed = YES;
    }
   
    [super pushViewController:viewController animated:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
