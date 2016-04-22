//
//  WBBasicViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/8.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBBasicViewController.h"

@implementation WBBasicViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    
     [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:5]} forState:UIControlStateNormal];
}

@end
