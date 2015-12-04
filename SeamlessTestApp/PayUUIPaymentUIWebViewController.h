//
//  PayUUIPaymentUIWebViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PayUUIPaymentUIWebViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong) NSMutableURLRequest *paymentRequest;
@property (weak, nonatomic) IBOutlet UIWebView *paymentWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSString *merchantKey;
@property (strong, nonatomic) NSString *txnID;
@end
