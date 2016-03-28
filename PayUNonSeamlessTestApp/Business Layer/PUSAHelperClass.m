//
//  PUSAHelperClass.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 04/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUSAHelperClass.h"

NSString *const URLGetHash = @"https://payu.herokuapp.com/get_hash";
NSString *const URLGetMerchantHash = @"https://payu.herokuapp.com/get_merchant_hashes";
NSString *const URLStoreMerchantHash = @"https://payu.herokuapp.com/store_merchant_hash";


@implementation PUSAHelperClass

// To get Hashes from server

+(void) generateHashFromServer:(PayUModelPaymentParams *) paymentParam withCompletionBlock:(hashRequestCompletionBlock)completionBlock{
    
    void(^serverResponseForHashGenerationCallback)(PayUModelHashes *hashes, NSString *errorString) = completionBlock;
    
    NSMutableString *postParam = [NSMutableString new];
    
    if (paymentParam.offerKey) {
        [postParam appendFormat:@"offer_key=%@",paymentParam.offerKey];
    }
    if (paymentParam.key) {
        [postParam appendFormat:@"&key=%@",paymentParam.key];
    }
    if (paymentParam.hashes.paymentHash) {
        [postParam appendFormat:@"&hash=%@",paymentParam.hashes.paymentHash];
    }
    if (paymentParam.email) {
        [postParam appendFormat:@"&email=%@",paymentParam.email];
    }
    if (paymentParam.amount) {
        [postParam appendFormat:@"&amount=%@",paymentParam.amount];
    }
    if (paymentParam.firstName) {
        [postParam appendFormat:@"&firstname=%@",paymentParam.firstName];
    }
    if (paymentParam.transactionID) {
        [postParam appendFormat:@"&txnid=%@",paymentParam.transactionID];
    }
    if (paymentParam.userCredentials) {
        [postParam appendFormat:@"&user_credentials=%@",paymentParam.userCredentials];
    }
    if (paymentParam.udf1) {
        [postParam appendFormat:@"&udf1=%@",paymentParam.udf1];
    }
    if (paymentParam.udf2) {
        [postParam appendFormat:@"&udf2=%@",paymentParam.udf2];
    }
    if (paymentParam.udf3) {
        [postParam appendFormat:@"&udf3=%@",paymentParam.udf3];
    }
    if (paymentParam.udf4) {
        [postParam appendFormat:@"&udf4=%@",paymentParam.udf4];
    }
    if (paymentParam.udf5) {
        [postParam appendFormat:@"&udf5=%@",paymentParam.udf5];
    }
    if (paymentParam.productInfo) {
        [postParam appendFormat:@"&productinfo=%@",paymentParam.productInfo];
    }
    
    NSLog(@"-->>Hash generation Post Param = %@",postParam);
    
    [PUUIWSManager getWebServiceResponse:[PUUIWSManager getURLRequestWithPostParam:postParam withURL:[NSURL URLWithString:URLGetHash]] withCompletionBlock:^(id JSON, NSString *errorMessage, id extraParam) {
        if (JSON) {
            if([[JSON valueForKey:@"message"] isEqualToString:@"successfully generated hash"]){
                PayUModelHashes *payUHashes = [PayUModelHashes new];
                payUHashes.paymentHash = [JSON valueForKey:@"payment_hash"];
                payUHashes.paymentRelatedDetailsHash = [JSON valueForKey:@"payment_related_details_for_mobile_sdk_hash"];
                payUHashes.VASForMobileSDKHash = [JSON valueForKey:@"vas_for_mobile_sdk_hash"];
                payUHashes.deleteUserCardHash = [JSON valueForKey:@"delete_user_card_hash"];
                payUHashes.editUserCardHash = [JSON valueForKey:@"edit_user_card_hash"];
                payUHashes.saveUserCardHash = [JSON valueForKey:@"save_user_card_hash"];
                payUHashes.getUserCardHash = [JSON valueForKey:@"get_user_cards_hash"];
                payUHashes.offerHash = [JSON valueForKey:@"check_offer_status_hash"];
                serverResponseForHashGenerationCallback(payUHashes ,nil);
            }
            else{
                serverResponseForHashGenerationCallback(nil,[JSON valueForKey:@"message"]);
            }
            
        }
        else{
            serverResponseForHashGenerationCallback(nil,errorMessage);
        }
    }];
}

// To get transactionID

+(NSString *) getTransactionIDWithLength:(int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }
    
    return randomString;
}


// For OneTap

