//
//  PUUIWebViewVC.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 06/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUUIBaseVC.h"

@interface PUUIWebViewVC : PUUIBaseVC <UIWebViewDelegate>

@property (nonatomic, strong) NSURLRequest *request;
@property (weak, nonatomic) IBOutlet UIWebView *vwWebView;
@property (nonatomic, assign) NSInteger bankSimulatorType;
@end
