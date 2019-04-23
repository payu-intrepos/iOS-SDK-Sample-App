//
//  PUSAWSManager.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 04/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUSAWSManager : NSObject

typedef void (^completionBlockForWebServiceResponse)(id JSON ,NSString *errorMessage, id extraParam);

+(NSMutableURLRequest *)getURLRequestWithPostParam:(NSString *) postParam withURL:(NSURL *) paramURL;

+(void)getWebServiceResponse:(NSMutableURLRequest *) webServiceRequest withCompletionBlock:(completionBlockForWebServiceResponse) completionBlock;



@end
