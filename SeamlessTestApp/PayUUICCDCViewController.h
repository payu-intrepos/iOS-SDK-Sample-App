//
//  PayUUICCDCViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayUHeader.h"

@interface PayUUICCDCViewController : UIViewController

@property (strong,nonatomic) PayUModelPaymentParams *paymentParam;

@property (weak, nonatomic) IBOutlet UITextField *textFieldCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldExpiryMonth;
@property (weak, nonatomic) IBOutlet UITextField *textFieldExpiryYear;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCVV;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameOnCard;
@property (weak, nonatomic) IBOutlet UITextField *textFieldstoreCardName;

@property (nonatomic, strong) NSString *paymentType;

@property (weak, nonatomic) IBOutlet UISwitch *switchSaveStoreCard;
@property (weak, nonatomic) IBOutlet UISwitch *switchForOneTap;

@property (weak, nonatomic) IBOutlet UILabel *labelCardBrandName;

@property (weak, nonatomic) IBOutlet UILabel *labelOneTap;

- (IBAction)payByCCDC:(id)sender;
- (IBAction)checkCardBrand:(id)sender;
- (IBAction)checkVAS:(id)sender;
- (IBAction)saveStoreCard:(id)sender;

@end
