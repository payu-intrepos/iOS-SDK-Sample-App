//
//  PayUModelNetBanking.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 09/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayUModelNetBanking : NSObject

@property (strong, nonatomic) NSString * bankID;
@property (strong, nonatomic) NSString * pgID;
@property (strong, nonatomic) NSString * ptPriority;
@property (strong, nonatomic) NSString * showForm;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * bankCode;

@end
/*
 {
 AXIB =             {
 "bank_id" = "<null>";
 pgId = 23;
 "pt_priority" = 3;
 "show_form" = 0;
 title = "AXIS Bank NetBanking";
 };
 BBCB =             {
 "bank_id" = "<null>";
 pgId = 24;
 "pt_priority" = 5;
 "show_form" = 0;
 title = "Bank of Baroda - Corporate Banking";
 };
*/
