//
//  WBComposeToolBar.h
//  JWeiBo
//
//  Created by bcc_cae on 15-10-12.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HWComposeToolbarButtonTypeCamera, //拍照
    HWComposeToolbarButtonTypePicture, //相册
    HWComposeToolbarButtonTypeMention, //@
    HWComposeToolbarButtonTypeTrend,   //#
    HWComposeToolbarButtonTypeEmotion  //表情
}HWComposeToolbarButtonType;
@class WBComposeToolBar;

@protocol WBComposeToolBarDelegate <NSObject>

@optional
-(void)composeWithBar:(WBComposeToolBar *)toolbar didClickbtn:(HWComposeToolbarButtonType)type;
@end

@interface WBComposeToolBar : UIView

@property (nonatomic,weak) id<WBComposeToolBarDelegate> delegate;

@property (nonatomic,assign) BOOL showKeyboard;

@end
