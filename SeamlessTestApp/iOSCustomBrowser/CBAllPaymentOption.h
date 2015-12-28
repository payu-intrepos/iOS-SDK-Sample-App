//
//  CBAllPaymentOption.h
//  iOSCustomeBrowser
//
//  Created by Suryakant Sharma on 17/04/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBConnectionHandler.h"


@interface CBAllPaymentOption : UIView

@property (nonatomic,weak) NSDictionary *bankJS;
@property (nonatomic,weak) UIWebView *resultView;
@property (nonatomic,weak) CBConnectionHandler *handler;
@property (assign, nonatomic) BOOL isViewOnScreen;
@property (weak, nonatomic) IBOutlet UILabel *lblPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblSMSOTP;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *smsotpBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *passwordBtn;


@property (unsafe_unretained, nonatomic) IBOutlet UILabel *msgLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *retryLabel;

- (id)initWithFrame:(CGRect)frame andCBConnectionHandler:(CBConnectionHandler *)handler;

-(void)changeFrame;

-(IBAction)smsOtpButtonClicked:(UIButton *) aButton;



@end
