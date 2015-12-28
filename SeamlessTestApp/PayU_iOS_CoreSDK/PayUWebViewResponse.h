//
//  PayUWebViewResponse.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 20/11/15.
//  Copyright © 2015 PayU. All rights reserved.
//

/*
 This class gives helper method to get PayU success and failure response
*/

#import <Foundation/Foundation.h>
#import "PayUConstants.h"
@import JavaScriptCore;
@import WebKit;

@protocol JSCallBackToObjCSDK <JSExport>

-(void)onPayuSuccess:(id)response;
-(void)onPayuFailure:(id)response;

@end


@protocol  PayUSDKWebViewResponseDelegate <NSObject>

-(void)PayUSuccessResponse:(id)response;
-(void)PayUFailureResponse:(id)response;

@end


@interface PayUWebViewResponse : NSObject <JSCallBackToObjCSDK>
-(void)initialSetupForWebView:(UIWebView *) webview;
@property (nonatomic,weak) id <PayUSDKWebViewResponseDelegate> delegate;
@property (weak,nonatomic) JSContext *js;

@end
