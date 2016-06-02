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
    
    [PUSAWSManager getWebServiceResponse:[PUSAWSManager getURLRequestWithPostParam:postParam withURL:[NSURL URLWithString:URLGetHash]] withCompletionBlock:^(id JSON, NSString *errorMessage, id extraParam) {
        if (JSON) {
            if([[JSON objectForKey:@"message"] isEqualToString:@"successfully generated hash"]){
                PayUModelHashes *payUHashes = [PayUModelHashes new];
                payUHashes.paymentHash = [JSON objectForKey:@"payment_hash"];
                payUHashes.paymentRelatedDetailsHash = [JSON objectForKey:@"payment_related_details_for_mobile_sdk_hash"];
                payUHashes.VASForMobileSDKHash = [JSON objectForKey:@"vas_for_mobile_sdk_hash"];
                payUHashes.deleteUserCardHash = [JSON objectForKey:@"delete_user_card_hash"];
                payUHashes.editUserCardHash = [JSON objectForKey:@"edit_user_card_hash"];
                payUHashes.saveUserCardHash = [JSON objectForKey:@"save_user_card_hash"];
                payUHashes.getUserCardHash = [JSON objectForKey:@"get_user_cards_hash"];
                payUHashes.offerHash = [JSON objectForKey:@"check_offer_status_hash"];
                serverResponseForHashGenerationCallback(payUHashes ,nil);
            }
            else{
                serverResponseForHashGenerationCallback(nil,[JSON objectForKey:@"message"]);
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
    [PUSAWSManager getWebServiceResponse:[PUSAWSManager getURLRequestWithPostParam:postParam withURL:[NSURL URLWithString:URLGetMerchantHash]] withCompletionBlock:^(id JSON, NSString *errorMessage, id extraParam) {
        if (JSON) {
            if([[JSON objectForKey:@"message"] isEqualToString:@"Merchant hash fetched successfully"]){
                NSArray *arrayOfData = [JSON objectForKey:@"data"];
                NSMutableDictionary *dictOfCardToken = [NSMutableDictionary new];
                for (NSArray * eachToken in arrayOfData) {
                    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[eachToken objectAtIndex:1],[eachToken objectAtIndex:0], nil];
                    [dictOfCardToken addEntriesFromDictionary:dict];
                }
                callBackForGetOneTapTokenDictionary(dictOfCardToken,nil);
            }
            else{
                callBackForGetOneTapTokenDictionary(nil,[JSON objectForKey:@"message"]);
            }
        }
        else{
            callBackForGetOneTapTokenDictionary(nil ,errorMessage);
        }
    }];
}

+(void)saveOneTapTokenForMerchantKey:(NSString *) key withCardToken:(NSString *) cardToken withUserCredential:(NSString *) userCred andMerchantHash:(NSString *) merchantHash withCompletionBlock: (completionBlockForSaveOneTapToken) completionBlock{
    void(^callBackForSaveOneTapToken)(NSString *message, NSString *errorString) = completionBlock;
    
    NSString *postParam = [NSString stringWithFormat:@"merchant_key=%@&user_credentials=%@&card_token=%@&merchant_hash=%@)",key,userCred,cardToken,merchantHash];
    
    NSLog(@"PostParam for saveOneTapTokenDictionary %@",postParam);
    
    [PUSAWSManager getWebServiceResponse:[PUSAWSManager getURLRequestWithPostParam:postParam withURL:[NSURL URLWithString:URLStoreMerchantHash]] withCompletionBlock:^(id JSON, NSString *errorMessage, id extraParam) {
        if (JSON) {
            if([[JSON objectForKey:@"message"] isEqualToString:@"Card token and merchant hash successfully added"]){
                callBackForSaveOneTapToken([JSON objectForKey:@"message"],nil);
            }
            else{
                callBackForSaveOneTapToken(nil,[JSON objectForKey:@"message"]);
            }
        }
        else{
            callBackForSaveOneTapToken(nil ,errorMessage);
        }
    }];
}

@end
