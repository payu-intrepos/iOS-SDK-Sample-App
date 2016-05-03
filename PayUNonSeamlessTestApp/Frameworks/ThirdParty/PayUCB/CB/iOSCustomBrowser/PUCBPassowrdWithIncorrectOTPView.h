//
//  CBPassowrdWithIncorrectOTPView.h
//  SeamlessTestApp
//
//  Created by Sharad Goyal on 04/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

/*!
 * This class is used to show CB when user enters incorrectOTP and there is password and otp both options are on bank page.
 */
#import <UIKit/UIKit.h>
#import "PUCBBaseView.h"

@interface PUCBPassowrdWithIncorrectOTPView : PUCBBaseView

/*!
 * This method is used to initialize the view.
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [PUCBPassowrdWithIncorrectOTPView type]
 */
- (instancetype)initWithConnectionHandler:(id)handler;

@end
