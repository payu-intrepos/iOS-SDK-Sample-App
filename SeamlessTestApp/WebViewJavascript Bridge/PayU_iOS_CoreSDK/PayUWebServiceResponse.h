//
//  PayUWebServiceResponse.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUModelPaymentParams.h"
#import "PayUValidations.h"
#import "PayUUtils.h"
#import "PayUCreatePostParam.h"
#import "PayUJSONParser.h"
#import "PayUModelOfferStatus.h"
#import "PayUConstants.h"
#import "PayUSharedDataManager.h"

@interface PayUWebServiceResponse : NSObject

typedef void (^completionBlockForPayUPaymentRelatedDetail)(PayUModelPaymentRelatedDetail *paymentRelatedDetails ,NSString *errorMessage, id extraParam);

typedef void (^completionBlockForOfferStatus)(PayUModelOfferStatus *offerStatus ,NSString *errorMessage, id extraParam);

typedef void (^completionBlockForDeleteStoredCard)(NSString * deleteStoredCardStatus, NSString * deleteStoredCardMessage ,NSString *errorMessage, id extraParam);

typedef void (^completionBlockForGetVASStatusForCardBinOrBankCode)(id ResponseMessage ,NSString *errorMessage, id extraParam);


-(void)getPayUPaymentRelatedDetailForMobileSDK:(PayUModelPaymentParams *) paymentParam withCompletionBlock:(completionBlockForPayUPaymentRelatedDetail) paramCompletionBlock;

-(void)getOfferStatus:(PayUModelPaymentParams *) paymentParam withCompletionBlock:(completionBlockForOfferStatus) paramCompletionBlock;

-(void)deleteStoredCard:(PayUModelPaymentParams *) paymentParam withCompletionBlock:(completionBlockForDeleteStoredCard) paramCompletionBlock;

-(void)callVASForMobileSDKWithPaymentParam:(PayUModelPaymentParams *) paymentParam;

-(void)getVASStatusForCardBinOrBankCode:(NSString *) cardBinOrBankCode withCompletionBlock:(completionBlockForGetVASStatusForCardBinOrBankCode) paramCompletionBlock;

@property (nonatomic, strong) PayUValidations *validations;
@property (nonatomic, strong) PayUCreatePostParam *createPostParam;
@property (nonatomic, strong) PayUUtils *utils;
@property (nonatomic, strong) PayUJSONParser *JSONParser;


@end
