//
//  CBUtile.h
//  PayU_iOS_SDK_TestApp
//
//  Created by arunlvn on 10/23/15.
//  Copyright © 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 * This class is used for common methods which will be used from any class in Bundle
 */
@interface CBUtile : NSObject

/*!
 * This method is used to get paltformType of iOS device.
 * @return [platform] [NSString type]
 */
+ (NSString *) platformType;

/*!
 * This method is used to get EventAnalytics data that has to be send to server.
 * @param   [arr]                     [array stored in plist file]
 * @return  [EventAnalyticsString]    [NSString type]
 */
+ (NSString *)prepareEventAnalyticsStringWithArray:(NSArray *)arr;

/*!
 * This method is used to get DeviceAnalytics data that has to be send to server.
 * @param   [arr]                     [array stored in plist file]
 * @return  [DeviceAnalyticsString]   [NSString type]
 */
+ (NSString *)prepareDeviceAnalyticsStringWithArray:(NSArray *)arr;

/*!
 * This method is used to set Magic Retry url list to NSUserDefaults
 * @param [arr] [NSArray type - conatins url list]
 */
+ (void)setMRUrlList:(NSArray *)arr;

/*!
 * This method is used to get Magic Retry url list from NSUserDefaults
 * @return [urlList] [NSArray type]
 */
+ (NSArray *)getMRUrlList;

/*!
 * This method is used to set PG url list to NSUserDefaults
 * @param [arr] [NSArray type - conatins url list]
 */
+ (void)setPGUrlList:(NSArray *)arr;

/*!
 * This method is used to get PG url list from NSUserDefaults
 * @return [urlList] [NSArray type]
 */
+ (NSArray *)getPGUrlList;

/*!
 * This method is used to encode the string (url) in the format that is accepted by the server.
 * @param   [str]           [NSString type]
 * @return  [encodedString] [NSString type]
 */
+ (NSString *)urlencode:(NSString *)str;

/*!
 * This method is used to get SDKVersion from plist file.
 * @return [SDKVersion] [NSString type]
 */
+ (NSString *)getSDKVersion;

/*!
 * This method is used to get CBVersion from plist file.
 * @return [CBVersion] [NSString type]
 */
+ (NSString *)getCBVersion;

/*!
 * This method returns a string 'nil' if param str is nil or blank
 * @param  [str] [NSString type]
 * @return [str] [NSString type]
 */
+ (NSString *)getStringForNilValue:(NSString *)str;

/*!
 * This method returns reachability status.
 * @return [YES/NO]                                     [BOOL type]
 * @see    [currentReachabilityStatus - CBReachability]
 */
+ (BOOL)isReachable;

/*!
 * This method returns the network signal strength.
 * @return [network strength]   [NSString type]
 */
+ (NSString *)getNetworkSignalStrength;

/*!
 * This method returns the reachability source WIFI / Cellular 
 * @return [reachability source]                        [NSString type]
 * @see    [currentReachabilityStatus - CBReachability]
 */
+ (NSString*)currentReachabilitySource;

/*!
 * This method is used to get the Analytics Server url.
 * @return  [analyticsServerUrl]        [NSString type]
 */
+ (NSString *)getAnalyticsServerUrl;

/*!
 * This method is used to get the CB Server url for JS.
 * @return  [analyticsServerUrl] [NSString type - JS file path]
 */
+ (NSString *)getCBServerUrl:(BOOL)isWKWebView;
@end
