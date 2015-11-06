//
//  UIBarButtonItem+JWL.h
//  JWeiBo
//
//  Created by bcc_cae on 15-9-18.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JWL)

-(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
