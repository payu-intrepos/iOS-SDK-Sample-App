//
//  CBAllPaymentOption.h
//  iOSCustomeBrowser
//
//  Created by Suryakant Sharma on 17/04/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This class is used to show AllPaymentOption on CB.
 */
#import <UIKit/UIKit.h>
#import "CBConnectionHandler.h"


@interface CBAllPaymentOption : UIView

@property (nonatomic,weak) NSDictionary *bankJS;


@property (unsafe_unretained, nonatomic) IBOutlet UIButton *smsotpBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *passwordBtn;
@property (assign, nonatomic) BOOL isViewOnScreen;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *msgLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *retryLabel;

/*!
 * This method is used to initialize the view and returns its instance.
 * @param  [frame]      [CGRect type]
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [CBAllPaymentOption type]
 */
- (id)initWithFrame:(CGRect)frame andCBConnectionHandler:(CBConnectionHandler *)handler;

/*!
 * This method is used to change x pos of SMSOTP btn when password option is not on bank page.
 */
-(void)changeFrame;

/*!
 * This method is refrenced from SMSOTP btn and logs otp_click event.
 * @see [sendEventAnalyticsDataWithKey - CBFileManager]
 */
-(IBAction)smsOtpButtonClicked:(UIButton *) aButton;

@end
