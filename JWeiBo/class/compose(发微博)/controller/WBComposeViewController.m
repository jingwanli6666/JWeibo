//
//  WBComposeViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-10-10.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBComposeTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "WBComposeToolBar.h"
#import "WBComposePhotoView.h"
#import "WBEmotionKeyboard.h"
#import "WBEmotion.h"
#import "WBEmotionTool.h"

@interface WBComposeViewController ()<UITextViewDelegate,WBComposeToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) WBComposeTextView *textView;
@property (nonatomic,weak) WBComposeToolBar *toolBar;
@property (nonatomic,strong) WBComposePhotoView *photosview;
@property (nonatomic,strong) WBEmotionKeyboard *emotionKeyboard;
@property (nonatomic,assign) BOOL switchingKeyboard;
@end

@implementation WBComposeViewController

-(WBEmotionKeyboard *)emotionKeyboard
{
    if (_emotionKeyboard == nil) {
        self.emotionKeyboard = [[WBEmotionKeyboard alloc] init];
    }
    return  _emotionKeyboard;
}

#pragma mark -系统方法
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航栏内容
    [self setupNav];
    
    //添加输入框
    [self setupTextView];
    
    //添加工具条
    [self setupToolBar];
    
    [self setupComposePhotosview];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark -初始化

-(void)setupToolBar
{
    WBComposeToolBar *toolbar = [[WBComposeToolBar alloc] init];
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarH = 44;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(0, toolbarY, toolbarW, toolbarH);
    self.toolBar = toolbar;
    self.toolBar.delegate = self;
    
    
    [self.view addSubview:toolbar];
}

-(void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 200, 44)];
    titleView.textAlignment = NSTextAlignmentCenter;
    //自动换行
    titleView.numberOfLines = 0;
    NSString *name = [WBAccountTool getAccount].name;
    //WBLog(@"%@",name);
    NSString *str = [NSString stringWithFormat:@"发微博\n%@",name];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4,name.length)];
    
    titleView.attributedText = attrStr;
    
    //创建一个带有属性的字符串(比如颜色属性、字体属性等文字属性)
    
    self.navigationItem.titleView = titleView;
}

-(void)setupTextView
{
    //1.添加
    WBComposeTextView *textView = [[WBComposeTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    textView.placehold = @"分享新鲜事....";
    textView.placeholdColor = [UIColor redColor];
    [self.view addSubview:textView];
    self.textView = textView;
    textView.delegate = self;
    self.textView.alwaysBounceVertical = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //接受emotion图片按下通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionSelected:) name:WBSelectedEmotionNotification object:nil];
    
    //接受删除按钮通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteDidChange) name:@"deleteDidSelected" object:nil];
    
}



-(void)setupComposePhotosview
{
    WBComposePhotoView *photosview = [[WBComposePhotoView alloc] init];
    CGFloat photosviewX = 0;
    CGFloat photosviewY = 80;
    CGFloat photosviewW = self.view.frame.size.width;
    CGFloat photosviewH = self.view.frame.size.height;
    photosview.frame = CGRectMake(photosviewX, photosviewY, photosviewW, photosviewH);
    [self.textView addSubview:photosview];
    
    self.photosview = photosview;
}

#pragma mark -监听方法

-(void)deleteDidChange
{
    WBLog(@"删除按钮按下了");
    [self.textView deleteBackward];
}

-(void)emotionSelected:(NSNotification *)notification
{
    WBEmotion *emotion = notification.userInfo[WBSelectedEmotion];
    
    [self.textView insertEmotion:emotion];
  
}


/**
 *  键盘的frame发生改变时调用(显示、隐藏等)
 *
 *  @param notification
 */

-(void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.switchingKeyboard) return;
    
    NSDictionary *userinfo = notification.userInfo;
    //动画的持续时间
    double duration = [userinfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
    CGRect keyboardF = [userinfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        //  工具条的Y值 == 键盘的Y值 - 工具条的高度
        CGRect toolBarFrame = self.toolBar.frame;
        if (keyboardF.origin.y > self.view.frame.size.height) { //键盘的Y值已经远远超过了控制器view的高度
            toolBarFrame.origin.y = self.view.frame.size.height - self.toolBar.frame.size.height;
        }else{
            toolBarFrame.origin.y = keyboardF.origin.y - self.toolBar.frame.size.height;
        }
        self.toolBar.frame = toolBarFrame;
    }];
}

-(void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}


-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send
{
    if (self.photosview.photos.count) {
        [self sendWithImage];
    }else
    {
        [self sendWithoutImage];
    }
    
}

/**
 *  发送带图片的微博
 */
-(void)sendWithImage
{
    WBAccount *account = [WBAccountTool getAccount];
    //1请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] =account.access_token;
    params[@"status"] = self.textView.text;
    //3.发送请求

    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photosview.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:data name:@"pic" fileName:@"te.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
   
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    //4.dismiss
    [self dismissViewControllerAnimated:YES completion:nil];

}

/**
 *  发送不带图片的微博
 */
-(void)sendWithoutImage
{
    WBAccount *account = [WBAccountTool getAccount];
    //1请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] =account.access_token;
    params[@"status"] = self.textView.fullText;
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    //4.dismiss
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark - 代理方法

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)composeWithBar:(WBComposeToolBar *)toolbar didClickbtn:(HWComposeToolbarButtonType)type
{
    switch (type) {
        case HWComposeToolbarButtonTypeCamera:// 拍照
            [self openCamera];
            break;
        case HWComposeToolbarButtonTypePicture://相册
            [self openAlbum];
            break;
        case HWComposeToolbarButtonTypeMention://@
            break;
        case HWComposeToolbarButtonTypeTrend: //#
            break;
        case HWComposeToolbarButtonTypeEmotion: //表情、键盘
            [self switchKeyboard];
            break;
       
    }
 
}

-(void)switchKeyboard
{
    if (self.textView.inputView == nil) { //为系统自带键盘
        WBEmotionKeyboard *emotionKeyboard = [[WBEmotionKeyboard alloc] init];
        //CGSize emotionKeyboardSize = CGSizeMake(self.view.frame.size.width, 216);
        emotionKeyboard.frame = CGRectMake(0, 0, self.view.frame.size.width, 216);
        self.textView.inputView = emotionKeyboard;
        
        //切换为键盘图片
        self.toolBar.showKeyboard = YES;
    }else{  //切换为系统自带的键盘
        self.textView.inputView = nil;
        //切换为emotion图片
        self.toolBar.showKeyboard = NO;
    }
    self.switchingKeyboard = YES;
    //退出键盘
    [self.textView endEditing:YES];
    
     self.switchingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
    });
}

/**
 *  从UIImagePickerController选择完照片后就调用
 *
 *  @param picker <#picker description#>
 *  @param info   <#info description#>
 */

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosview addPhoto:image];
}

#pragma mark - 其他方法
-(void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

-(void)openAlbum
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
        
}




@end
