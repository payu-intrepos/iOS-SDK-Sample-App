//
//  PayUUIStoredCardViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayUHeader.h"

#import "PayUUIConstants.h"
#import "PayUUIPaymentUIWebViewController.h"

@interface PayUUIStoredCardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) PayUModelPaymentParams *paymentParam;
@property (strong, nonatomic) PayUModelPaymentRelatedDetail *paymentRelatedDetail;

@property (weak, nonatomic) IBOutlet UIView *viewInside1;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStoredCard;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCVV;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPaymentTypeForSC;

@property (nonatomic, strong) PayUCreateRequest *createRequest;
@property (nonatomic, strong) PayUWebServiceResponse *webServiceResponse;
- (IBAction)PayBySC:(id)sender;
- (IBAction)deleteStoredCard:(id)sender;

- (IBAction)checkVAS:(id)sender;


@end
