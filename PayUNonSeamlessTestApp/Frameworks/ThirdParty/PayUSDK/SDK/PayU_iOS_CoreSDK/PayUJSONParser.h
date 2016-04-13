//
//  PayUJSONParser.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 09/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

/*!
 * This class is used to parse JSON
 */

#import <Foundation/Foundation.h>
#import "PayUModelPaymentRelatedDetail.h"
#import "PayUModelOfferStatus.h"
#import "PayUModelOfferDetails.h"

@interface PayUJSONParser : NSObject

typedef void (^completionBlockForJSONParserforPaymentRelatedDetailForMobileSDK)(PayUModelPaymentRelatedDetail *paymentRelatedDetails ,NSString *errorMessage, id extraParam);
typedef void (^completionBlockForJSONParserForOfferStatus)(PayUModelOfferStatus *offerStatus ,NSString *errorMessage, id extraParam);
typedef void (^completionBlockForJSONParserForOfferDetails)(PayUModelOfferDetails *offerDetails ,NSString *errorMessage, id extraParam);

typedef void (^completionBlockForJSONParserForDeleteStoredCard)(NSString * deleteStoredCardStatus, NSString * deleteStoredCardMessage ,NSString *errorMessage, id extraParam);

/*!
 * This method parse the JSON for CCDC/NetBanking Offer.
 * @param [JSON] [id - object returned from "JSONObjectWithData" method of NSJSONSerialization]
 * @param [block]
 */
-(void)JSONParserforOfferStatus:(id) JSON withCompletionBlock:(completionBlockForJSONParserForOfferStatus) paramCompletionBlock;

/*!
 * This method parse the JSON for CCDC/NetBanking Offers.
 * @param [JSON] [id - object returned from "JSONObjectWithData" method of NSJSONSerialization]
 * @param [paymentType]         [NSString type]
 * @param [block]
 */
-(void)JSONParserforOfferDetails:(id) JSON withPaymentType:(NSString *) paymentType andCompletionBlock:(completionBlockForJSONParserForOfferDetails) paramCompletionBlock;

/*!
 * This method parse the JSON for CCDC/payment related detail. It parses the JSON and prepares array of model classes for all payment options.
 * @param [JSON] [id - object returned from "JSONObjectWithData" method of NSJSONSerialization]
 * @param [block]
 */
-(void)JSONParserforPaymentRelatedDetailForMobileSDK:(id) JSON andOneTapTokenDictionary:(NSDictionary *) OneTapTokenDictionary withCompletionBlock:(completionBlockForJSONParserforPaymentRelatedDetailForMobileSDK) paramCompletionBlock;

/*!
 * This method parse the JSON for deleteStoredCard.
 * @param [JSON] [id - object returned from "JSONObjectWithData" method of NSJSONSerialization]
 * @param [block]
 */
-(void)JSONParserForDeleteStoredCard:(id) JSON withCompletionBlock:(completionBlockForJSONParserForDeleteStoredCard) paramCompletionBlock;


@end
