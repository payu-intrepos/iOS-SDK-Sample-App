//
//  PUUIPaymentOptionVC.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIWrapperKHTabPagerVC.h"
#import <PayUBizCoreKit/PayUBizCoreKit.h>

@interface PUUIPaymentOptionVC : PUUIWrapperKHTabPagerVC

@property (nonatomic, strong) PayUModelPaymentParams *paymentParam;
@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetail;

@property (nonatomic, strong) NSArray *paymentOption;
@property (nonatomic, strong) NSString *subventionPaymentHash;


//Strictly part of Sample App
@property (nonatomic, assign) NSInteger surePayCount;
@property (nonatomic, assign) BOOL shouldEnableWKWebview;
@property (nonatomic, strong) UIView *customReviewOrderView;
@property (nonatomic, assign) BOOL showRO;
@property (nonatomic, assign) BOOL presentCB;
@property (nonatomic, assign) BOOL presentCBFullscreen;
@end
