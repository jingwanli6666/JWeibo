//
//  WBCommonGroup.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-21.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBCommonItem;
@interface WBCommonGroup : NSObject
@property (nonatomic,copy) NSString *groupheader;
@property (nonatomic,copy) NSString *groupfooter;
@property (nonatomic,strong) NSArray *items;
@end
