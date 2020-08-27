//
//  PUUIBaseVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIBaseVC.h"
//#import "AppDelegate.h"

@interface PUUIBaseVC ()

@end

@implementation PUUIBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.internetReachability = [PUUIReachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
//    CGRect rect = APP_DELEGATE.paymentOptionVC.view.frame;
//    rect.origin.y = 64;
//    APP_DELEGATE.paymentOptionVC.view.frame = rect;
}
-(BOOL)isInternetAvailable{
    NetworkStatus currentStatus = [self.internetReachability currentReachabilityStatus];
    if (currentStatus == NotReachable) {
        return NO;
    }
    else{
        return YES;
    }
    
}


#pragma Keyboard notification add or remove

-(void)addKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 // Called when the UIKeyboardDidShowNotification is sent.
 - (void)keyboardWasShown:(NSNotification*)aNotification
 {
 NSDictionary* info = [aNotification userInfo];
 CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
 
 CGRect rect = APP_DELEGATE.paymentOptionVC.view.frame;
 rect.origin.y -= kbSize.height;
 APP_DELEGATE.paymentOptionVC.view.frame = rect;
 }
 */

/*
 // Called when the UIKeyboardWillHideNotification is sent
 - (void)keyboardWillBeHidden:(NSNotification*)aNotification
 {
 NSDictionary* info = [aNotification userInfo];
 CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
 
 CGRect rect = APP_DELEGATE.paymentOptionVC.view.frame;
 rect.origin.y += kbSize.height;
 APP_DELEGATE.paymentOptionVC.view.frame = rect;
 }
 */

#pragma Keyboard delegate methods

// Called when the UIKeyboardDidShowNotification is received
- (void)keyboardWasShown:(NSNotification *)aNotification
{
 /*
    // keyboard frame is in window coordinates
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardInfoFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // get the height of the keyboard by taking into account the orientation of the device too
    CGRect windowFrame = [self.view.window convertRect:self.view.frame fromView:self.view];
    CGRect keyboardFrame = CGRectIntersection (windowFrame, keyboardInfoFrame);
    CGRect coveredFrame = [self.view.window convertRect:keyboardFrame toView:self.view];
    
    // add the keyboard height to the content insets so that the scrollview can be scrolled
    UIEdgeInsets contentInsets = UIEdgeInsetsMake (0.0, 0.0, coveredFrame.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // make sure the scrollview content size width and height are greater than 0
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
    
    // scroll to the text view
    [self.scrollView scrollRectToVisible:self.txtFieldActive.superview.frame animated:YES];
     */
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height+0, 0.0);
    self.scrollView.contentInset = contentInsets;
    
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    int height = self.txtFieldActive.superview.frame.origin.y;
    CGPoint point = CGPointMake(self.txtFieldActive.frame.origin.x, height + self.txtFieldActive.frame.origin.y);
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, point) ) {
        CGRect rect = self.txtFieldActive.frame;
        rect.origin.y = height + self.txtFieldActive.frame.origin.y;
        [self.scrollView scrollRectToVisible:rect animated:YES];
    }
    
}

// Called when the UIKeyboardWillHideNotification is received
- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    // scroll back..
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}



#pragma Dismiss Keyboard On Tap Outside TextField

-(void)dismissKeyboardOnTapOutsideTextField{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.view endEditing:NO];
    //    [self.txtFieldActive resignFirstResponder];
}

@end
