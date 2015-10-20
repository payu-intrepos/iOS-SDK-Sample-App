//
//  PayUUICCDCViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <PayU_iOS_CoreSDK/PayU_iOS_CoreSDK.h>
#import "PayU_iOS_CoreSDK.h"


@interface PayUUICCDCViewController : UIViewController

@property (strong,nonatomic) PayUModelPaymentParams *paymentParam;
- (IBAction)payByCCDC:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldExpiryMonth;
@property (weak, nonatomic) IBOutlet UITextField *textFieldExpiryYear;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCVV;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameOnCard;
- (IBAction)checkCardBrand:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *textFieldCardBrandName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSaveStoreCard;
@property (weak, nonatomic) IBOutlet UITextField *textFieldstoreCardName;
@property (weak, nonatomic) IBOutlet UILabel *labelActualAmount;
- (IBAction)checkVAS:(id)sender;


@end
