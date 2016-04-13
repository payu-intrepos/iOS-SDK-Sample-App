//
//  PUUIStoredCardVC.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIBaseVC.h"
#import "PayU_iOS_CoreSDK.h"

@interface PUUIStoredCardVC : PUUIBaseVC

//@property (strong, nonatomic) PayUModelPaymentParams *paymentParam;
//@property (strong, nonatomic) PayUModelPaymentRelatedDetail *paymentRelatedDetail;
@property (strong, nonatomic) NSMutableArray *arrStoredCards;
@property (strong, nonatomic) NSIndexPath *indexPathCard;

@end
