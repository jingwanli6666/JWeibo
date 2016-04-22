//
//  WBUserTableViewCellModel.h
//  JWeiBo
//
//  Created by bcc_cae on 16/4/1.
//  Copyright © 2016年 bcc_cae. All rights reserved.
//

#import "WBBasicTableViewCell.h"

@interface WBUserTableViewCellModel : WBBasicTableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconImageName;
@property (nonatomic, copy) Class destinationControllerClass;

+(instancetype)modelWithTitle:(NSString *)title iconImageName:(NSString *)iconImageName destinationControllerClass:(Class)destinationController;
@end
