//
//  PayUUIPaymentUIWebViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUIPaymentUIWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "PayUHeader.h"

@interface PayUUIPaymentUIWebViewController ()
@property WebViewJavascriptBridge* PayU;
//@property (strong, nonatomic) CBConnection *CBC;

@end

@implementation PayUUIPaymentUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.paymentWebView.delegate = self;
    
//    _CBC = [[CBConnection alloc]init:self.view webView:self.paymentWebView];
//    _CBC.isWKWebView = NO;
//    _CBC.cbServerID = 0;
//    // in case if you do not have activity indicator in your App call payUActivityIndicator
////    [_CBC payUActivityIndicator];
//    
//    [_CBC initialSetup];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    
    _PayU = [WebViewJavascriptBridge bridgeForWebView:_paymentWebView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback)
             
             {
                 NSLog(@"ObjC received message from JS: %@", data);
                 if(data)
                 {
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"passData" object:[NSMutableData dataWithData:data ]];
                     responseCallback(@"Response for message from ObjC");
                 }
                 
             }];
    
    
    
    
    [self.paymentWebView loadRequest:self.paymentRequest];
    [self.activityIndicator startAnimating];
    [self.activityIndicator setHidesWhenStopped:YES];
}

#pragma UIWebView delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.activityIndicator startAnimating];
//    [_CBC payUwebView:webView shouldStartLoadWithRequest:request];
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
    NSLog(@"webViewDidStartLoad URL----->%@",webView.request.URL);
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
//    [_CBC payUwebViewDidFinishLoad:webView];
    NSLog(@"webViewDidFinishLoad URL----->%@",webView.request.URL);
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    NSLog(@"webViewDidfailLoad URL----->%@",webView.request.URL);
    [self.activityIndicator stopAnimating];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
