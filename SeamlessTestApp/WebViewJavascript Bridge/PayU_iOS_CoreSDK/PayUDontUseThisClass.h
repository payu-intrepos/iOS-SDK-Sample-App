//
//  PayUDontUseThisClass.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 31/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUModelHashes.h"
#import "PayUModelPaymentParams.h"
#import "PayUValidations.h"

@interface PayUDontUseThisClass : NSObject


typedef void (^completionBlockForgetPayUHashesWithPaymentParam)(PayUModelHashes *allHashes, PayUModelHashes *hashString, NSString *errorMessage);

-(void)getPayUHashesWithPaymentParam:(PayUModelPaymentParams *) paymentParam merchantSalt:(NSString *) salt withCompletionBlock:(completionBlockForgetPayUHashesWithPaymentParam) completionBlock;



@end
