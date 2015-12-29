//
//  ReachabilityManager.h
//  PayU_iOS_SDK
//
//  Created by Point on 2/14/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*
 This class is wrapper over PayUReachability class
 Provides boolean returning reachability helper method
 */

#import <Foundation/Foundation.h>

@class PayUReachability;

@interface PayUReachabilityManager : NSObject

@property (strong, nonatomic) PayUReachability *reachability;

#pragma mark -
#pragma mark Shared Manager
+ (PayUReachabilityManager *)sharedManager;

#pragma mark -
#pragma mark Class Methods
+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;
+(NSString*)currentReachabilityString;
+(NSString*)getNetworkSignalStrength;
@end
