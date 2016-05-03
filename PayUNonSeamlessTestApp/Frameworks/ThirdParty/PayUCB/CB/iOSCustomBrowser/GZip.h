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

/*!
 * This method unzips the NSData.
 * @return [obj]    [NSData type]
 */
- (NSData *)gunzippedData;

@end