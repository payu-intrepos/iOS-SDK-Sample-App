//
//  PUUIStoredCardVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIStoredCardVC.h"
#import "PUUIUtility.h"
#import "AppDelegate.h"
#import "PUUICardOptionVC.h"

#define CVV_MAX_LENGTH 4

static NSString * const CardOptionSegueIdentifier = @"CardOptionSegue";
static NSString * const UnwindCardOptionSegueIdentifier = @"UnwindCardOptionSegue";

@interface PUUIStoredCardVC () <UITextFieldDelegate, CardOptionDelegate>
{
    //    UIPickerView *pickerViewObj;
    PayUModelStoredCard *modelStoredCard;
    NSInteger indexCard;
    BOOL isOneTapCard;
    
}

@property(nonatomic, weak) IBOutlet UIView *viewBG;
@property(nonatomic, weak) IBOutlet UIButton *btnCard;
@property(nonatomic, weak) IBOutlet UITextField *tfCVV;
@property(nonatomic, weak) IBOutlet UIButton *btnOneTap;
@property(nonatomic, weak) IBOutlet UIView *viewOneTap;
@property(nonatomic, weak) IBOutlet UILabel *lblOneTap;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *lineConstraintWidth;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tfCVVConstraintWidth;

@property (weak, nonatomic) IBOutlet UIView *viewVerticalSeparator;

@end

@implementation PUUIStoredCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customInitialization];
    [self initialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addKeyboardNotifications];
    [self enableDisablePayNowButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeKeyboardNotifications];
}

- (void) initialSetup
{
    self.viewBG.layer.borderColor = [UIColor payUViewBorderColor].CGColor;
    [self.viewVerticalSeparator setBackgroundColor:[UIColor payUViewBorderColor]];
}

- (void)customInitialization
{
    self.viewBG.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    //    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickedBtnDone)]];
    [numberToolbar sizeToFit];
    self.tfCVV.inputAccessoryView = numberToolbar;
    
    //    NSLog(@"paymentParam----------%@", self.paymentParam);
//    NSLog(@"arrStoredCards----------%@", self.arrStoredCards);
    
    
    //    indexCard = [PUUIUtility getCardIndex];
    //    arrStoredCards = [NSMutableArray arrayWithArray:self.paymentRelatedDetail.storedCardArray];
    
    if(self.arrStoredCards.count)
    {
        [self cardOptionSelectedWithIndex:0];
    }
}

- (IBAction)clickedBtnCard:(id)sender
{
    [self.tfCVV resignFirstResponder];
    
    //    pickerViewObj = [PUUIUtility showPickerViewWithDelegate:self];
    //    [pickerViewObj selectRow:indexCard inComponent:0 animated:NO];
}

- (IBAction)clickedBtnOneTap:(UIButton *)sender
{
    [self.tfCVV resignFirstResponder];
    
    sender.selected = !sender.selected;
    
    [self enableDisablePayNowButton];
}

- (void)clickedBtnDone
{
    [self.tfCVV resignFirstResponder];
}

