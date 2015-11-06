//
//  WBEmotionTabBar.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-14.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBEmotionTabBar.h"
#import "WBEmotionBarBarButton.h"

@interface WBEmotionTabBar()

@property (nonatomic,weak) WBEmotionBarBarButton *selectedBtn;

@end

@implementation WBEmotionTabBar

#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setupBtn:@"最近" ButtonType:WBEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" ButtonType:WBEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"emoji" ButtonType:WBEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" ButtonType:WBEmotionTabBarButtonTypeWave];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width/count;
    CGFloat btnH = 37;
    
    for ( int i=0; i<count; i++) {
        CGFloat btnX = i * btnW;
        WBEmotionBarBarButton *btn = self.subviews[i];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

-(void)setDelegate:(id<WBEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    //选中“默认”按钮
    [self clickBtn:(WBEmotionBarBarButton *)[self viewWithTag:WBEmotionTabBarButtonTypeDefault]];
}

#pragma mark -自定义方法
-(WBEmotionBarBarButton *)setupBtn:(NSString *)title ButtonType:(WBEmotionTabBarButtonType)ButtonType
{
    WBEmotionBarBarButton *btn = [[WBEmotionBarBarButton alloc] init];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.tag = ButtonType;
    [self addSubview:btn];
    
    if (self.subviews.count == 1) {
        [btn setBackgroundImage:[UIImage imageWithName:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
         [btn setBackgroundImage:[UIImage imageWithName:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    }else if(self.subviews.count == 4){
        [btn setBackgroundImage:[UIImage imageWithName:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithName:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }else{
        [btn setBackgroundImage:[UIImage imageWithName:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithName:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return btn;
}



-(void)clickBtn:(WBEmotionBarBarButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(clickEmotionTabbar:DidSelectBtn:)]) {
        [self.delegate clickEmotionTabbar:self DidSelectBtn:btn.tag];
    }
   
}

@end
