//
//  PayUSAOneTapToken.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 05/11/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUSAOneTapToken.h"

@implementation PayUSAOneTapToken

-(void)getOneTapTokenDictionaryFromServerWithPaymentParam:(PayUModelPaymentParams *)paymentParam CompletionBlock:(completionBlockForGetOneTapToken)completionBlock{
    void(^callBackForGetOneTapTokenDictionary)(NSDictionary *CardTokenAndOneTapToken, NSString *errorString) = completionBlock;
    

        NSURL *URL = [NSURL URLWithString:@"https://payu.herokuapp.com/get_merchant_hashes"];
        // create the request
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
        // Specify that it will be a POST request
        request.HTTPMethod = @"POST";
        NSString *postParam = [NSString stringWithFormat:@"merchant_key=%@&user_credentials=%@",paymentParam.key,paymentParam.userCredentials];
        NSLog(@"-->>OneTap Token Post Param = %@",postParam);
        //set request content type we MUST set this value.
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        //set post data of request
        [request setHTTPBody:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                callBackForGetOneTapTokenDictionary(nil ,error.localizedDescription);
            }
            else
            {
                NSDictionary *hashDictionary = [NSDictionary new];
                NSError *serializationError;
                hashDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
                if (serializationError) {
                    callBackForGetOneTapTokenDictionary(nil ,serializationError.localizedDescription);
                }
                else if([[hashDictionary valueForKey:@"message"] isEqualToString:@"Merchant hash fetched successfully"]){
                    NSArray *arrayOfData = [hashDictionary valueForKey:@"data"];
                    NSMutableDictionary *dictOfCardToken = [NSMutableDictionary new];
                    for (NSArray * eachToken in arrayOfData) {
                        NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[eachToken objectAtIndex:1],[eachToken objectAtIndex:0], nil];
                        [dictOfCardToken addEntriesFromDictionary:dict];
                    }
                    callBackForGetOneTapTokenDictionary(dictOfCardToken,nil);
                }
                else{
                    callBackForGetOneTapTokenDictionary(nil,[hashDictionary valueForKey:@"message"]);
                }
            }
            
        }] resume];

    
}

-(void)deleteOneTapTokenForCardToken:(NSString *) cardToken withCompletionBlock: (completionBlockForDeleteOneTapToken) completionBlock{
    void(^callBackForDeleteOneTapToken)(NSString *message, NSString *errorString) = completionBlock;

        NSURL *URL = [NSURL URLWithString:@"https://payu.herokuapp.com/delete_merchant_hash"];
        // create the request
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:60.0];
        // Specify that it will be a POST request
        request.HTTPMethod = @"POST";
        NSString *postParam = [NSString stringWithFormat:@"card_token=%@",cardToken];
        NSLog(@"-->>Token Post Param = %@",postParam);
        //set request content type we MUST set this value.
        [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        //set post data of request
        [request setHTTPBody:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                callBackForDeleteOneTapToken(nil,error.localizedDescription);
            }
            else{
                NSDictionary *hashDictionary = [NSDictionary new];
                NSError *serializationError;
                hashDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
                if (serializationError) {
                    callBackForDeleteOneTapToken(nil,serializationError.localizedDescription);
                }
                else if ([[hashDictionary valueForKey:@"message"] isEqual:@"Card Token successfully removed"]){
                    callBackForDeleteOneTapToken([hashDictionary valueForKey:@"message"],nil);
                }
                else{
                    callBackForDeleteOneTapToken(nil,[hashDictionary valueForKey:@"message"]);
                }
            }
        }] resume];

    
}

-(void)saveOneTapTokenForMerchantKey:(NSString *) key withCardToken:(NSString *) cardToken withUserCredential:(NSString *) userCred andMerchantHash:(NSString *) merchantHash withCompletionBlock: (completionBlockForDeleteOneTapToken) completionBlock{
    void(^callBackForSaveOneTapToken)(NSString *message, NSString *errorString) = completionBlock;

    NSURL *URL = [NSURL URLWithString:@"https://payu.herokuapp.com/store_merchant_hash"];
    // create the request
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL
                                                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                     timeoutInterval:60.0];
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    NSString *postParam = [NSString stringWithFormat:@"merchant_key=%@&user_credentials=%@&card_token=%@&merchant_hash=%@)",key,userCred,cardToken,merchantHash];
    //set request content type we MUST set this value.
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //set post data of request
    [request setHTTPBody:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            callBackForSaveOneTapToken(nil,error.localizedDescription);
        }
        else{
            NSDictionary *hashDictionary = [NSDictionary new];
            NSError *serializationError;
            hashDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serializationError];
            if (serializationError) {
                callBackForSaveOneTapToken(nil,serializationError.localizedDescription);
            }
            else if ([[hashDictionary valueForKey:@"message"] isEqual:@"Card token and merchant hash successfully added"]){
                callBackForSaveOneTapToken([hashDictionary valueForKey:@"message"],nil);
            }
            else{
                callBackForSaveOneTapToken(nil,[hashDictionary valueForKey:@"message"]);
            }
        }
    }] resume];


}

@end
