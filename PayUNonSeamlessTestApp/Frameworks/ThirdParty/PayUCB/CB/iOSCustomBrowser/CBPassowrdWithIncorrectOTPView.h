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
#import "CBConnectionHandler.h"

@interface CBPassowrdWithIncorrectOTPView : UIView

/*!
 * This method returns CBPassowrdWithIncorrectOTPView instance.
 * @return [obj] [CBPassowrdWithIncorrectOTPView type]
 */
-(id)getInstance;

/*!
 * This method sets bankImage and adds SwipeGestures to view.
 * @param [handler] [CBConnectionHandler type]
 */
-(void)initialSetUpWithHandler:(CBConnectionHandler *)handler;

@property (nonatomic,weak) NSDictionary *bankJS;

@end
