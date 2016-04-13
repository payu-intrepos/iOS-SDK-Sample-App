//
//  PUUICCDCVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUICCDCVC.h"
#import "PUUIUtility.h"
#import "AppDelegate.h"

#pragma mark - Macros

#define PADDING_BETWEEN_MONTH_AND_YEAR_COMPONENT_PICKER  100

@interface PUUICCDCVC ()<UIPickerViewDataSource, UIPickerViewDelegate>

{
    NSString * cardIssuer;
    BOOL validCardNumber, validCVV, validIssuer, saveCardFlag, isPickerShown,isCVVEditingBegin, OneTapFlag, isSMAE;
    PayUValidations *SDKValidations;
    NSMutableArray *arrMonth, *arrYear;
    NSString *selectedYear, * selectedMonth, *currentYear, * currentMonth;
    UIPickerView *MonthYearPickerView;
    BOOL isKBOnScreen;
    NSString *previousTextFieldContent;
    UITextRange *previousSelection;
}
@property (weak,nonatomic) NSNumber *cardMaxLength;
@property (weak,nonatomic) NSNumber *cVVMaxLength;

@property (weak, nonatomic) IBOutlet UILabel *lblForVASMessage;

@property (weak, nonatomic) IBOutlet UITextField *txtFieldCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldMonth;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldYear;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldCVV;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldNameOnCard;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldStoreCardName;

@property (weak, nonatomic) IBOutlet UIImageView *imgVwCardIssuer;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwValidCVV;
@property (weak, nonatomic) IBOutlet UIView *vwStoredCardTapSection;
@property (weak, nonatomic) IBOutlet UIView *vwStoredCardNameSection;
@property (weak, nonatomic) IBOutlet UIView *vwOneTapSection;

- (IBAction)clickedVwStoredCardSection:(id)sender;
- (IBAction)clickedVwOneTapSection:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSaveCard;
@property (weak, nonatomic) IBOutlet UIButton *btnOneTap;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlVwCCDC;


@property (weak, nonatomic) IBOutlet UIView *viewCardDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblHorizontalLine3;
@property (weak, nonatomic) IBOutlet UILabel *lblHorizontalLine1;
@property (weak, nonatomic) IBOutlet UILabel *lblHorizontalLine2;

@property (weak, nonatomic) IBOutlet UILabel *lblVerticalLine;

@property (strong, nonatomic) UIView *grayView;
@end

@implementation PUUICCDCVC

#pragma mark - UIViewController Delegate

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextFieldDelegate];
    [self dismissKeyboardOnTapOutsideTextField];
    [self initialSetup];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self enableDisablePayNowButton];
    [self addKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:true];
    [self hidePickerView];
    [self removeKeyboardNotifications];
    isKBOnScreen = NO;
}


#pragma mark - Initial Setup

-(void)configureTextFieldDelegate{
    self.txtFieldCardNumber.delegate = self;
    self.txtFieldCVV.delegate = self;
    self.txtFieldMonth.delegate = self;
    self.txtFieldNameOnCard.delegate = self;
    self.txtFieldStoreCardName.delegate = self;
    self.txtFieldYear.delegate = self;
    [self.txtFieldCardNumber addTarget:self
                                action:@selector(reformatAsCardNumber:)
                      forControlEvents:UIControlEventEditingChanged];
}

-(void)initialSetup{
    self.scrollView = self.scrlVwCCDC;
    [self hideVASMessageSection:TRUE];
    
    self.vwOneTapSection.hidden = TRUE;
    self.vwStoredCardNameSection.hidden = TRUE;
    self.imgVwValidCVV.alpha = ALPHA_HALF;
    SDKValidations = [PayUValidations new];
    
    self.viewCardDetail.layer.borderColor = [UIColor payUViewBorderColor].CGColor;
    [self.lblHorizontalLine1 setBackgroundColor:[UIColor payUViewBorderColor]];
    [self.lblHorizontalLine2 setBackgroundColor:[UIColor payUViewBorderColor]];
    [self.lblHorizontalLine3 setBackgroundColor:[UIColor payUViewBorderColor]];
    [self.lblVerticalLine setBackgroundColor:[UIColor payUViewBorderColor]];
    
    if (![PUUIUtility isUserCredentialValid:self.paymentParam.userCredentials]) {
        [self hideSaveCardSection];
    }
}

-(void)hideVASMessageSection:(BOOL) flag{
    self.lblForVASMessage.hidden = flag;
}

