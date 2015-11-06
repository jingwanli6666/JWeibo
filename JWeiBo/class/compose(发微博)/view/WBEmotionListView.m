//
//  WBEmotionListView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-14.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//
#define WBEmotionCount 20

#import "WBEmotionListView.h"
#import "WBEmotionPageView.h"
@interface WBEmotionListView () <UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pagecontrol;
@property (nonatomic,weak) UIScrollView *scrollview;
@end
@implementation WBEmotionListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIPageControl *pagecontrol = [[UIPageControl alloc] init];
        // 设置内部的圆点图片 kvo
        [pagecontrol setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pagecontrol setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pagecontrol];
        self.pagecontrol = pagecontrol;
        
        UIScrollView *scrollview = [[UIScrollView alloc] init];
        scrollview.delegate = self;
        scrollview.pagingEnabled = YES;
        scrollview.showsVerticalScrollIndicator = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollview];
        self.scrollview = scrollview;
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    //1.设置页数
    self.pagecontrol.numberOfPages = (emotions.count + WBEmotionCount - 1)/WBEmotionCount;
    
    //2.创建用来显示每一页表情的控件
    for(int i=0;i<self.pagecontrol.numberOfPages;i++)
    {
        WBEmotionPageView *pageView = [[WBEmotionPageView alloc] init];
        //计算这一页的表情范围
        NSRange range;
        range.location = i * WBEmotionCount;
        //left：剩下的表情个数
        NSUInteger left = emotions.count - range.location;
        if (left >= WBEmotionCount) {
            range.length = WBEmotionCount;
        }else{
            range.length = left;
        }
        
        pageView.emotionPicture =[emotions subarrayWithRange:range];
        //pageView.backgroundColor = WBRandomColor;
        [self.scrollview addSubview:pageView];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.pageControl
    CGFloat pagecontrolX = 0;
    CGFloat pagecontrolH = 35;
    CGFloat pagecontrolY = self.frame.size.height - pagecontrolH;
    CGFloat pagecontrolW = self.frame.size.width;
    _pagecontrol.frame = CGRectMake(pagecontrolX, pagecontrolY, pagecontrolW, pagecontrolH);
    
    //2.scrollView
    CGFloat scrollviewX = 0;
    CGFloat scrollviewY = 0;
    CGFloat scrollviewH = pagecontrolY;
    CGFloat scrollviewW = pagecontrolW;
    _scrollview.frame = CGRectMake(scrollviewX, scrollviewY, scrollviewW, scrollviewH);
    
    //3.设置scrollView内部每一页的尺寸
    CGFloat pageViewY = 0;
    CGFloat pageViewW = self.scrollview.frame.size.width;
    CGFloat pageViewH = self.scrollview.frame.size.height;
    NSUInteger count = self.scrollview.subviews.count;
    for(int i=0;i<count;i++)
    {
        WBEmotionPageView *pageView = self.scrollview.subviews[i];
        CGFloat pageViewX = i * pagecontrolW ;
        pageView.frame = CGRectMake(pageViewX, pageViewY, pageViewW, pageViewH);
    }
    
    //4.设置scrollView的contentSize
    self.scrollview.contentSize = CGSizeMake(count * pageViewW, 0);
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pagecontrol.currentPage = (int)(pageNo + 0.5);
}

@end
