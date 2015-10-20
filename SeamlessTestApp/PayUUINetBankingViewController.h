//
//  PayUUINetBankingViewController.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <PayU_iOS_CoreSDK/PayU_iOS_CoreSDK.h>
#import "PayU_iOS_CoreSDK.h"
#import "PayUUIConstants.h"
#import "PayUUIPaymentUIWebViewController.h"

@interface PayUUINetBankingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetail;
@property (strong,nonatomic) PayUModelPaymentParams *paymentParam;

@property (weak, nonatomic) IBOutlet UITextField *paymentTypeForNetBanking;
@property (weak, nonatomic) IBOutlet UITextField *bankCodeForNetBanking;
@property (weak, nonatomic) IBOutlet UITableView *tableViewNetBanking;

- (IBAction)PayByNetBanking:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *insideView1;
@property (nonatomic, strong) PayUCreateRequest *createRequest;

- (IBAction)checkVAS:(id)sender;

@end
