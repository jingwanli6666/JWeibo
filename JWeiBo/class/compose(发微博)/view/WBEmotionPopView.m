//
//  WBEmotionPopView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-20.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBEmotionPopView.h"
#import "WBEmotionButton.h"

@interface WBEmotionPopView ()

@property (weak, nonatomic) IBOutlet WBEmotionButton *emotionButton;


@end

@implementation WBEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WBEmotionPopView" owner:nil options:nil] lastObject];
}

-(void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    
    self.emotionButton.emotion = emotion;
}

-(void)showFrom:(WBEmotionButton *)btn
{
    if (btn == nil) {
        return;
    }
    
    //给popView传递数据
    self.emotionButton.emotion = btn.emotion;
    
    //取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //计算出被点击的按钮在windows中的frame
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    //btnFrame.origin.y = CGRectGetMaxX(<#CGRect rect#>)
    
    CGFloat popViewCenterY = CGRectGetMidY(btnFrame) - self.frame.size.height*0.5;
    CGFloat popViewCenterX = CGRectGetMidX(btnFrame);
    self.center = CGPointMake(popViewCenterX, popViewCenterY);
    
}

@end
