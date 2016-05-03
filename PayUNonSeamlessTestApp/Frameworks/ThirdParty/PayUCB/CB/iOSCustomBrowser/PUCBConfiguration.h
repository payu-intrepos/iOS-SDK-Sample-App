//
//  PUCBSharedDataManager.h
//  PayUNonSeamlessTestApp
//
//  Created by Sharad Goyal on 10/03/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBUtile.h"
#import "CBConstant.h"

/*!
 * This class is used to store some data that is available for all classes.
 */
@interface PUCBConfiguration : NSObject

/*!
 * This method returns singleton object.
 * @return [obj]                [PUCBSharedDataManager Type]
 * @see    [initUniqueInstance]
 */
+(instancetype)getSingletonInstance;

+(instancetype) alloc ATTRIBUTE_ALLOC;
-(instancetype) init  ATTRIBUTE_INIT;
+(instancetype) new   ATTRIBUTE_NEW;
+(instancetype) copy  ATTRIBUTE_INIT;

@property (nonatomic, strong) NSString *merchantKey;
@property (nonatomic, strong) NSString *transactionId;
@property (nonatomic, assign) BOOL isMagicRetry;
@property (nonatomic, assign) BOOL isAutoOTPSelect;
@property (nonatomic, assign) BOOL shouldShowPayULoader;

/*!
 * This method is used to get the Analytics Server url
 * @return  [analyticsServerUrl]                [NSString type]
 * @see     [getAnalyticsServerUrl - CBUtile]
 */
- (NSString *)getAnalyticsServerUrl;

/*!
 * This method is used to get the CB Server url
 * @return  [analyticsServerUrl]        [NSString type - JS file path]
 * @see     [getCBServerUrl - CBUtile]
 */
- (NSString *)getCBServerUrl:(BOOL)isWKWebView;

/*!
 * This method is used to reset all its properties nil.
 */
- (void) resetProperties;

@end

