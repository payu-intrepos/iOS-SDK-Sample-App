//
//  CBReachabilityManager.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Sharad Goyal on 20/10/15.
//  Copyright © 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBReachability;

/*!
 * This class is used to interact with CBReachability class methods.
 */
@interface CBReachabilityManager : NSObject

@property (strong, nonatomic) CBReachability *reachability;

#pragma mark -
#pragma mark Shared Manager
/*!
 * This method is used to get singleton instance of CBReachabilityManager.
 * @return [obj] [CBReachabilityManager type]
 */
+ (CBReachabilityManager *)sharedManager;

#pragma mark Class Methods

/*!
 * This method is used to get network status.
 * @return  [NO/YES]                        [BOOL type]
 * @see     [sharedManager]
 * @see     [reachability - CBReachability]
 * @see     [isReachable - CBReachability]       
 */
+ (BOOL)isReachable;

/*!
 * This method is used to get network reachability string by which it is connected.
 * @return  [reachabilityString]                        [NSString type]
 * @see     [sharedManager]
 * @see     [reachability - CBReachability]
 * @see     [currentReachabilityString - CBReachability]
 */
+(NSString*)currentReachabilityString;

/*!
 * This method is used to get network strength.
 * @return  [networkStrength]                           [NSString type]
 * @see     [sharedManager]
 * @see     [reachability - CBReachability]
 * @see     [getNetworkSignalStrength - CBReachability]
 */
+(NSString *)getNetworkSignalStrength;

@end
