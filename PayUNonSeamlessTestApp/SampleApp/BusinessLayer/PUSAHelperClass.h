//
//  PUSAHelperClass.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 04/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayU_iOS_CoreSDK.h"
#import "PUSAWSManager.h"

typedef void (^hashRequestCompletionBlock)(PayUModelHashes *hashes, NSString *errorString);
typedef void (^completionBlockForGetOneTapToken)(NSDictionary *CardTokenAndOneTapToken, NSString *errorString);
typedef void (^completionBlockForSaveOneTapToken)(NSString *message, NSString *errorString);

@interface PUSAHelperClass : NSObject

+(void) generateHashFromServer:(PayUModelPaymentParams *) paymentParam withCompletionBlock:(hashRequestCompletionBlock)completionBlock;

+(void)getOneTapTokenDictionaryFromServerWithPaymentParam:(PayUModelPaymentParams *)paymentParam CompletionBlock:(completionBlockForGetOneTapToken)completionBlock;

+(void)saveOneTapTokenForMerchantKey:(NSString *) key withCardToken:(NSString *) cardToken withUserCredential:(NSString *) userCred andMerchantHash:(NSString *) merchantHash withCompletionBlock: (completionBlockForSaveOneTapToken) completionBlock;

+(NSString *) getTransactionIDWithLength:(int) len;

@end
