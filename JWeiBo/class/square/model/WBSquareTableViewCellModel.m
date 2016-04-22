//
//  WBSquareTableViewCellModel.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/5.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBSquareTableViewCellModel.h"

@implementation WBSquareTableViewCellModel

+(instancetype)modelWithTitle:(NSString *)title iconImageName:(NSString *)iconImageName destinationControllerClass:(Class)destinationControllerClass
{
    WBSquareTableViewCellModel *model = [[WBSquareTableViewCellModel alloc] init];
    model.title = title;
    model.iconImageName = iconImageName;
    model.destinationControllerClass = destinationControllerClass;
    
    return model;
}
@end
