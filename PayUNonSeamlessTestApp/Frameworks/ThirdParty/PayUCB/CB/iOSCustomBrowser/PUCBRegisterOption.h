//
//  CBRegisterOption.h
//  SeamlessTestApp
//
//  Created by Sharad Goyal on 18/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

/*!
 * This class is used to show CB for non registered card flow.
 */
#import <UIKit/UIKit.h>
#import "PUCBBaseView.h"

@interface PUCBRegisterOption : PUCBBaseView

/*!
 * This method is used to initialize the view.
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [PUCBRegisterOption type]
 */

- (instancetype)initWithConnectionHandler:(CBConnectionHandler *)handler;

@end
