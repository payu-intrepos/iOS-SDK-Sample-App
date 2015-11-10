//
//  PayUJSONParser.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 09/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUModelPaymentRelatedDetail.h"
#import "PayUModelOfferStatus.h"

@interface PayUJSONParser : NSObject

typedef void (^completionBlockForJSONParserforPaymentRelatedDetailForMobileSDK)(PayUModelPaymentRelatedDetail *paymentRelatedDetails ,NSString *errorMessage, id extraParam);
typedef void (^completionBlockForJSONParserForOfferStatus)(PayUModelOfferStatus *offerStatus ,NSString *errorMessage, id extraParam);

typedef void (^completionBlockForJSONParserForDeleteStoredCard)(NSString * deleteStoredCardStatus, NSString * deleteStoredCardMessage ,NSString *errorMessage, id extraParam);

-(void)JSONParserforOfferStatus:(id) JSON withCompletionBlock:(completionBlockForJSONParserForOfferStatus) paramCompletionBlock;


-(void)JSONParserforPaymentRelatedDetailForMobileSDK:(id) JSON withCompletionBlock:(completionBlockForJSONParserforPaymentRelatedDetailForMobileSDK) paramCompletionBlock;

-(void)JSONParserForDeleteStoredCard:(id) JSON withCompletionBlock:(completionBlockForJSONParserForDeleteStoredCard) paramCompletionBlock;


@end
