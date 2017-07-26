//
//  PUSAUtils.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 5/2/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUSAUtils.h"

@implementation PUSAUtils

+(NSURLRequest *)getNSURLRequestForLocalBankSimulator{
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSURL *homeIndexUrl = [mainBundle URLForResource:@"bank" withExtension:@"html"];
    
    
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"bank" ofType:@"html" inDirectory:@"BankSimulator"]]];

    return urlReq;
}

@end
