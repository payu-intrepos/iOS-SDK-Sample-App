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
#define     VIEW_CONTROLLER_IDENTIFIER_PAYMENT_NET_BANKING      @"PaymentNB"
#define     VIEW_CONTROLLER_IDENTIFIER_PAYMENT_STORED_CARD      @"PaymentSC"

#define     CELL_IDENTIFIER_NETBANKING                          @"NetBankingCell"
#define     CELL_IDENTIFIER_STOREDCARD                          @"StoredCardCell"


#define     PAYUALERT(T,M)                  {[[[UIAlertView alloc] initWithTitle:T message:M delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];}

#endif /* PayUUIConstants_h */
