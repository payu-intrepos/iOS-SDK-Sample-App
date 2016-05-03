//
//  CBApproveView.h
//  iOSCustomBrowser
//
//  Created by Suryakant Sharma on 21/04/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This class is used to show CBApproveView on CB at which we enter OTP.
 */

#import <UIKit/UIKit.h>
#import "PUCBBaseView.h"

@interface PUCBApproveView : PUCBBaseView

@property (weak, nonatomic) IBOutlet UILabel *lblTimer;

@property (nonatomic,strong) NSTimer *timer;

/*!
 * This method is used to initialize the view.
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [PUCBApproveView type]
 */
- (instancetype)initWithConnectionHandler:(CBConnectionHandler *)handler;

/*!
 * this method starts the timer.
 * @see [timerTick]
 */
- (void)startCountDown;

@end
