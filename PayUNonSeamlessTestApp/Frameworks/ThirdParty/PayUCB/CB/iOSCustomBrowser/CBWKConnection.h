//
//  CBWKConnection.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Sharad Goyal on 25/09/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUCBLoader.h"
#import "CBConnectionHandler.h"
#import "PUCBAllPaymentOption.h"
#import <WebKit/WebKit.h>

/*!
 * This protocol defines methods to get callback for transaction status.
 */
@protocol PayUCBWebViewResponseDelegate <NSObject>

/*!
 * This method gets called when transaction is successfull. It logs txn_success event.
 * @param [response]            [id type]
 */
- (void)PayUSuccessResponse:(id)response;

/*!
 * This method gets called when transaction fails. It logs txn_fail event.
 * @param [response]            [id type]
 */
- (void)PayUFailureResponse:(id)response;

/*!
 * This method gets called in case of network error
 * @param [notification]            [NSDictionary type]
 */
- (void)PayUConnectionError:(NSDictionary *)notification;

@end

@interface CBWKConnection : NSObject

@property (nonatomic, copy) NSString *postData;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *txnID;

@property (nonatomic,assign) BOOL isWKWebView;
@property (nonatomic,copy) NSString *cbServerID;
@property (nonatomic,copy) NSString *analyticsServerID;
@property (nonatomic,strong) UIViewController *wkVC;
@property (weak, nonatomic) id <PayUCBWebViewResponseDelegate> cbWebViewResponseDelegate;
@property (nonatomic,copy) NSString *merchantKey;

-(instancetype)init:(UIView *)view webView:(WKWebView *)webView;

-(void)payUActivityIndicator;
-(void) initialSetup;
- (void)logTxnTerminateEvent;

- (void)payUuserContentController:(WKUserContentController *)userContentController
          didReceiveScriptMessage:(WKScriptMessage *)message;
- (void)payUwebView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
- (void)payUwebView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;
- (void)payUwebView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error;
//- (void)payUwebView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
-(void)payUwebView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
- (void)payUwebView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error;

/*
 - (void)payUwebView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler;
 
 - (void)payUwebView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;
 
 - (void)payUwebView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *result))completionHandler;
 */

@end
