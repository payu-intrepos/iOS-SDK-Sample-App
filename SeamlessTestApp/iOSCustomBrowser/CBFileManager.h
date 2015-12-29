//
//  CBFileManager.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Sharad Goyal on 16/10/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBFileManager : NSObject

//+(void)writeAnalyticsDataToFileWithName:(NSString *)fileName andDict:(NSDictionary *)dict;
+(void)sendDeviceAnalyticsData;
+(void)sendEventAnalyticsDataWithKey:(NSString *)keyName andValue:(NSString *)value andBank:(NSString *)bankName;
+(void)cancelTimer;
@end
