//
//  WBEmotionPopView.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-20.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBEmotion;
@class WBEmotionButton;

@interface WBEmotionPopView : UIButton

+ (instancetype)popView;

@property (nonatomic,strong) WBEmotion *emotion;

-(void)showFrom:(WBEmotionButton *)btn;

@end
