//
//  CBReachabilityManager.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Sharad Goyal on 20/10/15.
//  Copyright © 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBReachability;

@interface CBReachabilityManager : NSObject

@property (strong, nonatomic) CBReachability *reachability;

#pragma mark -
#pragma mark Shared Manager
+ (CBReachabilityManager *)sharedManager;

#pragma mark Class Methods

+ (BOOL)isReachable;

+(NSString*)currentReachabilityString;

+(NSString *)getNetworkSignalStrength;

@end
