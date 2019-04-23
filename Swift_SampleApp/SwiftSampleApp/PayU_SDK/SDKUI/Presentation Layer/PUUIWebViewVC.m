//
//  PUUIWebViewVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 06/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUUIWebViewVC.h"
#import <PayUCustomBrowser/PayUCustomBrowser.h>
//#import "PayU_CB_SDK.h"

@interface PUUIWebViewVC () <PayUSDKWebViewResponseDelegate, PayUCBWebViewResponseDelegate>
{
    UIAlertView *backbtnAlertView;
    BOOL checkReachabilityByApp;
    
}
@property(strong, nonatomic) PayUWebViewResponse *webViewResponse;
@property (strong, nonatomic) CBConnection *CBC;

@end

@implementation PUUIWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self disableSwipeBack];
    [self initialSetup];
    [self startLoadingWebView];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dealloc {
    self.vwWebView.delegate = nil;
}
    
-(void)initialSetup{
    [self configureWebView];
    [self configureCB];
    [self configureBackButton];
}
    
    

-(void)configureBackButton{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(removeVCOnBackPress)];
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)configureWebView{
    self.vwWebView.delegate = self;
}

- (void)startLoadingWebView {
    if (self.htmlData) {
        [self.vwWebView loadHTMLString:_CBC.cbConfig.htmlData
                               baseURL:self.request.URL];
    } else {
        [self.vwWebView loadRequest:self.request];
    }
}

-(void)configureCB{
    _CBC = [[CBConnection alloc]init:self.view webView:_vwWebView];
    
    // Please provide the transaction ID and Key
    _CBC.txnID = self.paymentParam.transactionID;
    _CBC.merchantKey = self.paymentParam.key;
    _CBC.isAutoOTPSelect = NO;
    _CBC.cbWebViewResponseDelegate = self;
    _CBC.bankSimulatorType = self.bankSimulatorType;
    // To disable MagicRetry
    _CBC.isMagicRetry = YES; // by default it is YES i.e. Magic Retry is enabled
    _CBC.cbConfig.htmlData = self.htmlData;
    
    // It is optional to show PayU activity loader
    [_CBC payUActivityIndicator];
    [_CBC initialSetup];
    
    if (!_CBC) {
        [self configurePayUSDKResponse];
        checkReachabilityByApp = TRUE;
    }
}

-(void)disableSwipeBack{
    if (self.navigationController) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

-(void)configurePayUSDKResponse{
    self.webViewResponse = [PayUWebViewResponse new];
    self.webViewResponse.delegate = self;
}

#pragma WebView delegate method

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.webViewResponse initialSetupForWebView:webView];
    [_CBC payUwebView:webView shouldStartLoadWithRequest:request];
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_CBC payUwebViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (checkReachabilityByApp) {
        if(error.code == NSURLErrorNotConnectedToInternet) {
            [self noInternetConnection];
        }
    }
    [_CBC payUwebView:webView didFailLoadWithError:error];
}

-(void)noInternetConnection{
    PAYUALERT(@"Internet Connection Lost", @"It seems you are not connected to internet..");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - PayUSDKWebViewResponseDelegate Methods
-(void)PayUSuccessResponse:(id)response{
//    NSLog(@"%@",response);
//    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:[NSMutableData dataWithData:response ]];
    
}
-(void)PayUFailureResponse:(id)response{
//    NSLog(@"%@",response);
//    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:[NSMutableData dataWithData:response ]];
}

- (void)PayUSuccessResponse:(id)payUResponse SURLResponse:(id)surlResponse{
    NSError *serializationError;
    id payUResponseInJSON = [NSJSONSerialization JSONObjectWithData:[payUResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&serializationError];
    NSDictionary *responseDict = [NSDictionary dictionaryWithObjectsAndKeys:payUResponseInJSON,kPUUIPayUResponse, surlResponse, kPUUIMerchantResponse, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseDict];
}

- (void)PayUFailureResponse:(id)payUResponse FURLResponse:(id)furlResponse{
    NSError *serializationError;
    id payUResponseInJSON = [NSJSONSerialization JSONObjectWithData:[payUResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&serializationError];
    NSDictionary *responseDict = [NSDictionary dictionaryWithObjectsAndKeys:payUResponseInJSON,kPUUIPayUResponse, furlResponse, kPUUIMerchantResponse, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseDict];
}

#pragma mark - PayUCB Delegate Methods

-(void)PayUConnectionError:(NSDictionary *)notification{
    NSLog(@"Inside PayUConnection Error");
}

#pragma mark - Back Button Handling

-(void)removeVCOnBackPress
{
    backbtnAlertView = [[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Do you want to cancel this transaction?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    backbtnAlertView.tag = 502;
    [backbtnAlertView show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if((buttonIndex==1 && alertView.tag ==502 )) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

@end
