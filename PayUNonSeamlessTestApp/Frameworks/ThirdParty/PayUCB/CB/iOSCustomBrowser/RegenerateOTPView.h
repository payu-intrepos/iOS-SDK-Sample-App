//
//  RegenerateOTPView.h
//  iOSCustomBrowser
//
//  Created by Suryakant Sharma on 22/04/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This class is used to show RegenerateOTPView on CB.
 */
#import <UIKit/UIKit.h>
#import "CBConnectionHandler.h"

@interface RegenerateOTPView : UIView

@property (nonatomic,weak) NSDictionary *bankJS;
@property (nonatomic,weak) UIView *resultView;
@property (assign, nonatomic) BOOL isViewOnScreen;
@property(nonatomic,assign) BOOL isRegenAvailable;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *retryLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *msgLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *smsOtpEnterManuallyBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *regenerateOTPBtn;

/*!
 * This method is used to initialize the view and returns its instance.
 * @param  [frame]      [CGRect type]
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [RegenerateOTPView type]
 */
- (id)initWithFrame:(CGRect)frame andCBConnectionHandler:(CBConnectionHandler *)handler;

@end
