//
//  PUSAStoredCardCarouselVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Vipin Aggarwal on 20/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUUIStoredCardCarouselVC.h"
#import "iCarousel.h"
#import "PUUIStoredCardView.h"
#import "PUUIUtility.h"
#import "iOSDefaultActivityIndicator.h"

//static int const kCVVMaxLength = 4;
static int const kMaxIphoneScreenWidth = 414;


@interface PUUIStoredCardCarouselVC() <iCarouselDataSource, iCarouselDelegate, UITextFieldDelegate, PUUIStoredCardViewDelegate>
{
    PayUModelStoredCard  *_currentModelStoredCard;
    PUUIStoredCardView *_currentStoredCardView;
    NSInteger _currentCardIndex;
    BOOL _isOneTapCard;
}

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UILabel *lblTopScreenMsg;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewCarousel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteCard;


@end

@implementation PUUIStoredCardCarouselVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialSetup];
    [self dismissKeyboardOnTapOutsideTextField];
    [self addKeyboardNotifications];
}


- (void)dealloc {
    [self removeKeyboardNotifications];
}

- (void)initialSetup
{
    self.scrollView = self.scrollViewCarousel;
    [self customiseCarouselProperties];
    [self customisePageControl];
    
    if(self.arrStoredCards.count)
    {
        [self cardOptionSelectedWithIndex:0];
    }
}

- (void)customiseCarouselProperties
{
    //setup iCarousel properties
    self.carousel.dataSource = self;
    self.carousel.delegate = self;
    self.carousel.type = iCarouselTypeCoverFlow;
    self.carousel.bounceDistance = 0.2f;
    self.carousel.pagingEnabled = true;
}

- (void)customisePageControl {
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.numberOfPages = self.arrStoredCards.count;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //setup current carousel view as the initial view which is visible
    if (self.carousel.numberOfItems > 0) {
        _currentStoredCardView = (PUUIStoredCardView*)self.carousel.currentItemView;
    }
    [self enableDisablePayNowButton];
}

#pragma mark - iCarousel DataSource Methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.arrStoredCards.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    PUUIStoredCardView *storedCardView = nil;
    if (view == nil) {
        storedCardView = [[PUUIStoredCardView alloc] init];
    }
    else {
        storedCardView = (PUUIStoredCardView*)view;
    }
    PayUModelStoredCard *card = self.arrStoredCards[index];
    storedCardView.lblCardNumber.text = card.cardNo;
    storedCardView.lblCardName.text = card.cardName;
    storedCardView.lblCardType.text = card.cardMode;
    storedCardView.tfCVV.delegate = self;
    storedCardView.delegate = self;
    
    //Bug here. one tap flag used here should be the gloabl flag _oneTapFlag.
    [self adjustUIForCard:storedCardView ForCardType:[self isOneTapCardAtIndex:index]];
    [self setImagesForCard:card inStoredCardView:storedCardView];
    [self setCVVLengthOfCard:card inStoredCardView:storedCardView];
    [self addDoneButtonOnKeyboardInCardView:storedCardView];
    
    return storedCardView;
}

#pragma mark - Private Methods

- (void)adjustUIForCard:(PUUIStoredCardView*)cardView ForCardType:(BOOL)isOneTap {
    self.lblTopScreenMsg.hidden = isOneTap;
    cardView.lblCVV.hidden = isOneTap;
    cardView.tfCVV.hidden = isOneTap;
    
    //adjust size of card view
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat cardWidth;
    if (screenWidth > kMaxIphoneScreenWidth) {
        //make screen width as big as max iphone width
        screenWidth = kMaxIphoneScreenWidth;
    }
    cardWidth = screenWidth * .80;
    CGRect oldFrame = cardView.frame;
    CGRect newFrame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, cardWidth, oldFrame.size.height);
    cardView.frame = newFrame;
}

