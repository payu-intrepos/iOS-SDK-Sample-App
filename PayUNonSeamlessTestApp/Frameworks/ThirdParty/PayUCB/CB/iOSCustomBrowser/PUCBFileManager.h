//
//  PUCBFileManager.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Sharad Goyal on 16/10/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This class is used to read, write and send Event/Device Analytics data.
 */
#import <Foundation/Foundation.h>

@interface PUCBFileManager : NSObject

/*!
 * This method is used to send DeviceAnalyticsData to Server
 * @see [prepareDeviceAnalyticsDict]
 * @see [writeAnalyticsDataToFileWithName]
 */
+ (void)sendDeviceAnalyticsData;

/*!
 * This method is used to send EventAnalyticsData to Server
 * @param [keyName]                         [NSString type - keyname for Event]
 * @param [value]                           [NSString type - value for Event]
 * @param [bankName]                        [NSString type - bankName for Event]
 * @see [prepareDeviceAnalyticsDict]
 * @see [writeAnalyticsDataToFileWithName]
 */
+ (void)sendEventAnalyticsDataWithKey:(NSString *)keyName andValue:(NSString *)value andBank:(NSString *)bankName;

/*!
 * This method is called from CBConnection to cancel the timer that reads and sends Analytics data.
 */
+ (void)stopEventAnalytics;

/*!
 * This method checks the JS file existance.
 * @param  [path]        [NSString type - Bank Folder Path]
 * @param  [fileName]    [NSString type - JS File Name]
 * @return [YES/NO]      [BOOL type]
 */
+ (BOOL)fileExists:(NSString *)fileName atPath:(NSString *)bankName;

/*!
 * This method writes the downloaded JS to the given path.
 * @param  [path]                     [NSString type - File Path]
 * @param  [bankJS]                   [NSData type - Bank JS that has downloaded from server]
 * @see    [getFolderPath]
 * @see    [deleteDirectoryContentsAtPath]
 */
+ (void) writeBankJS:(NSData *)bankJS atPath:(NSString *)bankName toFile:(NSString *)fileName;

/*!
 * This method reads data from the given path.
 * @param   [filePath]        [NSString type - File Path]
 * @return  [dict]            [NSDictionary type - Cached Bank JS]
 * @see    [getFolderPath]
 */
+ (NSDictionary *)readBankJSFromFile:(NSString *)fileName atPath:(NSString *)bankName;

@end
