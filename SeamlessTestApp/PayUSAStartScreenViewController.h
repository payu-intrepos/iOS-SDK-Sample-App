//
//  PayUSAStartScreenViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 29/09/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <PayU_iOS_CoreSDK/PayU_iOS_CoreSDK.h>
#import "PayU_iOS_CoreSDK.h"

@interface PayUSAStartScreenViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTransactionID;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAmount;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProductInfo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSURL;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFURL;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEnvironment;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfferKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF4;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF5;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserCredential;
- (IBAction)startPayment:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *startScreenScrollView;
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UISwitch *switchForNil;
- (IBAction)switchButtonForNil:(id)sender;

@end
