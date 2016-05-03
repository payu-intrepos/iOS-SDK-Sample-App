//
//  CBBankPageLoading.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Suryakant Sharma on 15/05/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This class is used to show intermediate loader on CB.
 */
#import <UIKit/UIKit.h>
#import "PUCBBaseView.h"

@interface PUCBBankPageLoading : PUCBBaseView

/*!
 * This method is used to initialize the view.
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [PUCBBankPageLoading type]
 */
- (instancetype)initWithConnectionHandler:(CBConnectionHandler *)handler;

/*!
 * This method invalidates the timer of circle animation.
 */
- (void)invalidateLoadingTimer;

@end
