//
//  WBTabbarbutton.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-16.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#define  WBTabBarButtonratio 0.6
//按钮的默认颜色
#define WBTarBarButtontitleColor  (IOS7 ? [UIColor blackColor]:[UIColor whiteColor])
#define WBTarBarButtontitleSelected (IOS7 ? WBColor(234,103,7):WBColor(240,139,0))

#import "WBTabbarbutton.h"
#import "WBBadgeButton.h"

@interface WBTabbarbutton()
//提醒数字
@property (nonatomic,weak) WBBadgeButton *badgeButton;

@end

@implementation WBTabbarbutton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [self setTitleColor: WBTarBarButtontitleColor forState:UIControlStateNormal];
        [self setTitleColor: WBTarBarButtontitleSelected forState:UIControlStateSelected];
        if (!IOS7) {
            [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        
        //添加一个提醒数字按钮
        WBBadgeButton  *badgeButton = [[WBBadgeButton alloc] init];
        
        
        //伸缩
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
       
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
  
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * WBTabBarButtonratio;
    return CGRectMake(0, 0, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * WBTabBarButtonratio;;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * (1.0-WBTabBarButtonratio);
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
   
    
}

-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"title"];
}


/**
 *  监听某个对象的属性改变了，就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 *  @param context <#context description#>
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    
    //设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    //设置数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
    //self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