-(void)initializeMonthYearPicker{
    NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    if (currentDateComponents.month <= 9) {
        currentMonth = [NSString stringWithFormat:@"0%ld",(long)currentDateComponents.month];
    }
    else{
        currentMonth = [NSString stringWithFormat:@"%ld",(long)currentDateComponents.month];
    }
    currentYear = [NSString stringWithFormat:@"%ld",(long)currentDateComponents.year];
    
    //set months
    arrMonth = [NSMutableArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
    
    //set years
    arrYear = [NSMutableArray new];
    for (int counter = 0; counter < 100; counter++) {
        [arrYear addObject:[NSString stringWithFormat:@"%d",[currentYear intValue]+counter]];
    }
    
    NSLog(@"Month Index%lu",(unsigned long)[arrMonth indexOfObject:currentMonth]);
    
    NSLog(@"Year Index%lu",(unsigned long)[arrYear indexOfObject:currentYear]);
    
    MonthYearPickerView = [PUUIUtility showPickerViewWithDelegate:self];
    
    // By default it should select current Month and Yaer
    [MonthYearPickerView selectRow:(unsigned long)[arrMonth indexOfObject:currentMonth] inComponent:0 animated:true];
    [MonthYearPickerView selectRow:(unsigned long)[arrYear indexOfObject:currentYear] inComponent:1 animated:true];
    selectedMonth =currentMonth;
    selectedYear = currentYear;
}

#pragma mark - UIPickerView Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSLog(@"selected month%@",[arrMonth objectAtIndex:row]);
        selectedMonth = [arrMonth objectAtIndex:row];
    }
    else{
        NSLog(@"selected year%@",[arrYear objectAtIndex:row]);
        selectedYear = [arrYear objectAtIndex:row];
    }
}

#pragma mark - UIPickerView DataSource

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return arrMonth.count;
    }
    else{
        return arrYear.count;
    }
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [arrMonth objectAtIndex:row];
    }
    else{
        return [arrYear objectAtIndex:row];
    }
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return PADDING_BETWEEN_MONTH_AND_YEAR_COMPONENT_PICKER;
}

#pragma mark - UIUtilsPickerView Delegate

- (void)clickedBtnCancelToPicker:(id)sender
{
    [self hidePickerView];
}

- (void)clickedBtnDoneToPicker:(id)sender
{
    [self hidePickerView];
    self.txtFieldMonth.text = selectedMonth;
    self.txtFieldYear.text = selectedYear;
    self.paymentParam.expiryMonth = self.txtFieldMonth.text;
    self.paymentParam.expiryYear = self.txtFieldYear.text;
    [self enableDisablePayNowButton];
    
}


#pragma mark - UITextField delegate methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.txtFieldMonth || textField == self.txtFieldYear) {
        if (!self.grayView) {
            self.grayView = [[UIView alloc] initWithFrame:APP_DELEGATE.window.frame];
            self.grayView.alpha = .5;
            self.grayView.backgroundColor = [UIColor grayColor];
            [APP_DELEGATE.window addSubview:self.grayView];
        }
        else{
            [self.grayView setHidden:NO];
        }
        [self initializeMonthYearPicker];
        [self dismissKeyboard];
        self.txtFieldActive = textField;
        return NO;
    }
    if (self.txtFieldActive == self.txtFieldMonth || self.txtFieldActive == self.txtFieldYear){
        [self hidePickerView];
        
    }
    self.txtFieldActive = textField;
    textField.inputAccessoryView = [self addDoneBtnOnKeyboard];
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.txtFieldCardNumber) {
        if (!validCardNumber && ![textField.text isEqual:@""]) {
            self.imgVwCardIssuer.image = [UIImage imageNamed:imgErrorIcon];
        }
    }
    
    [self enableDisablePayNowButton];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger nextTag = textField.tag + 1;
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    return true;
}
-(void)reformatAsCardNumber:(UITextField *)textField
{
    // In order to make the cursor end up positioned correctly, we need to
    // explicitly reposition it after we inject spaces into the text.
    // targetCursorPosition keeps track of where the cursor needs to end up as
    // we modify the string, and at the end we set the cursor position to it.
    NSUInteger targetCursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    
    NSString *cardNumberWithoutSpaces =
    [self removeNonDigits:textField.text
andPreserveCursorPosition:&targetCursorPosition];
    
    if ([cardNumberWithoutSpaces length] > 19) {
        // If the user is trying to enter more than 19 digits, we prevent
        // their change, leaving the text field in  its previous state.
        // While 16 digits is usual, credit card numbers have a hard
        // maximum of 19 digits defined by ISO standard 7812-1 in section
        // 3.8 and elsewhere. Applying this hard maximum here rather than
        // a maximum of 16 ensures that users with unusual card numbers
        // will still be able to enter their card number even if the
        // resultant formatting is odd.
        [textField setText:previousTextFieldContent];
        textField.selectedTextRange = previousSelection;
        return;
    }
    
    NSString *cardNumberWithSpaces =
    [self insertSpacesEveryFourDigitsIntoString:cardNumberWithoutSpaces
                      andPreserveCursorPosition:&targetCursorPosition];
    
    textField.text = cardNumberWithSpaces;
    UITextPosition *targetPosition =
    [textField positionFromPosition:[textField beginningOfDocument]
                             offset:targetCursorPosition];
    
    [textField setSelectedTextRange:
     [textField textRangeFromPosition:targetPosition
                           toPosition:targetPosition]
     ];
}
/*
 Removes non-digits from the string, decrementing `cursorPosition` as
 appropriate so that, for instance, if we pass in `@"1111 1123 1111"`
 and a cursor position of `8`, the cursor position will be changed to
 `7` (keeping it between the '2' and the '3' after the spaces are removed).
 */
