//
//  PayUUIPaymentUIWebViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUIPaymentUIWebViewController.h"

@interface PayUUIPaymentUIWebViewController ()

@end

@implementation PayUUIPaymentUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.paymentWebView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    [self.paymentWebView loadRequest:self.paymentRequest];
    [self.activityIndicator startAnimating];
    [self.activityIndicator setHidesWhenStopped:YES];
}

#pragma UIWebView delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.activityIndicator startAnimating];
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
    NSLog(@"webViewDidStartLoad URL----->%@",webView.request.URL);
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
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
