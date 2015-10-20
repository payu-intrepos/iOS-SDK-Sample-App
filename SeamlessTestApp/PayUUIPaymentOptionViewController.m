//
//  PayUUIPaymentOptionViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUIPaymentOptionViewController.h"
#import "PayUUICCDCViewController.h"
#import "PayUUINetBankingViewController.h"
#import "PayUUIStoredCardViewController.h"
#import "PayUUIConstants.h"
//#import "PayUSharedDataManager.h"

@interface PayUUIPaymentOptionViewController ()

@end

@implementation PayUUIPaymentOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)payByCCDC:(id)sender {
    PayUUICCDCViewController *CCDCVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_CCDC];
    CCDCVC.paymentParam = self.paymentParam;
    [self.navigationController pushViewController:CCDCVC animated:true];
}
- (IBAction)payByNetBanking:(id)sender {

    //    [respo callVASForMobileSDKWithPaymentParam:self.paymentParamForPassing];        //FORVAS1
    PayUUINetBankingViewController *NBVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_NET_BANKING];
    NBVC.paymentParam = self.paymentParam;
    NBVC.paymentRelatedDetail = self.paymentRelatedDetail;
    [self.navigationController pushViewController:NBVC animated:true];
}

- (IBAction)payByStoredCard:(id)sender {
    PayUUIStoredCardViewController *SCVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_STORED_CARD];
    SCVC.paymentParam = self.paymentParam;
    SCVC.paymentRelatedDetail = self.paymentRelatedDetail;
    [self.navigationController pushViewController:SCVC animated:true];
}
@end
