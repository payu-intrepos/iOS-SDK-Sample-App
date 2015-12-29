//
//  CBUtile.h
//  PayU_iOS_SDK_TestApp
//
//  Created by arunlvn on 10/23/15.
//  Copyright © 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBUtile : NSObject

+ (void)setTransactionId:(NSString *)txnID;
+ (NSString *)getTransactionId;
+ (NSString *) platformType;
+(NSString *)prepareEventAnalyticsStringWithArray:(NSArray *)arr;
+(NSString *)prepareDeviceAnalyticsStringWithArray:(NSArray *)arr;
+(void)setSourceOfApproveView:(NSString *)val;
+(NSString *)getSourceOfApproveView;
+(void)removeObjectForKey:(NSString *)keyName;

+(NSString *)getAnalyticsServerUrl;
+(void)setAnalyticsServerType:(NSString *)val;

+(NSString *)getCBServerUrl:(BOOL)isWKWebView;
+(void)setCBServerType:(NSString *)val;

+(NSString *)getMerchantKey;
+(void)setMerchantKey:(NSString *)val;

+ (NSString *)urlencode:(NSString *)str;

+(NSString *)getSDKVersion;
+(NSString *)getCBVersion;
@end
