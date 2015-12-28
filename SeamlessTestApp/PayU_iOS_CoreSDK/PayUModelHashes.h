//
//  PayUModelHashes.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 29/09/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayUModelHashes : NSObject <NSCopying>

@property (strong, nonatomic) NSString * paymentHash;
@property (strong, nonatomic) NSString * paymentRelatedDetailsHash;
@property (strong, nonatomic) NSString * VASForMobileSDKHash;
@property (strong, nonatomic) NSString * deleteUserCardHash;
@property (strong, nonatomic) NSString * editUserCardHash;
@property (strong, nonatomic) NSString * saveUserCardHash;
@property (strong, nonatomic) NSString * getUserCardHash;
@property (strong, nonatomic) NSString * offerHash;

/*
 
 get_merchant_ibibo_codes_hash"
 payment_hash"
 vas_for_mobile_sdk_hash"
 delete_user_card_hash"
 edit_user_card_hash"
 save_user_card_hash"
 payment_related_details_for_mobile_sdk_hash"
 get_user_cards_hash"
 check_offer_status_hash"
 */

@end
