//
//  WBComposeToolBar.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-12.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBComposeToolBar.h"

@interface WBComposeToolBar()

@property (nonatomic,weak) UIButton *emotionBtn;

@end

@implementation WBComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
        [self setupBtn:@"compose_camerabutton_background" highImagename:@"compose_camerabutton_background_highlighted" type:HWComposeToolbarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" highImagename:@"compose_toolbar_picture_highlighted" type:HWComposeToolbarButtonTypePicture];
         [self setupBtn:@"compose_mentionbutton_background" highImagename:@"compose_mentionbutton_background_highlighted" type:HWComposeToolbarButtonTypeMention];
         [self setupBtn:@"compose_trendbutton_background" highImagename:@"compose_trendbutton_background_highlighted" type:HWComposeToolbarButtonTypeTrend];
        self.emotionBtn = [self setupBtn:@"compose_emoticonbutton_background" highImagename:@"compose_emoticonbutton_background_highlighted" type:HWComposeToolbarButtonTypeEmotion];
    }
    return self;
}

-(void)setShowKeyboard:(BOOL)showKeyboard
{
    _showKeyboard = showKeyboard;
    
    if (self.showKeyboard) {
        [self.emotionBtn setImage:[UIImage imageWithName:@"message_keyboard_background"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageWithName:@"message_keyboard_background_highlighted"] forState:UIControlStateHighlighted];
    }else{
        [self.emotionBtn setImage:[UIImage imageWithName:@"message_emotion_background"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageWithName:@"message_emotion_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

/**
 *  设置按钮
 *
 *  @param imagename     <#imagename description#>
 *  @param highImagename <#highImagename description#>
 *  @param type          <#type description#>
 *
 *  @return <#return value description#>
 */

-(UIButton *)setupBtn:(NSString *)imagename highImagename:(NSString *)highImagename type:(HWComposeToolbarButtonType)type
{
    UIButton  *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:imagename] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:highImagename] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    return  btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger subViewCount = self.subviews.count;
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width / subViewCount ;
    CGFloat btnH = 44;
    for ( int i =0; i<subViewCount; i++) {
        CGFloat btnX = i * btnW;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

-(void)btnclick:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(composeWithBar:didClickbtn:)]) {
        [self.delegate composeWithBar:self didClickbtn:btn.tag];
    }
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
