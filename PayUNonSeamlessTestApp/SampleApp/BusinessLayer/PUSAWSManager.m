//
//  PUSAWSManager.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 04/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUSAWSManager.h"

@implementation PUSAWSManager

+(NSMutableURLRequest *)getURLRequestWithPostParam:(NSString *) postParam withURL:(NSURL *) paramURL{
    NSMutableURLRequest *request;
    request = [NSMutableURLRequest requestWithURL:paramURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    if (postParam) {
        request.HTTPMethod = @"POST";
        [request setHTTPBody:[postParam dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else{
        request.HTTPMethod = @"GET";
    }
    return request;
}

+(void)getWebServiceResponse:(NSMutableURLRequest *) webServiceRequest withCompletionBlock:(completionBlockForWebServiceResponse) completionBlock{
    void(^callBackForWebServiceResponse)(id JSON ,NSString *errorMessage, id extraParam) = completionBlock;
    
    NSURLSession *defaultSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:webServiceRequest completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (error == nil) {
            NSError *parseError = nil;
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            NSLog(@"Response after hitting webService --> %@",object);
            if (parseError == nil) {
                callBackForWebServiceResponse(object,nil,nil);
            }
            else{
                NSLog(@"Parse Error: %@",parseError.localizedDescription);
                callBackForWebServiceResponse(nil,parseError.localizedDescription,nil);
            }
        }
        else{
            NSLog(@"Parse Error: %@",error.localizedDescription);
            callBackForWebServiceResponse(nil,error.localizedDescription,nil);
        }
    }];
    [dataTask resume];
}


@end
