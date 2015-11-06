//
//  WBComposeTextView.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-29.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBComposeTextView.h"
#import "WBEmotion.h"
#import "WBEmotionAttachment.h"

@implementation WBComposeTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)insertEmotion:(WBEmotion *)emotion
{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    }else  if(emotion.png ){
        
        //加载图片
        
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = [UIImage imageNamed:emotion.png];
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        [self insertAttributedText:imageStr SettingBlcok:^(NSMutableAttributedString *attributedText) {
            //设置字体
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
       
    }
}

-(NSString *)fullText
{
    NSMutableString *fullText = [[NSMutableString alloc] init];
    
    //遍历所有的属性文字
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        //如果是图片表情
        WBEmotionAttachment *emotionAttachment =  attrs[@"NSAttachment"];
        
        if (emotionAttachment) {  //图片
            [fullText appendString:emotionAttachment.emotion.chs];
        }else{ //emoji、普通文字
            // 获得这个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
        
        }];
    return fullText;
}

@end