- (void)enableDisablePayNowButton
{
    
    BOOL isCVVValid = NO;
    
    if(isOneTapCard)
    {
        isCVVValid = YES;
        
    }
    else if(modelStoredCard && self.tfCVV.text.length)
    {
        PayUValidations *validation = [PayUValidations new];
        NSString *strCVVInfo = [validation validateCVV:self.tfCVV.text withCardNumber:modelStoredCard.cardNo];
        NSLog(@"strCVVInfo-----%@", strCVVInfo);
        
        if(strCVVInfo && [strCVVInfo isEqualToString:@""])
            isCVVValid = YES;
    }
    else
    {
        isCVVValid = NO;
    }
    
    if(modelStoredCard && isCVVValid)
    {
        self.paymentParam.cardToken=modelStoredCard.cardToken;
        self.paymentParam.cardBin=modelStoredCard.cardBin;
        
        
        if(self.paymentParam.OneTapTokenDictionary && isOneTapCard)
        {
            self.paymentParam.oneTapFlag = modelStoredCard.oneTapFlag;
        }
        else if(self.paymentParam.OneTapTokenDictionary && self.btnOneTap.selected)
        {
            self.paymentParam.oneTapFlag = nil;
            self.paymentParam.CVV=self.tfCVV.text;
            self.paymentParam.isOneTap = YES;
        }
        else
        {
            self.paymentParam.oneTapFlag = nil;
            self.paymentParam.CVV=self.tfCVV.text;
            self.paymentParam.isOneTap = NO;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:self.paymentParam];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:nil];
    }
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if(IS_IPHONE4)
    {
        CGRect rect = APP_DELEGATE.paymentOptionVC.view.frame;
        rect.origin.y -= 100;
        APP_DELEGATE.paymentOptionVC.view.frame = rect;
    }
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if(IS_IPHONE4)
    {
        CGRect rect = APP_DELEGATE.paymentOptionVC.view.frame;
        rect.origin.y += 100;
        APP_DELEGATE.paymentOptionVC.view.frame = rect;
    }
}
/*
 #pragma mark - UIPickerView Delegate
 
 - (void)clickedBtnCancelToPicker:(id)sender
 {
 [PUUIUtility hidePickerView];
 }
 
 - (void)clickedBtnDoneToPicker:(id)sender
 {
 indexCard = [pickerViewObj selectedRowInComponent:0];
 
 modelStoredCard=[self.paymentRelatedDetail.storedCardArray objectAtIndex:indexCard];
 [self.btnCard setTitle:modelStoredCard.cardNo forState:UIControlStateNormal];
 [PUUIUtility hidePickerView];
 [self enableDisablePayNowButton];
 }
 
 - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
 return 1;
 }
 
 - (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
 return self.paymentRelatedDetail.storedCardArray.count;
 }
 
 - (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
 
 PayUModelStoredCard *modelStoredCardObj=[self.paymentRelatedDetail.storedCardArray objectAtIndex:row];
 
 NSString *strObj = [NSString stringWithFormat:@"%@ | %@", modelStoredCardObj.cardName, modelStoredCardObj.cardNo];
 return strObj;
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:CardOptionSegueIdentifier]) {
        UINavigationController *nav = [segue destinationViewController];
        PUUICardOptionVC *cardOptionVC = (PUUICardOptionVC *)[nav topViewController];
        cardOptionVC.paymentParam = self.paymentParam;
        cardOptionVC.arrStoredCards = self.arrStoredCards;
        cardOptionVC.delegate = self;
        cardOptionVC.tableViewType = TableViewTypeSC;
        //         cardOptionVC.paymentRelatedDetail = self.paymentRelatedDetail;
        cardOptionVC.cardIndex = indexCard;
    }
}



#pragma mark - Unwind segue

- (IBAction)unwindToStoredCardVC:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[PUUICardOptionVC class]]) {
        //        PUUICardOptionVC *cardOptionVC = segue.sourceViewController;
        //        self.indexPathCard = cardOptionVC.indexPathCrt;
    }
}


#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self enableDisablePayNowButton];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [textField.text stringByReplacingCharactersInRange:range withString:string].length <= CVV_MAX_LENGTH;
}

#pragma mark - CardOptionDelegate method

- (void) cardOptionSelectedWithIndex:(NSInteger)cardIndex
{
    self.tfCVV.text = nil;
    indexCard = cardIndex;
    modelStoredCard = [self.arrStoredCards objectAtIndex:indexCard];
    [self.btnCard setTitle:modelStoredCard.cardNo forState:UIControlStateNormal];
    
    isOneTapCard = [self.paymentRelatedDetail.oneTapStoredCardArray containsObject:modelStoredCard];
    
    
    if(!self.paymentParam.OneTapTokenDictionary)
    {
        self.viewOneTap.hidden = YES;
        self.lblOneTap.hidden = YES;
    }
    else if(isOneTapCard)
    {
        self.lineConstraintWidth.constant = 0;
        self.tfCVVConstraintWidth.constant = 0;
        self.viewOneTap.hidden = YES;
        self.lblOneTap.hidden = NO;
    }
    else
    {
        self.lineConstraintWidth.constant = 1;
        self.tfCVVConstraintWidth.constant = 60;
        self.viewOneTap.hidden = NO;
        self.lblOneTap.hidden = YES;
    }
}
@end
