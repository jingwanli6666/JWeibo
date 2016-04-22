//
//  WBTabBarViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBTabBarViewController.h"
#import "WBhomepageTableViewController.h"
//#import "WBmessageTableViewController.h"
#import "WBServiceViewController.h"
#import "WBsquareTableViewController.h"
#import "WBuserTableViewController.h"
#import "UIImage+Jimg.h"
#import "WBTabbar.h"
#import "WBNavigationViewController.h"
#import "WBComposeViewController.h"

@interface WBTabBarViewController () <WbTabBarDelegate>
//自定义的tabbar
@property (nonatomic,weak) WBTabbar *wbtabbar;
@end

@implementation WBTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //初始化tabbar
    [self setupTabbar];
    
    [self setUpAllChildViewController];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
  
}

//初始化tabbar
- (void)setupTabbar
{
    WBTabbar *wbtabbar = [[WBTabbar alloc] init];
    //wbtabbar.backgroundColor = [UIColor redColor];
    wbtabbar.frame = self.tabBar.bounds;
    
    wbtabbar.delegate = self;
    [self.tabBar addSubview:wbtabbar];
    self.wbtabbar = wbtabbar;
}

/***
 监听Tabbar按钮的改变
 
 */
-(void)tabBar:(WBTabbar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
//    NSLog(@"---%d---%d",from,to);
    self.selectedIndex = to;
}

//删除初始化的控件
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化所有子控制器

-(void)setUpAllChildViewController
{
    //首页
    WBhomepageTableViewController *home = [[WBhomepageTableViewController alloc] init];
    //home.tabBarItem.badgeValue = @"10";
    [self setUpChildViewControlller:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
   
    
    WBServiceViewController *service = [[WBServiceViewController alloc] init];
    //message.tabBarItem.badgeValue = @"890";
    [self setUpChildViewControlller:service title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    WBsquareTableViewController *square = [[WBsquareTableViewController alloc] init];
    //square.tabBarItem.badgeValue = @"8";
    [self setUpChildViewControlller:square title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    
    WBuserTableViewController *user = [[WBuserTableViewController alloc] init];
    //user.tabBarItem.badgeValue = @"6";
    [self setUpChildViewControlller:user title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
}

/**
 * 初始化子控制器
 */
-(void)setUpChildViewControlller:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    //选中图片的渲染方法
    if (IOS7) {
        
        childVc.tabBarItem.selectedImage = [[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
    childVc.tabBarItem.selectedImage = [UIImage imageWithName:selectedImageName] ;
    }
    
    WBNavigationViewController *nav = [[WBNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    //添加tabbar内部的按钮
    [self.wbtabbar addTabBarButtonWithItem:childVc.tabBarItem];
    
}

#pragma mark - WBTabBarDelegate代理方法
-(void)tabBarDidClickPlusButton:(WBTabbar *)tabBar
{
    WBComposeViewController *compose = [[WBComposeViewController alloc] init];
    
    WBNavigationViewController *nav = [[WBNavigationViewController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}



@end
