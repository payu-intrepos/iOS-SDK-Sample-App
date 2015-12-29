//
//  PayUUINetBankingViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayUHeader.h"
#import "PayUUIConstants.h"
#import "PayUUIPaymentUIWebViewController.h"
#import "PayUUICCDCViewController.h"

@interface PayUUINetBankingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetail;
@property (strong,nonatomic) PayUModelPaymentParams *paymentParam;

@property (weak, nonatomic) IBOutlet UITextField *paymentTypeForNetBanking;
@property (weak, nonatomic) IBOutlet UITextField *bankCodeForNetBanking;
@property (weak, nonatomic) IBOutlet UITableView *tableViewNetBanking;

- (IBAction)PayByNetBanking:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *insideView1;
@property (nonatomic, strong) PayUCreateRequest *createRequest;
@property (nonatomic, strong) NSString *paymentType;
- (IBAction)checkVAS:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *VASButton;

@end
