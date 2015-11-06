//
//  UITextView+Extension.m
//  JWeiBo
//
//  Created by bcc_cae on 15-11-2.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

-(void)insertAttributedText:(NSAttributedString *)text
{
    [self insertAttributedText:text SettingBlcok:nil];
}

-(void)insertAttributedText:(NSAttributedString *)text SettingBlcok:(void (^)(NSMutableAttributedString *))SettingBlcok
{
    //拼接图片
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    //拼接之前的文字
    [attributedText appendAttributedString:self.attributedText];
    NSUInteger loc = self.selectedRange.location;
    //[attributedText insertAttributedString:text atIndex:loc];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    //调用外面传进来的代码
    if(SettingBlcok){
        SettingBlcok(attributedText);
    }
    self.attributedText = attributedText;
    
    //移动光标到表情后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}


@end
