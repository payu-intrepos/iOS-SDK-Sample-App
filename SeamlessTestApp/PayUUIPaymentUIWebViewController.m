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
//#import "PayU_CB_SDK.h"

@interface PayUUIPaymentUIWebViewController ()
@property WebViewJavascriptBridge* PayU;
@property (nonatomic,strong) UIAlertView *alertView;

//@property (strong, nonatomic) CBConnection *CBC;

@end

@implementation PayUUIPaymentUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.paymentWebView.delegate = self;
    
//   _CBC = [[CBConnection alloc]init:self.view webView:self.paymentWebView];
//    _CBC.isWKWebView = NO;
//    _CBC.cbServerID = CB_ENVIRONMENT_SDKTEST;
//    _CBC.analyticsServerID = CB_ENVIRONMENT_MOBILETEST;
//    _CBC.txnID = self.txnID;
//    _CBC.merchantKey = self.merchantKey;
//    // in case if you do not have activity indicator in your App call payUActivityIndicator
//   [_CBC payUActivityIndicator];
//    [_CBC initialSetup];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [_CBC logTxnTerminateEvent];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    
    _PayU = [WebViewJavascriptBridge bridgeForWebView:_paymentWebView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback)
             
             {
                 NSLog(@"ObjC received message from JS: %@", data);
                 if(data)
                 {
                     NSString *failure = @"status=failure";
                     NSString *success = @"status=success";
                     
//                     if ([data rangeOfString:failure].location != NSNotFound) {
//                         NSLog(@"Transaction Failure");
//                         [_CBC transactionStatus:NO];
//                     }
//                     else if ([data rangeOfString:success].location != NSNotFound) {
//                         NSLog(@"Transaction Success");
//                         [_CBC transactionStatus:YES];
//                     }
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
//    [_CBC payUwebView:webView didFailLoadWithError:error];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Back Button Handling

-(BOOL) navigationShouldPopOnBackButton
{
    self.alertView = [[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Do you want to cancel this transaction?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] ;
    [self.alertView show];
    return NO;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1) {
        [self.navigationController popToRootViewControllerAnimated:true];
    }
}
@end
