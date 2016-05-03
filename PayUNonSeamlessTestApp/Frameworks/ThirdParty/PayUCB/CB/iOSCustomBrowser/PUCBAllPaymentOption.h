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
#import "PUCBBaseView.h"


@interface PUCBAllPaymentOption : PUCBBaseView

@property (weak, nonatomic) IBOutlet UIButton *btnOTP;
@property (weak, nonatomic) IBOutlet UIButton *btnPassword;

@property (weak, nonatomic) IBOutlet UILabel *lblMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblRetry;

-(IBAction)clickedBtnOTP:(UIButton *) aButton;

/*!
 * This method is used to initialize the view.
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [CBAllPaymentOption type]
 */
- (instancetype)initWithConnectionHandler:(CBConnectionHandler *)handler;

/*!
 * This method is used to change x pos of SMSOTP btn when password option is not on bank page.
 */
- (void)changeFrame;

@end
