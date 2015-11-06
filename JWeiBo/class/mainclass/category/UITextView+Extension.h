//
//  UITextView+Extension.h
//  JWeiBo
//
//  Created by bcc_cae on 15-11-2.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
-(void)insertAttributedText:(NSAttributedString *)text;
-(void)insertAttributedText:(NSAttributedString *)text SettingBlcok:(void (^)(NSMutableAttributedString*attributedText))SettingBlcok;
@end
