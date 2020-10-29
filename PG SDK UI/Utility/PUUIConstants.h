//
//  PUUIConstants.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUUIImageConstants.h"

@interface PUUIConstants : NSObject

#define ALPHA_HALF   0.5
#define ALPHA_FULL   1.0

extern NSString * const kPUUINotiEnablePayNow, * const kPUUIPaymentRequest, * const kPUUIEnablePayNowFlag, * const kPUUINotiPaymentResponse, * const kPUUIPayNow, * const kPUUIPayUResponse, * const kPUUIMerchantResponse;

typedef NS_ENUM(NSInteger, TableViewType) {
    TableViewTypeNB,
    TableViewTypeSC,
    TableViewTypeEMIBank,
    TableViewTypeEMIDuration
};


#define     VC_IDENTIFIER_PAYMENT_OPTION                @"PUUIPaymentOptionVC"

#define     VC_IDENTIFIER_STORED_CARD                   @"PUUIStoredCardVC"
#define     VC_IDENTIFIER_STORED_CARD_CAROUSEL          @"PUUIStoredCardCarouselVC"
#define     VC_IDENTIFIER_CCDC                          @"PUUICCDCVC"
#define     VC_IDENTIFIER_NET_BANKING                   @"PUUINBVC"
#define     VC_IDENTIFIER_CASHCARD                      @"PUUICashCardVC"
#define     VC_IDENTIFIER_EMI                           @"PUUI_EMI_VC"
#define     VC_IDENTIFIER_PAYU_MONEY                    @"PUUIPayUMoneyVC"
#define     VC_IDENTIFIER_PAYU_UPI                      @"PUUIPayUUPIVC"


//#define     NAVIGATION_CONTROLLER_IDENTIFIER                    @"PayUNavigationController"
//
//#define     CELL_IDENTIFIER_PAYMENT_OPTION                      @"PaymentOptionCell"
//#define     CELL_IDENTIFIER_NETBANKING                          @"NetBankingCell"
//#define     CELL_IDENTIFIER_STOREDCARD                          @"StoredCardCell"
//#define     CELL_IDENTIFIER_EMI_BANKNAME                        @"EMIBankNameCell"
//#define     CELL_IDENTIFIER_EMI_DURATION                        @"EMIDurationCell"

#define IS_IPHONE4 ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 480)


// Bank Names Collection
extern NSString * const kICICI;
extern NSString * const kHDFC;
extern NSString * const kAXIS;
extern NSString * const kSBI;

@end
