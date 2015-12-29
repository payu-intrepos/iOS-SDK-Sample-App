//
//  PayUUIConstants.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#ifndef PayUUIConstants_h
#define PayUUIConstants_h


#define     VIEW_CONTROLLER_IDENTIFIER_PAYMENT_OPTION           @"PaymentOptionVC"
#define     VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW        @"PaymentUIWebViewVC"
#define     VIEW_CONTROLLER_IDENTIFIER_PAYMENT_CCDC             @"PaymentCCDCVC"
#define     VIEW_CONTROLLER_IDENTIFIER_PAYMENT_NET_BANKING      @"PaymentNBVC"
#define     VIEW_CONTROLLER_IDENTIFIER_PAYMENT_STORED_CARD      @"PaymentSCVC"
#define     VIEW_CONTROLLER_IDENTIFIER_PAYMENT_EMI              @"PaymentEMIVC"
#define     NAVIGATION_CONTROLLER_IDENTIFIER                    @"PayUNavigationController"

#define     CELL_IDENTIFIER_PAYMENT_OPTION                      @"PaymentOptionCell"
#define     CELL_IDENTIFIER_NETBANKING                          @"NetBankingCell"
#define     CELL_IDENTIFIER_STOREDCARD                          @"StoredCardCell"
#define     CELL_IDENTIFIER_EMI_BANKNAME                        @"EMIBankNameCell"
#define     CELL_IDENTIFIER_EMI_DURATION                        @"EMIDurationCell"


#define     PAYUALERT(T,M)                                      dispatch_async(dispatch_get_main_queue(), ^{[[[UIAlertView alloc] initWithTitle:T message:M delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];});
//{[[[UIAlertView alloc] initWithTitle:T message:M delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];}

#endif /* PayUUIConstants_h */
