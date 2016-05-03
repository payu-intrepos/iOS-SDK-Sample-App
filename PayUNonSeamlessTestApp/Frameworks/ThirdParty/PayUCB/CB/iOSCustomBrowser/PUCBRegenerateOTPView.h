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
#import "PUCBBaseView.h"

@interface PUCBRegenerateOTPView : PUCBBaseView

@property (weak, nonatomic) IBOutlet UILabel *lblRetry;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

/*!
 * This method is used to initialize the view.
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [PUCBRegenerateOTPView type]
 */
- (instancetype)initWithConnectionHandler:(CBConnectionHandler *)handler;

@end
