//
//  PUUIPayUUPIVC.m
//  DoubleConversion
//
//  Created by Ashish Jain on 03/02/20.
//

#import <UIKit/UIKit.h>
#import "PUUIPayUUPIVC.h"
#import <PayUBizCoreKit/PayUBizCoreKit.h>

@interface PUUIPayUUPIVC ()

@end

@implementation PUUIPayUUPIVC 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtFieldActive = self.txtFldUPI;
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
    [self dismissKeyboardOnTapOutsideTextField];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self enableDisablePayNowButton];
}

-(void)enableDisablePayNowButton{
    self.paymentParam.bankCode = @"UPI"; /// Use bankCode "UPITPV" for TPV txn.
    if ([[[PayUValidations alloc] init] isValidVPA:self.txtFldUPI.text]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:self.paymentParam];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:nil];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self enableDisablePayNowButton];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.paymentParam.vpa = self.txtFldUPI.text;
    [self enableDisablePayNowButton];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.txtFieldActive = textField;
    textField.inputAccessoryView = [self addDoneBtnOnKeyboard];
    return YES;
}

-(UIToolbar *)addDoneBtnOnKeyboard{
    UIToolbar *toolbar = [UIToolbar new];
    //setting Toolbar properties
    toolbar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 30);
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneBarButtonTapped)];
    UIBarButtonItem *fixedSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceButton.width = 10.0;
    UIBarButtonItem *flexibleSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = [NSArray arrayWithObjects:flexibleSpaceButton, doneButton, fixedSpaceButton, nil];
    [toolbar sizeToFit];
    return toolbar;
}

-(void)doneBarButtonTapped{
    [self dismissKeyboard];
}

@end
