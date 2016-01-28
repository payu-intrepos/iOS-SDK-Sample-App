//
//  GZip.h
//  iOSCustomBrowser
//
//  Created by Suryakant Sharma on 21/04/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This is NSData category that is used to zip and unzip the data.
 */
#import <Foundation/Foundation.h>


@interface NSData (GZip)

- (NSData *)gzippedDataWithCompressionLevel:(float)level;

/*!
 * This method compress the NSData.
 * @return [obj]                            [NSDara type]
 * @see    [gzippedDataWithCompressionLevel]
 */
- (NSData *)gzippedData;

/*!
 * This method unzips the NSData.
 * @return [obj]    [NSDara type]
 */
- (NSData *)gunzippedData;

@end