//
//  CustomActivityIndicator.h
//  CustomActivityIndicator
//
//  Created by Suryakant Sharma on 11/05/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This class is used to show PayU Activity indicator.
 */
#import <UIKit/UIKit.h>
#import "PUCBBaseView.h"

@interface PUCBLoader : PUCBBaseView

/*!
 * This method is used to initialize the view.
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [PUCBLoader type]
 */
- (instancetype)initWithConnectionHandler:(CBConnectionHandler *)handler;

@end
