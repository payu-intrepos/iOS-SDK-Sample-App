//
//  PayUUIPaymentOptionViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <PayU_iOS_CoreSDK/PayU_iOS_CoreSDK.h>
#import "PayU_iOS_CoreSDK.h"

@interface PayUUIPaymentOptionViewController : UIViewController

@property (nonatomic,strong) PayUModelPaymentParams *paymentParam;
@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetail;
- (IBAction)payByCCDC:(id)sender;
- (IBAction)payByNetBanking:(id)sender;
- (IBAction)payByStoredCard:(id)sender;

@end
