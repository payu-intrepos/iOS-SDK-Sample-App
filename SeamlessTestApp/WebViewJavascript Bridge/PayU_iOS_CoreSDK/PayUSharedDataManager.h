//
//  PayUSharedDataManager.h
//  SeamlessTestApp
//
//  Created by Umang Arya on 19/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayUConstants.h"

@interface PayUSharedDataManager : NSObject

+ (instancetype) sharedDataManager;

@property (nonatomic, strong) NSString *errorMessageForVAS;
@property (nonatomic, strong) id JSONForVAS;
@property (nonatomic, strong) NSString *postParam;

@end