- (void)setImagesForCard:(PayUModelStoredCard*)card inStoredCardView:(PUUIStoredCardView*)cardView {
    PayUValidations *validations = [[PayUValidations alloc] init];
    NSString *cardIssuer = [validations getIssuerOfCardNumber:card.cardNo];
    
    //set card brand image
    if ([cardIssuer isEqual:ERROR_CARD_NUMBER_IS_INVALID]) {
        cardView.imgCardBrand.hidden = true;
    }
    else{
        cardView.imgCardBrand.image = [UIImage imageNamed:[PUUIUtility getNameOfImageForCardIssuer:cardIssuer]];
    }
    
    //set card issuing bank image
    NSString *issuingBankImageName = [PUUIUtility getNameOfImageForCardBank:card.issuingBank];
    if (issuingBankImageName == nil) {
        cardView.imgIssuer.hidden = true;
    }
    else {
        cardView.imgIssuer.image = [UIImage imageNamed:issuingBankImageName];
    }
}

-(void)setCVVLengthOfCard:(PayUModelStoredCard*)card inStoredCardView:(PUUIStoredCardView*)cardView{
    PayUValidations *validations = [[PayUValidations alloc] init];
    NSString *cardIssuer = [validations getIssuerOfCardNumber:card.cardNo];
    
    if ([cardIssuer isEqual:ISSUER_AMEX]) {
        cardView.CVVLength = 4;
        cardView.tfCVV.placeholder = @"XXXX";
    }
    else{
        cardView.CVVLength = 3;
        cardView.tfCVV.placeholder = @"XXX";
    }
}


- (void)cardOptionSelectedWithIndex:(NSInteger)cardIndex
{
    if (cardIndex < 0) {
        [self shouldHideAllCardDetail:YES];
        return;
    } else {
        [self shouldHideAllCardDetail:NO];
        _currentStoredCardView = (PUUIStoredCardView*)self.carousel.currentItemView;
        _currentStoredCardView.tfCVV.text = nil;  //clear the CVV
        _currentCardIndex = cardIndex;
        _currentModelStoredCard = [self.arrStoredCards objectAtIndex:_currentCardIndex];
        _isOneTapCard = [self isOneTapCardAtIndex:cardIndex];
        
        if(!self.paymentParam.OneTapTokenDictionary) { //Do we have atleast one oneTapCard?
            [self removeOneClickCheckboxContainer];
        }
        else if(_isOneTapCard){ //Is current card a oneTap?
            [self removeOneClickCheckboxContainer];
        }
        else {
            _currentStoredCardView.viewCheckboxContainer.hidden = NO;
        }
    }
}

- (void)removeOneClickCheckboxContainer {
    [_currentStoredCardView.viewCheckboxContainer removeFromSuperview];
}

- (void)shouldHideAllCardDetail:(BOOL)flag {
    if (flag == YES) {
        _currentStoredCardView.viewCheckboxContainer.hidden = YES;
        self.carousel.hidden = YES;
        self.btnDeleteCard.hidden = YES;
        self.lblTopScreenMsg.text = @"You have no stored cards";
    } else {
        _currentStoredCardView.viewCheckboxContainer.hidden = NO;
        self.carousel.hidden = NO;
        self.btnDeleteCard.hidden = NO;
        self.lblTopScreenMsg.text = @"Please enter your CVV";
    }
}

//As we are empowering merchant to enable/disable one tap setting, we cannot directly read oneTapFlag of paymentParams
//We need to check if card is contained in oneTapStoredCardArray
- (BOOL)isOneTapCardAtIndex:(NSInteger)index {
    PayUModelStoredCard *storedCard = [self.arrStoredCards objectAtIndex:index];
    return [self.paymentRelatedDetail.oneTapStoredCardArray containsObject:storedCard];
}

- (void)enableDisablePayNowButton
{
    BOOL isCVVValid = NO;
    PayUValidations *validations = [[PayUValidations alloc] init];
    NSString *cardIssuer = [validations getIssuerOfCardNumber:_currentModelStoredCard.cardNo];

    if(_isOneTapCard) {
        isCVVValid = YES;
    }
    else if ([cardIssuer isEqual:ISSUER_SMAE]){
        isCVVValid = YES;
    }
    else if(_currentModelStoredCard && (_currentStoredCardView.tfCVV.text.length || _currentStoredCardView.CVVLength == 0)) {
        PayUValidations *validation = [PayUValidations new];
        NSString *strCVVInfo = [validation validateCVV:_currentStoredCardView.tfCVV.text
                                        withCardNumber:_currentModelStoredCard.cardNo];
        if(strCVVInfo && [strCVVInfo isEqualToString:@""])
            isCVVValid = YES;
    }
    else {
        isCVVValid = NO;
    }
    
    if(_currentModelStoredCard && isCVVValid) {
        //As selected card has data and cvv is valid, set the payment parameters now
        [self setPaymentParams];
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:self.paymentParam];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:nil];
    }
    
}

