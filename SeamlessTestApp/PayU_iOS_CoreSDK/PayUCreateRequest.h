//
//  PayUCreateRequest.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 30/09/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUConstants.h"
#import "PayUModelPaymentParams.h"
#import "PayUValidations.h"
#import "PayUCreatePostParam.h"
#import "PayUUtils.h"

@interface PayUCreateRequest : NSObject


typedef void (^completionBlockForCreateRequestWithPaymentParam)(NSMutableURLRequest *request ,NSString *postParam,NSString *error);

@property (nonatomic, strong) PayUValidations *validations;
@property (nonatomic, strong) PayUUtils *utils;
@property (nonatomic, strong) PayUCreatePostParam *createPostParam;

-(void)createRequestWithPaymentParam:(PayUModelPaymentParams *) paymentParam forPaymentType: (NSString *)paymentType withCompletionBlock:(completionBlockForCreateRequestWithPaymentParam) paramCompletionBlock;

@end
