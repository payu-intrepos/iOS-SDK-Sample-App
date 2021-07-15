//
//  PUVAConfiguration.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 4/11/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUVAConfiguration.h"
#import <PayUBizCoreKit/PayUBizCoreKit.h>

@implementation PUVAConfiguration

-(instancetype)init{
    self = [super init];
    if (self) {
        self.arrAPIName = [NSArray arrayWithObjects:
                           COMMAND_CHECK_OFFER_DETAILS,
                           COMMAND_CHECK_OFFER_STATUS,
                           COMMAND_GET_USER_CARDS,
                           COMMAND_SAVE_USER_CARD,
                           COMMAND_EDIT_USER_CARD,
                           COMMAND_DELETE_USER_CARD,
                           COMMAND_DELETE_ONE_TAP_TOKEN,
                           COMMAND_VAS_FOR_MOBILE_SDK,
                           COMMAND_VERIFY_PAYMENT,
                           COMMAND_CHECK_IS_DOMESTIC,
                           COMMAND_GET_TRANSACTION_INFO,
                           COMMAND_GET_EMI_AMOUNT_ACCORDING_TO_INTEREST,
                           COMMAND_ELIGIBLE_BINS_FOR_EMI,
                           COMMAND_MCP_LOOKUP,
                           nil];
    }
    return self;
}


@end


//"gtKFFx"=>"eCwWELxi", "smsplus"=>"1b1b0", "0MQaQP"=>"13p0PXZk", "PqvxqV"=>"6SPh4Ulq", "obScKz"=>"Ml7XBCdR", "DXOF8m"=>"2Hl5U0En", "WhccBa"=>"UX5K0KvP", "ukgVCk"=>"DzSugFtI"
