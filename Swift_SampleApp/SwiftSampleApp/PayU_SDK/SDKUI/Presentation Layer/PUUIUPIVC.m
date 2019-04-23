//
//  PUUIUPIVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Vipin Aggarwal on 17/12/18.
//  Copyright © 2018 PayU. All rights reserved.
//

#import "PUUIUPIVC.h"

@interface PUUIUPIVC ()
@property (weak, nonatomic) IBOutlet UITextField *vpaTextField;

@end

@implementation PUUIUPIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dismissKeyboardOnTapOutsideTextField];
    self.vpaTextField.inputAccessoryView = [self addDoneBtnOnKeyboard];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSString * vpa = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"Trimmed text %@",vpa);
    [self enableDisablePayNowButtonForVPA:vpa];

    return true;
}

-(void)enableDisablePayNowButtonForVPA:(NSString*)vpa {
    PayUValidations *validator = [[PayUValidations alloc] init];
    if ([validator isValidVPA:vpa] ) {
        self.paymentParam.vpa = vpa;
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:self.paymentParam];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:nil];
    }
}


@end
