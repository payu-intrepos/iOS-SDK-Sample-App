//
//  PayUSAGetHashes.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <PayU_iOS_CoreSDK/PayU_iOS_CoreSDK.h>
#import "PayU_iOS_CoreSDK.h"

typedef void (^hashRequestCompletionBlock)(PayUHashes *hashes, NSString *errorString);

@interface PayUSAGetHashes : NSObject

-(void) generateHashFromServer:(PayUModelPaymentParams *) paymentParam withCompletionBlock:(hashRequestCompletionBlock)completionBlock;

@end