+(void)getOneTapTokenDictionaryFromServerWithPaymentParam:(PayUModelPaymentParams *)paymentParam CompletionBlock:(completionBlockForGetOneTapToken)completionBlock{
    void(^callBackForGetOneTapTokenDictionary)(NSDictionary *CardTokenAndOneTapToken, NSString *errorString) = completionBlock;
    
    NSString *postParam = [NSString stringWithFormat:@"merchant_key=%@&user_credentials=%@",paymentParam.key,paymentParam.userCredentials];
    
    NSLog(@"PostParam for getOneTapTokenDictionary %@",postParam);
    [PUUIWSManager getWebServiceResponse:[PUUIWSManager getURLRequestWithPostParam:postParam withURL:[NSURL URLWithString:URLGetMerchantHash]] withCompletionBlock:^(id JSON, NSString *errorMessage, id extraParam) {
        if (JSON) {
            if([[JSON valueForKey:@"message"] isEqualToString:@"Merchant hash fetched successfully"]){
                NSArray *arrayOfData = [JSON valueForKey:@"data"];
                NSMutableDictionary *dictOfCardToken = [NSMutableDictionary new];
                for (NSArray * eachToken in arrayOfData) {
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[eachToken objectAtIndex:1],[eachToken objectAtIndex:0], nil];
                    [dictOfCardToken addEntriesFromDictionary:dict];
                }
                callBackForGetOneTapTokenDictionary(dictOfCardToken,nil);
            }
            else{
                callBackForGetOneTapTokenDictionary(nil,[JSON valueForKey:@"message"]);
            }
        }
        else{
            callBackForGetOneTapTokenDictionary(nil ,errorMessage);
        }
    }];
}

+(void)saveOneTapTokenForMerchantKey:(NSString *) key withCardToken:(NSString *) cardToken withUserCredential:(NSString *) userCred andMerchantHash:(NSString *) merchantHash withCompletionBlock: (completionBlockForDeleteOneTapToken) completionBlock{
    void(^callBackForSaveOneTapToken)(NSString *message, NSString *errorString) = completionBlock;
    
    NSString *postParam = [NSString stringWithFormat:@"merchant_key=%@&user_credentials=%@&card_token=%@&merchant_hash=%@)",key,userCred,cardToken,merchantHash];
    
    NSLog(@"PostParam for saveOneTapTokenDictionary %@",postParam);
    
    [PUUIWSManager getWebServiceResponse:[PUUIWSManager getURLRequestWithPostParam:postParam withURL:[NSURL URLWithString:URLStoreMerchantHash]] withCompletionBlock:^(id JSON, NSString *errorMessage, id extraParam) {
        if (JSON) {
            if([[JSON valueForKey:@"message"] isEqualToString:@"Card token and merchant hash successfully added"]){
                callBackForSaveOneTapToken([JSON valueForKey:@"message"],nil);
            }
            else{
                callBackForSaveOneTapToken(nil,[JSON valueForKey:@"message"]);
            }
        }
        else{
            callBackForSaveOneTapToken(nil ,errorMessage);
        }
    }];
    
    
    
    //
    //
    //    NSURL *URL = [NSURL URLWithString:URLStoreMerchantHash];
    //    // create the request
    //    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL
    //                                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
    //                                                     timeoutInterval:60.0];
    //    // Specify that it will be a POST request
    //    request.HTTPMethod = @"POST";
    //    NSString *postParam = [NSString stringWithFormat:@"merchant_key=%@&user_credentials=%@&card_token=%@&merchant_hash=%@)",key,userCred,cardToken,merchantHash];
    //    //set request content type we MUST set this value.
    //    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //    //set post data of request
    //    [request setHTTPBody:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //    NSURLSession *session = [NSURLSession sharedSession];
    //    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    //        if (error) {
    //            callBackForSaveOneTapToken(nil,error.localizedDescription);
    //        }
    //        else{
    //            NSDictionary *hashDictionary = [NSDictionary new];
    //            NSError *serializationError;
    //            hashDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
    //            if (serializationError) {
    //                callBackForSaveOneTapToken(nil,serializationError.localizedDescription);
    //            }
    //            else if ([[hashDictionary valueForKey:@"message"] isEqual:@"Card token and merchant hash successfully added"]){
    //                callBackForSaveOneTapToken([hashDictionary valueForKey:@"message"],nil);
    //            }
    //            else{
    //                callBackForSaveOneTapToken(nil,[hashDictionary valueForKey:@"message"]);
    //            }
    //        }
    //    }] resume];
    
    
}

@end
