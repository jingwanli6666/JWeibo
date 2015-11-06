//
//  WBEmotionPageView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-19.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBEmotionPageView.h"
#import "WBEmotion.h"
#import "NSString+Emoji.h"
#import "WBEmotionPopView.h"
#import "WBEmotionButton.h"
#import "WBEmotionTool.h"

@interface WBEmotionPageView()

/** 点击表情后弹出后的放大镜*/
@property (nonatomic,strong) WBEmotionPopView *popView;

@property (nonatomic,weak) UIButton *deleteBtn;

@end

@implementation WBEmotionPageView

-(WBEmotionPopView *)popView
{
    if (!_popView) {
        _popView = [WBEmotionPopView popView];
    }
    return _popView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //1.设置背景颜色
        self.backgroundColor = [UIColor whiteColor];
        
        //2.添加删除按钮
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn setImage:[UIImage imageWithName:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageWithName:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.userInteractionEnabled = YES;
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
        //3.添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
        
    }
    return self;
}

/**
 *  根据手指位置所在的表情按钮
 *
 *  @param location <#location description#>
 *
 *  @return <#return value description#>
 */

-(WBEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotionPicture.count;
    
    for (int i=0; i<count; i++) {
        WBEmotionButton *btn = self.subviews[i+1];
        if (CGRectContainsPoint(btn.frame,location)) {
            //已经找到手指所在的表情，就没必要再往下遍历
            return btn;
        }
    }
    return nil;
}

/**
 * 处理长按手势
 *
 *  @param recognizer <#recognizer description#>
 */
-(void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    //获得手指所在的位置、所在的表情按钮
    WBEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            //移除popView
            [self.popView removeFromSuperview];
            //如果手指还在表情按钮上
            if (btn) {
                //发出通知
               [self notification:btn];
            }
            break;
        case UIGestureRecognizerStateBegan: //手势开始
        case UIGestureRecognizerStateChanged:{ //手势改变
            [self.popView showFrom:btn];
             break;
        }
           
    }
}

-(void)deleteClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteDidSelected" object:nil];
}

-(void)setEmotionPicture:(NSArray *)emotionPicture
{
    _emotionPicture = emotionPicture;
   
    for (int  i=0; i<emotionPicture.count; i++) {
        WBEmotionButton *btn = [[WBEmotionButton alloc] init];
        // btn.backgroundColor = WBRandomColor;
        btn.emotion = emotionPicture[i];
                       
        [self addSubview:btn];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat EmotionBoarding = 10.0;
    CGFloat EmotionW = (self.frame.size.width - 2*EmotionBoarding)/7;
    CGFloat EmotionH = (self.frame.size.height - EmotionBoarding)/3;
    for (int i=0; i<self.emotionPicture.count; i++) {
        CGFloat EmotionX = (i % 7)*EmotionW + EmotionBoarding;
        CGFloat EmotionY = (i /7)  * EmotionH +EmotionBoarding;
        UIButton *btn = self.subviews[i+1];
        btn.frame = CGRectMake(EmotionX, EmotionY, EmotionW, EmotionH);
    }
    
    CGFloat deleteBtnW = EmotionW;
    CGFloat deleteBtnH = EmotionH;
    CGFloat deleteBtnX = self.frame.size.width - EmotionBoarding - EmotionW;
    CGFloat deleteBtnY = self.frame.size.height - EmotionH;
    self.deleteBtn.frame = CGRectMake(deleteBtnX, deleteBtnY, deleteBtnW, deleteBtnH);
    
}

-(void)clickBtn:(WBEmotionButton *)btn
{
    self.popView.emotion = btn.emotion;
    //取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    
    //计算出被点击的按钮在window中的frame
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    //WBLog(@"%@",NSStringFromCGRect(btnFrame));
    
    CGFloat popViewY = CGRectGetMidY(btnFrame) - self.popView.frame.size.height * 0.5;
    CGFloat popViewX = CGRectGetMidX(btnFrame);
    self.popView.center = CGPointMake(popViewX, popViewY);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });

    //发出通知
    [self notification:btn];
}

-(void)notification:(WBEmotionButton *)btn
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[WBSelectedEmotion] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:WBSelectedEmotionNotification object:nil userInfo:userInfo];
    [WBEmotionTool addRecentEmotion:btn.emotion];
}

@end
