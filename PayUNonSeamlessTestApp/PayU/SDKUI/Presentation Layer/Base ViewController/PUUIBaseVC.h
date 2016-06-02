//
//  PUUIBaseVC.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PUUIConstants.h"
#import "PUUIWrapperPayUSDK.h"
#import "UIColor+PUUIColor.h"
#import "PUUIReachability.h"

#define     PAYUALERT(T,M)                                      dispatch_async(dispatch_get_main_queue(), ^{[[[UIAlertView alloc] initWithTitle:T message:M delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];});

@interface PUUIBaseVC : UIViewController

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UITextField *txtFieldActive;

@property (nonatomic, strong) PayUModelPaymentParams *paymentParam;
@property (nonatomic, strong) PayUModelPaymentRelatedDetail *paymentRelatedDetail;
@property (nonatomic, strong) PUUIReachability *internetReachability;

-(BOOL)isInternetAvailable;
-(void)addKeyboardNotifications;
-(void)removeKeyboardNotifications;
-(void)dismissKeyboardOnTapOutsideTextField;
-(void)dismissKeyboard;

- (void)keyboardWasShown:(NSNotification *)aNotification;
- (void)keyboardWillBeHidden:(NSNotification *)aNotification;

@end
