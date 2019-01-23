//
//  PUUIUPIViewController.m
//  PayUNonSeamlessTestApp
//
//  Created by Ashish Kumar on 1/23/19.
//  Copyright © 2019 PayU. All rights reserved.
//

#import "PUUIUPIViewController.h"


@interface PUUIUPIViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtUPI;

@end

@implementation PUUIUPIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self enableDisablePayNowButton];
  //  self.txtUPI.delegate = self;
    [self.txtUPI setDelegate:self];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
   
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    
}
-(void)enableDisablePayNowButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:self.paymentParam];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{// return NO to disallow editing.
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}// became first responder
// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called



- (void)textFieldDidEndEditing:(UITextField *)textField
{

    self.paymentParam.vpa = self.txtUPI.text;
    [self enableDisablePayNowButton];
    
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldEndEditing");
   
    
    return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
//    [self.view endEditing:true];
    //[textField setHidden:YES];
    [self.view endEditing:true];
    return YES;
}

@end
