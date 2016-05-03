//
//  PUCBWSManager.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 3/11/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBConstant.h"

/*!
 * This class is used to handle WebRequest to communicate with Server.
 */
@interface PUCBWSManager : NSObject

/*!
 * This method returns singleton object.
 * @return [obj]                [WSManager Type]
 * @see    [initUniqueInstance]
 */
+ (instancetype)getSingletonInstance;

typedef void (^completionBlockForWSData)(NSData *data ,NSError *error, id extraParam);

/*!
 * @brief This property is used to avoid concurrent request sending. It helps to avoid duplicacy of Analytics data.
 */
@property (nonatomic) BOOL isProcess;

+(instancetype) alloc ATTRIBUTE_ALLOC;
-(instancetype) init  ATTRIBUTE_INIT;
+(instancetype) new   ATTRIBUTE_NEW;
+(instancetype) copy  ATTRIBUTE_INIT;

/*!
 * This method sends request to server and handles response and gives callback
 * @param [postParam]           [NSString type]
 * @param [paramURL]            [NSString type]
 * @param [completionBlock]     [block to get callback]
 */
- (void)getWSDataWithPostParam:(NSString *) postParam andWithURL:(NSString *) paramURL withCompletionBlock:(completionBlockForWSData) completionBlock;

@end