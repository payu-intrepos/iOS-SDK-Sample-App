//
//  PayUUIPaymentUIWebViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUIPaymentUIWebViewController.h"
#import "PayUHeader.h"
#import "PayUUIConstants.h"
#import "PayU_CB_SDK.h"

@interface PayUUIPaymentUIWebViewController () <PayUCBWebViewResponseDelegate>
@property(strong, nonatomic) PayUWebViewResponse *webViewResponse;
@property (strong, nonatomic) CBConnection *CBC;
@property (nonatomic,strong) UIAlertView *alertView;
@property BOOL showActivityIndicator;

@end

@implementation PayUUIPaymentUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showActivityIndicator = YES;
    [self.activityIndicator setHidesWhenStopped:YES];
    
    self.paymentWebView.delegate = self;
    //    [self configurePayUResponse];
    [self configurCB];
    if (!self.showActivityIndicator) {
        [self.activityIndicator setHidden:true];
    }
    [self.paymentWebView loadRequest:self.paymentRequest];
}

-(void)configurePayUResponse{
    self.webViewResponse = [PayUWebViewResponse new];
    self.webViewResponse.delegate = self;
}

-(void)configurCB{
    self.showActivityIndicator = NO;
    self.CBC = [[CBConnection alloc] init:self.view webView:self.paymentWebView];
    self.CBC.isWKWebView = NO;
    self.CBC.cbServerID = CB_ENVIRONMENT_PRODUCTION;
    self.CBC.analyticsServerID = CB_ENVIRONMENT_PRODUCTION;
    self.CBC.merchantKey = self.paymentParam.key;
    self.CBC.txnID = self.paymentParam.transactionID;
    self.CBC.isAutoOTPSelect = YES;
    self.CBC.isMagicRetry = YES;
    self.CBC.cbWebViewResponseDelegate = self;
    [self.CBC payUActivityIndicator];
    [self.CBC initialSetup];
    
    if (self.CBC == nil) {
        [self configurePayUResponse];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    
    //    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"html"];
    //    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    //    [self.paymentWebView loadHTMLString:htmlString baseURL:nil];
    
}

#pragma UIWebView delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self startActivityIndicator];
    NSLog(@"shouldStartLoadWithRequest %@",[[request URL] absoluteString]);
    [self.CBC payUwebView:webView shouldStartLoadWithRequest:request];
    [self.webViewResponse initialSetupForWebView:webView];
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self startActivityIndicator];
    NSLog(@"webViewDidStartLoad URL----->%@",webView.request.URL);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self stopActivityIndicator];
    NSLog(@"webViewDidFinishLoad URL----->%@",webView.request.URL);
    [self.CBC payUwebViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    NSLog(@"webViewDidfailLoad URL----->%@",webView.request.URL);
    NSLog(@"%@",error.localizedDescription);
    [self stopActivityIndicator];
    [self.CBC payUwebView:webView didFailLoadWithError:error];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    NSLog(@"Inside Dealloc of webview");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:true];
    NSLog(@"Inside viewWillDisappear");
}

-(void)PayUSuccessResponse:(id)response{
    NSLog(@"%@",response);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"paymentResponse" object:[NSMutableData dataWithData:response ]];
    
}
-(void)PayUFailureResponse:(id)response{
    NSLog(@"%@",response);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"paymentResponse" object:[NSMutableData dataWithData:response ]];
}

-(void) PayUConnectionError:(NSDictionary *)notification
{
    //    PAYUALERT([notification objectForKey:IS_MR_ENABLED], [notification objectForKey:IS_MR_WINDOW_SHOWN]);
}

-(void)startActivityIndicator{
    if (self.showActivityIndicator) {
        [self.activityIndicator startAnimating];
    }
}

-(void)stopActivityIndicator{
    [self.activityIndicator stopAnimating];
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