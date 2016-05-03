//
//  CBConnectionHandler.h
//  iOSCustomBrowser
//
//  Created by Suryakant Sharma on 20/04/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//
//   Version

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@import UIKit;
@import JavaScriptCore;

/*!
 * This protocol declares the methods which we get from JS callbacks.
 */
@protocol JSCallBackToObjC <JSExport>

/*!
 * This method is called from JS when bank name is resolved.
 * @param [bankName] [NSString type]
 */
- (void)bankFound:(NSString *)BankName;

/*!
 * This method is called from JS. It opens and closes the CB based on paymentOption param.
 * @param [paymentOption]                   [NSString type]
 * @param [otherPaymentOptipon]             [NSString type]
 * @see   [closeCBView]
 * @see   [logShowCBEvent]
 */
- (void)convertToNative:(NSString *)paymentOption :(NSString *)otherPaymentOptipon;

/*!
 * This method is called from JS. It calls "downloadBankSpecificJS" method if param "isShowCustomBrowser" is 1
 * @param [isShowCustomBrowser]     [NSInteger type]
 * @see   [downloadBankSpecificJS]
 */
- (void)showCustomBrowser:(NSInteger)isShowCustomBrowser;

/*!
 * This method is called from JS to reload the bank page.
 */
- (void)reInit;

/*!
 * This method is called from JS.
 * @param [strMagicRetryUrls]       [NSString type]
 * @see   [setMRUrlList - CBUtile]
 */
- (void)setMRData:(NSString *)strMagicRetryUrls;

/*!
 * This method is called from JS.
 * @param [response]                                    [id type]
 * @see   [payUTransactionStatusSuccess - CBConnection]
 */
- (void)onPayuSuccess:(id)response;

/*!
 * This method is called from JS.
 * @param [response]                                    [id type]
 * @see   [payUTransactionStatusFailure - CBConnection]
 */
- (void)onPayuFailure:(id)response;

@end

/*!
 * This protocol declares methods that gives callbacks to CBConnection and CBWKConnection.
 */
@protocol  CBConnectionHandlerDelegate <NSObject>

/*!
 * This method gives callback to CBConnection when bank name is detected.
 * @param [bankName]                        [NSString type]
 * @see   [bankNameFound - CBConnection]
 */
- (void)bankNameFound:(NSString *) bankName;

/*!
 * This method gives callback to CBConnection when transaction is success.
 * @param [response]                            [id type]
 * @see   [PayUSuccessResponse - CBConnection]
 */
- (void)PayUSuccessResponse:(id)response;

/*!
 * This method gives callback to CBConnection when transaction is fail.
 * @param [response]                            [id type]
 * @see   [PayUFailureResponse - CBConnection]
 */
- (void)PayUFailureResponse:(id)response;
@end

/*!
 * This class is used to run JS on WebView and to receive callbacks from JS. It is for both UIWebView and WKWebView.
 */
@interface CBConnectionHandler : NSObject<JSCallBackToObjC>

@property (nonatomic,strong) NSMutableDictionary *initializeJavascriptDict;
@property (nonatomic,strong) NSMutableDictionary *bankSpecificJavaScriptDict;
@property (nonatomic,weak)   UIView *resultView;
//@property (nonatomic,weak)   WKWebView *resultWebView;
@property (nonatomic,weak)   UIWebView *resultWebView;
@property (nonatomic,copy)   NSString *bankName;

@property (nonatomic,assign) BOOL isWKWebView;
@property (nonatomic, assign) BOOL isMagicRetry;
@property (nonatomic, assign) BOOL isAutoOTPSelect;
@property (nonatomic, assign) BOOL cbStatus;


@property (nonatomic,weak) id <CBConnectionHandlerDelegate> connectionHandlerDelegate;

/*!
 * This method is called from CBConnection/CBWKConnection to download initialJS.
 */
- (void)downloadInitializeJS;

/*!
 * This method is called from CBConnection/CBWKConnection to runInitializeJS on WebView.
 */
- (void)runIntializeJSOnWebView;

/*!
 * This method is called from CBConnection/CBWKConnection to runBankSpecificJS on WebView.
 */
- (void)runBankSpecificJSOnWebView;

/*!
 * This method is called from CB custom views to run JS on WebView when user clicks on CB controls. For example passsord,smsOTP etc.
 */
- (void)runJavaScript:(NSString *)js;

/*!
 * This method is called from CB custom views to show bank loader on CB during switching CB view.
 */
- (void)showBankLoaderView;

/*!
 * This method is used to show ApproveView.
 * @param [optionsDict]     [NSDictionary type]
 * @param [paymentOption]   [NSString type]
 */
- (void)showApproveViewWithOptionsDict:(NSDictionary *)optionsDict  withPaymentOption:(NSString *)paymentOption;

/*!
 * This method is used to show RegenerateOTPView.
 * @param [optionDict] [NSDictionary type]
 */
- (void)showRegenerateOTPViewWithOptionsDict:(NSDictionary *)optionDict;

/*!
 * This method is used to close CB.
 */
- (void)closeCBView;

/*!
 * This method is called from CBConnection/CBWKConnection to get callback for transaction status.
 */
- (void)handleTransactionStatus;
@end