-(void) setPaymentParams {
    self.paymentParam.cardToken = _currentModelStoredCard.cardToken;
    self.paymentParam.cardBin = _currentModelStoredCard.cardBin;
    
    if(self.paymentParam.OneTapTokenDictionary && _isOneTapCard) {
        self.paymentParam.oneTapFlag = _currentModelStoredCard.oneTapFlag;
    }
    else if(self.paymentParam.OneTapTokenDictionary && _currentStoredCardView.btnOneClickCheckout.selected) {
        self.paymentParam.oneTapFlag = nil;
        self.paymentParam.CVV = _currentStoredCardView.tfCVV.text;
        self.paymentParam.isOneTap = YES;
    }
    else {
        self.paymentParam.oneTapFlag = nil;
        self.paymentParam.CVV = _currentStoredCardView.tfCVV.text;
        self.paymentParam.isOneTap = NO;
    }
}

//Read the checkbox on card view and set the oneTap property of payment params.
- (void)setOneTapStatusFromCheckbox {
    self.paymentParam.isOneTap = _currentStoredCardView.btnOneClickCheckout.selected;
}

#pragma mark - Action methods

- (IBAction)deleteStoredCardTapped:(id)sender {
    iOSDefaultActivityIndicator *activityIndicatorObj = [iOSDefaultActivityIndicator new];
    [activityIndicatorObj startAnimatingActivityIndicatorWithSelfView:self.view];
    
    _currentModelStoredCard = [self.arrStoredCards objectAtIndex:self.carousel.currentItemIndex];
    self.paymentParam.cardToken = _currentModelStoredCard.cardToken;
    self.paymentParam.cardBin = _currentModelStoredCard.cardBin;
    
    PayUWebServiceResponse *webServiceResponse = [PayUWebServiceResponse new];
    [webServiceResponse deleteStoredCard:self.paymentParam withCompletionBlock:^(NSString *deleteStoredCardStatus, NSString *deleteStoredCardMessage, NSString *errorMessage, id extraParam) {
        
        [activityIndicatorObj stopAnimatingActivityIndicator];
        if (errorMessage) {
            PAYU_ALERT(@"Error", errorMessage);
        } else {
            [self setEditing:NO animated:YES];
            _currentStoredCardView = (PUUIStoredCardView*)self.carousel.currentItemView;
            [self.arrStoredCards removeObjectAtIndex:self.carousel.currentItemIndex];
            [self.carousel removeItemAtIndex:self.carousel.currentItemIndex animated:YES];
            self.pageControl.numberOfPages = self.arrStoredCards.count;
            self.pageControl.currentPage = self.carousel.currentItemIndex;
            [self cardOptionSelectedWithIndex:self.carousel.currentItemIndex];
            [self enableDisablePayNowButton];            
        }}];
}


#pragma mark - Keyboard Additions

- (void) addDoneButtonOnKeyboardInCardView:(PUUIStoredCardView*)cardView {
    UIToolbar *numberToolbar = [[UIToolbar alloc] init];
    [numberToolbar sizeToFit];
    
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickedBtnDone:)]];
    cardView.tfCVV.inputAccessoryView = numberToolbar;
}

- (void)clickedBtnDone:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}


#pragma mark - UITextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.txtFieldActive = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self enableDisablePayNowButton];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [textField.text stringByReplacingCharactersInRange:range withString:string].length <= _currentStoredCardView.CVVLength;
}

#pragma mark - iCarousel Delegates

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    //If card is swiped, the payment param must have value of currently selected card only.
    [self setOneTapStatusFromCheckbox];
    [self cardOptionSelectedWithIndex:carousel.currentItemIndex];
    self.pageControl.currentPage = carousel.currentItemIndex;
    [self enableDisablePayNowButton];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionSpacing) {
        return 1.0;
    }
    else {
        return value;
    }
}

#pragma mark - PUUIStoredCardView delegates

- (void)didSelectOneTapCheckBoxWithSelectionStatus:(BOOL)isSelected {
    self.paymentParam.isOneTap = isSelected;
    [self enableDisablePayNowButton];
}

@end
