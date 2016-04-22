//
//  WBUserTableViewCellModel.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/1.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBUserTableViewCellModel.h"

@implementation WBUserTableViewCellModel

+(instancetype)modelWithTitle:(NSString *)title iconImageName:(NSString *)iconImageName destinationControllerClass:(Class)destinationControllerClass
{
    WBUserTableViewCellModel *model = [[WBUserTableViewCellModel alloc] init];
    model.title = title;
    model.iconImageName = iconImageName;
    model.destinationControllerClass = destinationControllerClass;
    
    return model;
}
@end
