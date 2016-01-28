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
#import "CBConnectionHandler.h"
//#import "CBTextField.h"

@interface CBApproveView : UIView

@property (nonatomic,weak) NSDictionary *bankJS;
//@property (nonatomic,weak) UIWebView *resultWebView;
//@property (nonatomic,weak) UIView *resultView;
@property (assign, nonatomic) BOOL isViewOnScreen;
@property (unsafe_unretained, nonatomic) BOOL isRegenAvailable;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL isAutoApproveClick;

// This method is not used need to check.
- (void) RegenerateOTP:(UIButton *) aButton;

/*!
 * this method starts the timer.
 * @see [timerTick]
 */
- (void) startCountDown;

/*!
 * This method is used to initialize the view and returns its instance.
 * @param  [frame]      [CGRect type]
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [CBApproveView type]
 */
- (id)initWithFrame:(CGRect)frame andCBConnectionHandler:(CBConnectionHandler *)handler;

@end
