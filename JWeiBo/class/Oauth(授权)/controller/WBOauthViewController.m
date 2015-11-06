//
//  WBOauthViewController.m
//  JWeiBo
//
//  Created by bcc_cae on 15-9-22.
//  Copyright (c) 2015年 bcc_cae. All rights reserved.
//

#import "WBOauthViewController.h"
//#import "WBTabBarViewController.h"
//#import "WBNewFeatureViewController.h"
#import "AFNetworking.h"
#import "WBAccount.h"
#import "MBProgressHUD+MJ.h"
#import "WBTool.h"
#import "WBAccountTool.h"

@interface WBOauthViewController () <UIWebViewDelegate>

@end

@implementation WBOauthViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //1.添加webView
    UIWebView *webview = [[UIWebView alloc] init];
    webview.frame = self.view.bounds;
    webview.delegate = self;
    [self.view addSubview:webview];
    
    //2.加载授权页面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1231640494&response_type=code&redirect_uri=https://api.weibo.com/oauth2/default.html"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //[self.webview setDelegate:self];
    [webview loadRequest:request];
}

/**
 *  webView开始发送请求的时候就会调用
 *
 *  @param webView <#webView description#>
 */
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //显示提示框
    [MBProgressHUD showMessage:@"正在加载中,请耐心等待..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前都会先调用这个方法，询问代理可不可以加载这个页面
 *
 *  @param webView        <#webView description#>
 *  @param request        <#request description#>
 *  @param navigationType <#navigationType description#>
 *
 *  @return YES:可以加载页面，No:不可以加载
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.请求的URL路径
    NSString *urlStr = request.URL.absoluteString;
    
    //2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        //NSLog(@"获得----%@",code);
        
        [self accessTokenWithCode:code];
        return NO;
        
    }
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code
{
    //1.AFNetworing
    //2.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    //
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"1231640494";
    params[@"client_secret"] = @"194830357ce9b9e3cdc569b817292eb0";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"]=@"https://api.weibo.com/oauth2/default.html";
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSString *accessToken = responseObject[@"access_token"];
        //先将字典转化为模型数据
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        //WBLog(@"%@",account);
        
        //5.存储模型数据
        [WBAccountTool setAccout:account];
               
        [WBTool chooseController];
        
        [MBProgressHUD hideHUD];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
//        WBLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
