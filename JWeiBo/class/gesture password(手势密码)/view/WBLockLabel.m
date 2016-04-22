//
//  WBLockLabel.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/14.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBLockLabel.h"
#import "CoreLockConst.h"
#import "CALayer+Animation.h"

@implementation WBLockLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //视图初始化
        [self viewPrepare];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图初始化
        [self viewPrepare];
    }
    
    return self;
}


/*
 *  视图初始化
 */
-(void)viewPrepare{
    
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textAlignment  = NSTextAlignmentCenter;
}


/*
 *  普通提示信息
 */
-(void)showNormalMsg:(NSString *)msg{
    
    self.text = msg;
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = CoreLockCircleLineNormalColor;
}



/*
 *  警示信息
 */
-(void)showWarnMsg:(NSString *)msg{
    
    self.text = msg;
    self.textAlignment = NSTextAlignmentCenter;

    self.textColor = CoreLockWarnColor;
    
    //添加一个shake动画
    [self.layer shake];
}


@end
