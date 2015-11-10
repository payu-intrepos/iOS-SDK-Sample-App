//
//  PayUSAGetHashes.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUSAGetHashes.h"


@implementation PayUSAGetHashes


-(void) generateHashFromServer:(PayUModelPaymentParams *) paymentParam withCompletionBlock:(hashRequestCompletionBlock)completionBlock{
    void(^serverResponseForHashGenerationCallback)(PayUModelHashes *hashes, NSString *errorString) = completionBlock;
    NSURL *hashURL = [NSURL URLWithString:@"https://payu.herokuapp.com/get_hash"];
    // create the request
    NSMutableURLRequest *hashRequest=[NSMutableURLRequest requestWithURL:hashURL
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:60.0];
    // Specify that it will be a POST request
    hashRequest.HTTPMethod = @"POST";
    NSString *postParam = [NSString stringWithFormat:@"offer_key=%@&key=%@&hash=hash&email=%@&amount=%@&firstname=%@&txnid=%@&user_credentials=%@&udf1=%@&udf2=%@&udf3=%@&udf4=%@&udf5=%@&productinfo=%@",[self checkParamaterForNil:paymentParam.offerKey],[self checkParamaterForNil:paymentParam.key],[self checkParamaterForNil:paymentParam.email],[self checkParamaterForNil:paymentParam.amount],[self checkParamaterForNil:paymentParam.firstName],[self checkParamaterForNil:paymentParam.transactionID],[self checkParamaterForNil:paymentParam.userCredentials],[self checkParamaterForNil:paymentParam.udf1],[self checkParamaterForNil:paymentParam.udf2],[self checkParamaterForNil:paymentParam.udf3],[self checkParamaterForNil:paymentParam.udf4],[self checkParamaterForNil:paymentParam.udf5],[self checkParamaterForNil:paymentParam.productInfo]];
    NSLog(@"-->>Hash generation Post Param = %@",postParam);
    //set request content type we MUST set this value.
    [hashRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //set post data of request
    [hashRequest setHTTPBody:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:hashRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            serverResponseForHashGenerationCallback(nil ,error.localizedDescription);
        }
        else
        {
            NSDictionary *hashDictionary = [NSDictionary new];
            NSError *serializationError;
            hashDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
            if (serializationError) {
                serverResponseForHashGenerationCallback(nil ,error.localizedDescription);
            }//[[hashDictionary valueForKey:@"status"] isEqualToString:@"0"]
            else if([[hashDictionary valueForKey:@"message"] isEqualToString:@"successfully generated hash"]){
                PayUModelHashes *payUHashes = [PayUModelHashes new];
                payUHashes.paymentHash = [hashDictionary valueForKey:@"payment_hash"];
                payUHashes.paymentRelatedDetailsHash = [hashDictionary valueForKey:@"payment_related_details_for_mobile_sdk_hash"];
                payUHashes.VASForMobileSDKHash = [hashDictionary valueForKey:@"vas_for_mobile_sdk_hash"];
                payUHashes.deleteUserCardHash = [hashDictionary valueForKey:@"delete_user_card_hash"];
                payUHashes.editUserCardHash = [hashDictionary valueForKey:@"edit_user_card_hash"];
                payUHashes.saveUserCardHash = [hashDictionary valueForKey:@"save_user_card_hash"];
                payUHashes.getUserCardHash = [hashDictionary valueForKey:@"get_user_cards_hash"];
                payUHashes.offerHash = [hashDictionary valueForKey:@"check_offer_status_hash"];
                serverResponseForHashGenerationCallback(payUHashes ,nil);
            }
            else{
                serverResponseForHashGenerationCallback(nil,[hashDictionary valueForKey:@"message"]);
            }
        }
        
    }] resume];
    
}
-(NSString *)checkParamaterForNil:(NSString *) parameter{
    if (parameter == nil) {
        return @"";
    }
    else{
        return parameter;
    }
}

@end
