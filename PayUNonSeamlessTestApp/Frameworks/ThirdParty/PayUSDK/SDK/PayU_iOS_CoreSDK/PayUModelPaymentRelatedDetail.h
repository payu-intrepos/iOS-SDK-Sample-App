//
//  PayUModelPaymentRelatedDetail.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 09/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

/*!
 * This class declares the properties that holds payment related details.
 */
#import <Foundation/Foundation.h>
#import "PayUModelNetBanking.h"
#import "PayUModelStoredCard.h"
#import "PayUModelCashCard.h"
#import "PayUModelEMI.h"

@interface PayUModelPaymentRelatedDetail : NSObject

@property (nonatomic, strong) NSArray *oneTapStoredCardArray;
@property (nonatomic, strong) NSArray *storedCardArray;
@property (nonatomic, strong) NSArray *netBankingArray;
@property (nonatomic, strong) NSArray *cashCardArray;
@property (nonatomic, strong) NSArray *EMIArray;

@property (nonatomic, strong) NSMutableArray *availablePaymentOptionsArray;

@end
