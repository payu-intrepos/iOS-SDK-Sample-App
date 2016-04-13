//
//  CBUtile.h
//  PayU_iOS_SDK_TestApp
//
//  Created by arunlvn on 10/23/15.
//  Copyright © 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * This class is used for common methods which will be used from any class in Bundle
 */
@interface CBUtile : NSObject

/*!
 * This method is used to store TransactionId to NSUserDefaults.
 * @param [txnID] [NSString type]
 */
+ (void)setTransactionId:(NSString *)txnID;

/*!
 * This method is used to get TransactionId from NSUserDefaults.
 * @return [txnID]              [NSString type]
 * @see    [getNonNilString]
 */
+ (NSString *)getTransactionId;

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
+(NSString *)prepareEventAnalyticsStringWithArray:(NSArray *)arr;

/*!
 * This method is used to get DeviceAnalytics data that has to be send to server.
 * @param   [arr]                     [array stored in plist file]
 * @return  [DeviceAnalyticsString]   [NSString type]
 */
+(NSString *)prepareDeviceAnalyticsStringWithArray:(NSArray *)arr;
//+(void)setSourceOfApproveView:(NSString *)val;
//+(NSString *)getSourceOfApproveView;

/*!
 This method is used to remove the given key from NSUserDefaults
 @param [keyName] [NSString type]
 */
+(void)removeObjectForKey:(NSString *)keyName;

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
 * This method is used to get the Analytics Server url from NSUserDefaults based on AnalyticsServerType
 * @return  [analyticsServerUrl]        [NSString type]
 * @see     [getAnalyticsServerType]
 */
+(NSString *)getAnalyticsServerUrl;

/*!
 * This method is used to set the Analytics Server type to NSUserDefaults
 * * @param [analyticsServerType] [NSString type]
 */
+(void)setAnalyticsServerType:(NSString *)val;

/*!
 * This method is used to get the CB Server url from NSUserDefaults based on CBServerType
 * @return  [analyticsServerUrl] [NSString type - JS file path]
 * @see     [getCBServerType]
 */
+(NSString *)getCBServerUrl:(BOOL)isWKWebView;

/*!
 * This method is used to set the CB Server type to NSUserDefaults
 * @param [cbServerType] [NSString type]
 */
+(void)setCBServerType:(NSString *)val;

/*!
 * This method is used to get merchantKey from NSUserDefaults.
 * @return  [merchantKey]       [NSString type]
 * @see     [getNonNilString]
 */
+(NSString *)getMerchantKey;

/*!
 * This method is used to set merchantKey to NSUserDefaults.
 * @param [merchantKey] [NSString type]
 */
+(void)setMerchantKey:(NSString *)val;

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
+(NSString *)getSDKVersion;

/*!
 * This method is used to get CBVersion from plist file.
 * @return [CBVersion] [NSString type]
 */
+(NSString *)getCBVersion;

/*!
 * This method is returns a string 'nil' if param str is nil or blank
 * @param  [str] [NSString type]
 * @return [str] [NSString type]
 */
+(NSString *)getNonNilString:(NSString *)str;
@end
