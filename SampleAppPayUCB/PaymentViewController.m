//
//  PaymentViewController.m
//  SampleAppPayUCB
//  Created by Umang Arya on 23/07/15.
//  Copyright (c) 2015 Umang Arya. All rights reserved.
//

#import "PaymentViewController.h"
#import "PayU_CB_SDK.h"

@interface PaymentViewController () <UIWebViewDelegate>
@property (strong,nonatomic) CBConnection *CBC;
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _resultWebView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGoingInBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    _CBC = [[CBConnection alloc]init:self.view webView:_resultWebView];
    [_CBC InitialSetup];
}

-(void)viewWillAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_resultWebView loadRequest:_theRequest];
    });
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_CBC deallocHandler];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_CBC payUWebViewDidFinishLoad:webView];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (_CBC) {
        return [_CBC payUWebView:webView shouldStartLoadWithRequest:request];
    }
    else
        return true;
}

- (void) appGoingInBackground:(NSNotification *) notification
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
