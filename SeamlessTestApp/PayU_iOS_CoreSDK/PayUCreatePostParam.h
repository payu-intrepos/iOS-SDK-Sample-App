//
//  PayUCreatePostParam.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 06/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUConstants.h"
#import "PayUModelPaymentParams.h"


@interface PayUCreatePostParam : NSObject

-(NSString *)createPostParam:(PayUModelPaymentParams *) paramPaymentParam withType:(NSString *) type;

@end
