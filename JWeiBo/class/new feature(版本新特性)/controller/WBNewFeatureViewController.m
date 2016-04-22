//
//  WBNewFeatureViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-21.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBNewFeatureViewController.h"
//#import "WBTabBarViewController.h"
#import "WBLockViewController.h"
#define WBNewFeatureImageNum 3

@interface WBNewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation WBNewFeatureViewController

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
    //1.添加UIScrollView
    [self setupScrollView];
    
    //2.添加pageControl
    [self setupPageControl];
   
  
}

/**
 *  <#Description#>
 */
-(void)setupScrollView
{
    //1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    //2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    
    
    for (int index = 0; index<WBNewFeatureImageNum; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        UIImage *bagimage = [UIImage imageWithName:@"new_feature_background"];
        [imageView setBackgroundColor:[UIColor colorWithPatternImage:bagimage]];
        NSString *name = nil;
        if([UIScreen mainScreen].bounds.size.height==568)
        {
            name = [NSString stringWithFormat:@"new_feature_%d-568h@2x",index+1];
        }else{
            name = [NSString stringWithFormat:@"new_feature_%d",index+1];
        }
        imageView.image = [UIImage imageWithName:name];
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        
        if (index == WBNewFeatureImageNum - 1) {
            [self addLastImageView:imageView];
        }
    }
    
    //3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * WBNewFeatureImageNum, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
}

/**
 *  <#Description#>
 */
-(void)setupPageControl
{
    //1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = WBNewFeatureImageNum;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
    //2.设置原点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_pagecontrol_checked_point"]];
    pageControl.pageIndicatorTintColor =[UIColor colorWithPatternImage:[UIImage imageWithName:@"new_feature_pagecontrol_point"]];
    
    
}

/**
 *  只要UIScrollView滚动了，就会调用
 *
 *  @param scrollView
 */

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1.取出水平方向上滑动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //2.求出页码
    double pageDouble = offsetX/scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
    
}

-(void)addLastImageView:(UIImageView *)imageView
{
    //0.设置imageView 可以交互
    imageView.userInteractionEnabled = YES;
    //1.添加开始微博
    UIButton *button = [[UIButton alloc] init];
    
    //2.设置文字
    [button setTitle:@"设置手势密码" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    //3.设置frame
    CGFloat buttoncenterX = imageView.frame.size.width * 0.5;
    CGFloat buttoncenterY = imageView.frame.size.height * 0.8;
    button.center = CGPointMake(buttoncenterX, buttoncenterY);
    button.bounds = (CGRect){CGPointZero,button.currentBackgroundImage.size.width,button.currentBackgroundImage.size.height};
    [button addTarget:self action:@selector(startWB) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    
    //4.添加分享按钮checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    checkbox.selected = YES;
    
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imageView addSubview:checkbox];
    
    //checkbox.isSelected = YES;
    //[checkbox isSelected] = YES;
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.titleLabel.font  = [UIFont systemFontOfSize:13];
    CGFloat checkcenterX = buttoncenterX;
    CGFloat checkcenterY = imageView.frame.size.height * 0.7;
    checkbox.center = CGPointMake(checkcenterX, checkcenterY);
    checkbox.bounds = button.bounds;
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkbox];
    
}

-(void)startWB
{
    //切换窗口
    self.view.window.rootViewController = [[WBLockViewController alloc] init];
}

-(void)checkboxClick:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.isSelected;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
