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
#import "CBConnectionHandler.h"

@interface CBRegisterOption : UIView

/*!
 * This method returns CBRegisterOption instance.
 * @return [obj] [CBRegisterOption type]
 */
-(id)getInstance;

/*!
 * This method sets bankImage and adds SwipeGestures to view.
 * @param [handler] [CBConnectionHandler type]
 */
-(void)initialSetUpWithHandler:(CBConnectionHandler *)handler;

@end
