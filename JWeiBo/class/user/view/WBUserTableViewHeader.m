//
//  WBUserTableViewHeader.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/1.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBUserTableViewHeader.h"

@implementation WBUserTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    WBUserTableViewHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"WBUserTableViewHeader" owner:self options:nil] lastObject];
    if (frame.size.width != 0) {
        header.frame = frame;
        WBLog(@"%@",header.frame);
    }
    return header;
}

@end
