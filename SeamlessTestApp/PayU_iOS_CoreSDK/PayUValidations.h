//
//  PayUValidations.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 01/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

/*
PayUValidation Class helps in validating payment params
*/

#import <Foundation/Foundation.h>
#import "PayUModelPaymentParams.h"


@interface PayUValidations : NSObject

-(NSMutableString *)validateMandatoryParamsForPayment: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateMandatoryParamsForPaymentHashGeneration: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateOneTapParam: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateStoredCardParams: (PayUModelPaymentParams *) paymentParam;
-(NSString *)validateNetbankingParams: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateCCDCParams: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validatePaymentRelatedDetailsParam:(PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateOfferStatusParam:(PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateDeleteStoredCard: (PayUModelPaymentParams *) paymentParam;
-(NSMutableString *)validateVASParams:(PayUModelPaymentParams *) paymentParam;
-(NSString *)validateCashCardParams: (PayUModelPaymentParams *) paymentParam;
-(NSString *)validateEMIParams: (PayUModelPaymentParams *) paymentParam;
-(NSString *)validateUserCredentials: (NSString *) userCredentials;
-(NSString *)validateOfferKey:(NSString *) offerKey;


//Card Validations
-(NSString *)validateCardNumber:(NSString *) cardNumber;
-(NSString *)validateLuhnCheckOnCardNumber:(NSString *) cardNumber;
-(NSString *)getIssuerOfCardNumber:(NSString *) cardNumber;
-(BOOL)validateRegex:(NSString *) regex withCardNumber:(NSString *) cardNumber;

// General Validations
-(BOOL)isNumeric:(NSString *) paramString;
-(BOOL)isAlphabet:(NSString *) paramString;

@end
