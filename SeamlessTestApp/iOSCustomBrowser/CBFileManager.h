//
//  CBFileManager.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Sharad Goyal on 16/10/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This class is used to read, write and send Event/Device Analytics data.
 */
#import <Foundation/Foundation.h>

@interface CBFileManager : NSObject

/*!
 * This method is used to send DeviceAnalyticsData to Server
 * @see [prepareDeviceAnalyticsDict]
 * @see [writeAnalyticsDataToFileWithName]
 */
+(void)sendDeviceAnalyticsData;

/*!
 * This method is used to send EventAnalyticsData to Server
 * @param [keyName]                         [NSString type - keyname for Event]
 * @param [value]                           [NSString type - value for Event]
 * @param [bankName]                        [NSString type - bankName for Event]
 * @see [prepareDeviceAnalyticsDict]
 * @see [writeAnalyticsDataToFileWithName]
 */
+(void)sendEventAnalyticsDataWithKey:(NSString *)keyName andValue:(NSString *)value andBank:(NSString *)bankName;

/*!
 * This method is called from CBConnection to cancel the timer that reads and sends Analytics data.
 */
+(void)cancelTimer;
@end
