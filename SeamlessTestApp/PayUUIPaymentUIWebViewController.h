//
//  PayUUIPaymentUIWebViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayUHeader.h"


@interface PayUUIPaymentUIWebViewController : UIViewController<UIWebViewDelegate, PayUSDKWebViewResponseDelegate>
//@interface PayUUIPaymentUIWebViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong) NSURLRequest *paymentRequest;
@property (strong,nonatomic) PayUModelPaymentParams *paymentParam;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *paymentWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