- (NSString *)removeNonDigits:(NSString *)string
    andPreserveCursorPosition:(NSUInteger *)cursorPosition
{
    NSUInteger originalCursorPosition = *cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    for (NSUInteger i=0; i<[string length]; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        if (isdigit(characterToAdd)) {
            NSString *stringToAdd =
            [NSString stringWithCharacters:&characterToAdd
                                    length:1];
            
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    
    return digitsOnlyString;
}

/*
 Inserts spaces into the string to format it as a credit card number,
 incrementing `cursorPosition` as appropriate so that, for instance, if we
 pass in `@"111111231111"` and a cursor position of `7`, the cursor position
 will be changed to `8` (keeping it between the '2' and the '3' after the
 spaces are added).
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string
                          andPreserveCursorPosition:(NSUInteger *)cursorPosition
{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i=0; i<[string length]; i++) {
        if ((i>0) && ((i % 4) == 0)) {
            [stringWithAddedSpaces appendString:@" "];
            if (i < cursorPositionInSpacelessString) {
                (*cursorPosition)++;
            }
        }
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd =
        [NSString stringWithCharacters:&characterToAdd length:1];
        
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    
    return stringWithAddedSpaces;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * trimmedText;
    trimmedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"Trimmed text %@",trimmedText);
    
    if (textField == self.txtFieldCardNumber) {
        previousTextFieldContent = textField.text;
        previousSelection = textField.selectedTextRange;
        trimmedText =[trimmedText stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"Trimmed text %@",trimmedText);
        
        if ([self validateCardNumber:trimmedText]) {
            [self validateCVV:self.txtFieldCVV.text];
        }
        else{
            return NO;
        }
    }
    
    if (textField == self.txtFieldCVV) {
        if (![self validateCVV:trimmedText]) {
            return NO;
        }
    }
    
    if (textField == self.txtFieldNameOnCard) {
        self.paymentParam.nameOnCard = trimmedText;
    }
    return true;
}

-(BOOL)validateCVV:(NSString *) CVV{
    
    if (CVV.length > [self.cVVMaxLength intValue] || ![SDKValidations isNumeric:CVV]) {
        return NO;
    }
    if (![cardIssuer isEqual:ERROR_CARD_NUMBER_IS_INVALID] && cardIssuer) {
        if ([[SDKValidations validateCVV:CVV withCardNumber:self.paymentParam.cardNumber] isEqual:@""]) {
            validCVV = YES;
        }
        else{
            validCVV = NO;
        }
    }
    else{
        validCVV = NO;
    }
    
    if (validCVV) {
        self.imgVwValidCVV.alpha = ALPHA_FULL;
    }
    else{
        self.imgVwValidCVV.alpha = ALPHA_HALF;
    }
    self.paymentParam.CVV = CVV;
    return YES;
}

-(BOOL)validateCardNumber:(NSString *)cardNumber{
    cardIssuer = [SDKValidations getIssuerOfCardNumber:cardNumber];
    if (cardNumber.length > [self.cardMaxLength intValue] || ![SDKValidations isNumeric:cardNumber]) {
        return NO;
    }
    if ([cardNumber isEqual:@""]) {
        [self clearTFMonthYearCVV];
    }
    if ([cardIssuer isEqual:ERROR_CARD_NUMBER_IS_INVALID]) {
        validIssuer = NO;
        validCardNumber = NO;
        if (cardNumber.length < 6){
            self.imgVwCardIssuer.image = [UIImage imageNamed:imgCard];
        }
        else{
            self.imgVwCardIssuer.image = [UIImage imageNamed:imgErrorIcon];
        }
    }
    else{
        validIssuer = TRUE;
        if ([[SDKValidations validateCardNumber:cardNumber] isEqual:@""]) {
            validCardNumber = YES;
        }
        else{
            validCardNumber = NO;
        }
        if ((cardNumber.length == [self.cardMaxLength intValue]) && !validCardNumber) {
            self.imgVwCardIssuer.image = [UIImage imageNamed:imgErrorIcon];
        }
        else{
            self.imgVwCardIssuer.image = [UIImage imageNamed:[PUUIUtility getNameOfImageForCardIssuer:cardIssuer]];
        }

    }
    if ([cardIssuer isEqual:ISSUER_SMAE]) {
        isSMAE = YES;
    }
    else{
        isSMAE = NO;
    }
    self.paymentParam.cardNumber = cardNumber;
    return TRUE;
}

-(void)hideTFMonthYearCVV:(BOOL) flag{
    self.txtFieldMonth.hidden = flag;
    self.txtFieldYear.hidden = flag;
    self.txtFieldCVV.hidden = flag;
}

-(void)clearTFMonthYearCVV{
    self.txtFieldMonth.text = @"";
    self.txtFieldYear.text = @"";
    self.txtFieldCVV.text = @"";
    validCVV = NO;
}


#pragma mark - IBAction methods

- (IBAction)clickedVwStoredCardSection:(id)sender {
    [self toggleSaveCardBtn];
}

- (IBAction)clickedVwOneTapSection:(id)sender {
    [self toggleOneTapButton];
}

#pragma mark - Helper Methods

-(void)toggleSaveCardBtn{
    if (saveCardFlag){
        [self.btnSaveCard setImage:[UIImage imageNamed:imgUnCheckedBox] forState:UIControlStateNormal];
        OneTapFlag = YES;
        [self toggleOneTapButton];
    }
    else{
        [self.btnSaveCard setImage:[UIImage imageNamed:imgCheckedBox] forState:UIControlStateNormal];
    }
    self.vwStoredCardNameSection.hidden = saveCardFlag;
    saveCardFlag = !saveCardFlag;
    self.txtFieldStoreCardName.text = @"";
    if (self.paymentParam.OneTapTokenDictionary && saveCardFlag) {
        self.vwOneTapSection.hidden = FALSE;
    }
    else{
        self.vwOneTapSection.hidden = TRUE;
    }
    [self enableDisablePayNowButton];
}

-(void)toggleOneTapButton{
    if (OneTapFlag){
        [self.btnOneTap setImage:[UIImage imageNamed:imgUnCheckedBox] forState:UIControlStateNormal];
    }
    else{
        [self.btnOneTap setImage:[UIImage imageNamed:imgCheckedBox] forState:UIControlStateNormal];
    }
    OneTapFlag = !OneTapFlag;
    [self enableDisablePayNowButton];
}

-(void)enableDisablePayNowButton{
    
    if (!saveCardFlag) {
        self.paymentParam.storeCardName = nil;
    }
    else{
        self.paymentParam.storeCardName = self.txtFieldStoreCardName.text;
    }
    if (OneTapFlag) {
        self.paymentParam.isOneTap = TRUE;
    }
    else{
        self.paymentParam.isOneTap = FALSE;
    }
    if (isSMAE || (validCardNumber && validCVV)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:self.paymentParam];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:nil];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if(IS_IPHONE4)
    {
        if(!isKBOnScreen)
        {
            CGRect rect = APP_DELEGATE.paymentOptionVC.view.frame;
            rect.origin.y -= 100;
            APP_DELEGATE.paymentOptionVC.view.frame = rect;
            isKBOnScreen = YES;
        }
    }
    [super keyboardWasShown:aNotification];
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if(IS_IPHONE4 && isKBOnScreen)
    {
        CGRect rect = APP_DELEGATE.paymentOptionVC.view.frame;
        rect.origin.y += 100;
        APP_DELEGATE.paymentOptionVC.view.frame = rect;
        isKBOnScreen = NO;
    }
    [super keyboardWillBeHidden:aNotification];
}

-(void)hideSaveCardSection{
    self.vwStoredCardTapSection.hidden = TRUE;
    self.vwStoredCardNameSection.hidden = TRUE;
}

-(void)hidePickerView{
    if (self.grayView) {
        [self.grayView setHidden:TRUE];
    }
    [PUUIUtility hidePickerView];
}

#pragma mark - Getter method of card/CVV max length

-(NSNumber *)cardMaxLength{
    return [PUUIUtility getCardLengthForCardIssuer:cardIssuer];
}
-(NSNumber *)cVVMaxLength{
    NSNumber *cVVLength = [PUUIUtility getCVVLengthForCardIssuer:cardIssuer];
    if ([cVVLength intValue] == 0) {
        cVVLength = [NSNumber numberWithInt:3];
    }
    return cVVLength;
}

@end
