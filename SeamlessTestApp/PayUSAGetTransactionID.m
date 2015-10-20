//
//  PayUSAGetTransactionID.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 13/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUSAGetTransactionID.h"

@implementation PayUSAGetTransactionID

-(NSString *) getTransactionIDWithLength:(int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }
    
    return randomString;
}

@end
