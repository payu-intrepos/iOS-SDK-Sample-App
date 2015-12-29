//
//  CBConnection.h
//  PayUTestApp
//
//  Created by Umang Arya on 20/07/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBCustomActivityIndicator.h"
#import "CBConnectionHandler.h"
#import "CBAllPaymentOption.h"

@protocol PayUCBWebViewResponseDelegate <NSObject>

-(void)PayUSuccessResponse:(id)response;
-(void)PayUFailureResponse:(id)response;
-(void)PayUConnectionError:(id)notification;

@end

@interface CBConnection : NSObject


@property (nonatomic, assign) BOOL isWKWebView;
@property (nonatomic, copy) NSString *cbServerID;
@property (nonatomic, copy) NSString *analyticsServerID;
@property (nonatomic, copy) NSString *txnID;
@property (nonatomic, copy) NSString *merchantKey;
@property (weak, nonatomic) id <PayUCBWebViewResponseDelegate> cbWebViewResponseDelegate;
@property (nonatomic, assign) BOOL isAutoOTPSelect;
//@property (nonatomic, assign) BOOL isAutoApproveClick;

- (instancetype)init:(UIView *)view webView:(UIWebView *) webView;
- (void)payUActivityIndicator;
- (void)initialSetup;
- (void)payUwebView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request;
- (void)payUwebView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
- (void)payUwebViewDidFinishLoad:(UIWebView *)webView;



@end
