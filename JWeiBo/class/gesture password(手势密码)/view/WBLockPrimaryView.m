//
//  WBLockPrimaryView.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/15.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBLockPrimaryView.h"
#import "WBLockView.h"
#import "WBLockLabel.h"

typedef void(^successBlockHandler)(WBLockPrimaryView *lockPrimaryView,NSString *pwd);

@interface WBLockPrimaryView()

//@property (nonatomic, copy) successBlockHandler successBlock;
@property (nonatomic,copy) void (^forgetPwdBlock)();
//@property (weak, nonatomic) IBOutlet UILabel *lockLabel;


@property (nonatomic,copy) NSString *msg;
//@property (weak, nonatomic) IBOutlet WBLockView *lockView;


@end

@implementation WBLockPrimaryView

+(instancetype)PrimaryView
{
    WBLockPrimaryView *primaryView = [[[NSBundle mainBundle] loadNibNamed:@"WBLockView" owner:self options:nil] lastObject];
    
    return primaryView;
        
}






@end
