//
//  PayUUIEMIViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 28/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayUUIConstants.h"
#import "PayUUIPaymentUIWebViewController.h"
#import "PayUHeader.h"

@interface PayUUIEMIViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewBankName;
@property (weak, nonatomic) IBOutlet UITableView *tableViewEMIDuration;


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) PayUModelPaymentParams *paymentParam;
@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldExpiryMonth;
@property (weak, nonatomic) IBOutlet UITextField *textFieldExpiryYear;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCVV;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNameOnCard;
@property (weak, nonatomic) IBOutlet UILabel *labelCardBrandName;

- (IBAction)payByEMI:(id)sender;
- (IBAction)checkCardBrand:(id)sender;
- (IBAction)checkVAS:(id)sender;


@end
