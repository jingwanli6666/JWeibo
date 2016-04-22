//
//  WBSquateTableViewHeaderItemModel.m
//  JWeiBo
//
//  Created by bcc_cae on 16/4/5.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBSquareTableViewHeaderItemModel.h"

@implementation WBSquareTableViewHeaderItemModel

+ (instancetype)modelWithTitle:(NSString *)title imageName:(NSString *)imageName destinationControllerClass:(Class)destinationControllerClass
{
    WBSquareTableViewHeaderItemModel *model = [[WBSquareTableViewHeaderItemModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    model.destinationControllerClass = destinationControllerClass;
    return model;
}

@end
