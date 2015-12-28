//
//  PayUSAOneTapToken.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 05/11/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUHeader.h"

typedef void (^completionBlockForGetOneTapToken)(NSDictionary *CardTokenAndOneTapToken, NSString *errorString);
typedef void (^completionBlockForDeleteOneTapToken)(NSString *message, NSString *errorString);

@interface PayUSAOneTapToken : NSObject

-(void) getOneTapTokenDictionaryFromServerWithPaymentParam:(PayUModelPaymentParams *) paymentParam CompletionBlock:(completionBlockForGetOneTapToken)completionBlock;
-(void)deleteOneTapTokenForCardToken:(NSString *) cardToken withCompletionBlock: (completionBlockForDeleteOneTapToken) completionBlock;
-(void)saveOneTapTokenForMerchantKey:(NSString *) key withCardToken:(NSString *) cardToken withUserCredential:(NSString *) userCred andMerchantHash:(NSString *) merchantHash withCompletionBlock: (completionBlockForDeleteOneTapToken) completionBlock;

@end
