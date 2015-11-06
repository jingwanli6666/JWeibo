//
//  WBComposeTextView.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-29.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBTextView.h"

@class WBEmotion;

@interface WBComposeTextView : WBTextView

-(void)insertEmotion:(WBEmotion *)emotion;

- (NSString *)fullText;

@end
