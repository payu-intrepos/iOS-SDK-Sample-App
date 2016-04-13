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
@class CBApproveView;
@class RegenerateOTPView;
@class CBAllPaymentOption;
@class CBBankPageLoading;
@class CBRegisterOption;
@class CBPassowrdWithIncorrectOTPView;

/*!
 * This protocol declares the methods which we get from JS callbacks.
 */
@protocol JSCallBackToObjC <JSExport>

/*!
 * This method is called from JS when bank name is resolved.
 * @param [bankName] [NSString type]
 */
- (void) bankFound:(NSString *)BankName;

/*!
 * This method is called from JS. IT opens and closes the CB based on paymentOption param.
 * @param [paymentOption]                   [NSString type]
 * @param [otherPaymentOptipon]             [NSString type]
 * @see   [closeCBFromConvertToNative]
 * @see   [logShowCBEvent]
 */
- (void) convertToNative:(NSString *)paymentOption :(NSString *)otherPaymentOptipon;

/*!
 * This method is called from JS. It calls "downloadBankSpecificJS" method if param "isShowCustomBrowser" is 1
 * @param [isShowCustomBrowser]     [NSInteger type]
 * @see   [downloadBankSpecificJS]
 */
- (void) showCustomBrowser:(NSInteger)isShowCustomBrowser;

/*!
 * This method is called from JS to reload the bank page.
 */
- (void) reInit;

/*!
 * This method is called from JS.
 * @param [strMagicRetryUrls]       [NSString type]
 * @see   [setMRUrlList - CBUtile]
 */
- (void) setMRData:(NSString *)strMagicRetryUrls;

/*!
 * This method is called from JS.
 * @param [response]                                    [id type]
 * @see   [payUTransactionStatusSuccess - CBConnection]
 */
-(void)onPayuSuccess:(id)response;

/*!
 * This method is called from JS.
 * @param [response]                                    [id type]
 * @see   [payUTransactionStatusFailure - CBConnection]
 */
-(void)onPayuFailure:(id)response;

@end

/*!
 * This protocol declares methods that gives callbacks to CBConnection and CBWKConnection.
 */
@protocol  CBConnectionHandlerDelegate <NSObject>

- (void) bankSpecificJSDownloded;

/*!
 * This method gives callback to CBConnection when bank name is detected.
 * @param [bankName]                        [NSString type]
 * @see   [bankNameFound - CBConnection]
 */
- (void) bankNameFound:(NSString *) bankName;

- (void) adjustWebViewHeight:(BOOL) upOrDown;
- (void) addViewInResultView:(UIView *) aView;

/*!
 * This method gives callback to CBConnection when transaction is success.
 * @param [response]                            [id type]
 * @see   [PayUSuccessResponse - CBConnection]
 */
- (void) payUTransactionStatusSuccess:(id)response;

/*!
 * This method gives callback to CBConnection when transaction is fail.
 * @param [response]                            [id type]
 * @see   [PayUFailureResponse - CBConnection]
 */
- (void) payUTransactionStatusFailure:(id)response;
@end

/*!
 * This class is used to run JS on WebView and to receive callbacks from JS. It is for both UIWebView and WKWebView.
 */
@interface CBConnectionHandler : NSObject<JSCallBackToObjC>

@property (nonatomic,copy)   NSString *initializejs;
@property (nonatomic,strong) NSMutableDictionary *initializeJavascriptDict;
@property (nonatomic,strong) NSMutableDictionary *bankSpecificJavaScriptDict;
@property (nonatomic,assign) BOOL isBankFound;
@property (nonatomic,weak)   UIView *resultView;
//@property (nonatomic,weak)   WKWebView *resultWebView;
@property (nonatomic,weak)   UIWebView *resultWebView;
@property (nonatomic,weak)   id resultViewController;
@property (nonatomic,copy)   NSString *bankName;

@property (nonatomic,strong) CBApproveView  *approveOTP;
@property (nonatomic,strong) RegenerateOTPView *regenOTPView;
@property (nonatomic,strong) CBAllPaymentOption *choose;
@property (nonatomic,strong) CBBankPageLoading  *loader;
@property (nonatomic,strong) CBRegisterOption  *registerOption;
@property (nonatomic,strong) CBPassowrdWithIncorrectOTPView  *passwordWithIncorrectOTP;

@property (nonatomic,assign) BOOL isWKWebView;
@property (nonatomic,assign) NSInteger cbServerID;
@property (nonatomic,assign) NSInteger analyticsServerID;

@property (nonatomic, assign) BOOL isAutoOTPSelect;
@property (nonatomic, assign) BOOL cbStatus;
//@property (nonatomic, assign) BOOL isAutoApproveClick;


@property (nonatomic,weak) id <CBConnectionHandlerDelegate> connectionHandlerDelegate;

/*!
 * This method is called from CBApproveView to show RegenerateOTPView when timer goes to zero sec.
 * @param [aView] [UIView type]
 */
- (void) populateRegenerateOption:(UIView *)aView;

/*!
 * This method is called from CBConnection/CBWKConnection to runBankSpecificJS on WebView.
 */
- (void) runBankSpecificJSOnWebView;

/*!
 * This method is called from CBConnection/CBWKConnection to download initialJS.
 */
- (void) downloadInitializeJS;

/*!
 * This method is called from CBConnection/CBWKConnection to download bankSpecificJS.
 * @param [bankName] [NSString type]
 */
- (void) downloadBankSpecificJS:(NSString *)bankName;

/*!
 * This method is called from CBConnection/CBWKConnection to runInitializeJS on WebView.
 */
- (void) runIntializeJSOnWebView;

/*!
 * This method is called from CB custom views to run JS on WebView when user clicks on CB controls. For example passsord,smsOTP etc.
 */
- (void) runJavaScript:(NSString *)js toWebView:(UIWebView *) webView;

/*!
 * This method is called from CBConnection/CBWKConnection to close CB.
 */
- (void) closeCB;

/*!
 * This method is called from CB custom views to show bank loader on CB during switching CB view.
 * @class CBConnectionHandler
 */
- (void) addBankLoader;

/*!
 * This method is called from CBConnection/CBWKConnection to remove PayULoader.
 */
- (void) removeIntermidiateLoader;

/*!
 * This method is called from CBConnection/CBWKConnection to get MagicRetry Url list.
 */
- (void) runMagicRetryJS;

/*!
 * This method is called from CBConnection/CBWKConnection to get callback for transaction status.
 */
- (void) handleTransactionStatus;

//+ (NSString *)getMobileTestUrl:(BOOL)isWKWebViewSupport;

@end
