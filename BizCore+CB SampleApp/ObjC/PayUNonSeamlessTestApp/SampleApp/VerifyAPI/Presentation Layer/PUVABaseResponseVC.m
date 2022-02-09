//
//  PUVABaseResponseVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 4/13/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUVABaseResponseVC.h"
#import "iOSDefaultActivityIndicator.h"
#import "PUVATableVC.h"
#import "PUUIUtility.h"

static NSString * const segueIdentiiferVar1 = @"ResponseToTableBtnVar1";
static NSString * const segueIdentiiferVar2 = @"ResponseToTableBtnVar2";
static NSString * const segueIdentiiferVar3 = @"ResponseToTableBtnVar3";
static NSString * const segueIdentiiferVar4 = @"ResponseToTableBtnVar4";
static NSString * const segueIdentiiferVar5 = @"ResponseToTableBtnVar5";
static NSString * const segueIdentiiferVar6 = @"ResponseToTableBtnVar6";
static NSString * const segueIdentiiferVar7 = @"ResponseToTableBtnVar7";
static NSString * const segueIdentiiferVar8 = @"ResponseToTableBtnVar8";
static NSString * const segueIdentiiferVar9 = @"ResponseToTableBtnVar9";

@interface PUVABaseResponseVC ()
{
    iOSDefaultActivityIndicator *_defaultActivityIndicator;
    PayUWebServiceResponse *_webServiceResponse;
    PayUDontUseThisClass *_hashes;
    PUVATableVC *_tableVC;
    // for offer details
    NSArray *_arrPaymentType;
}
@property (weak, nonatomic) IBOutlet UILabel *lblVar1;
@property (weak, nonatomic) IBOutlet UILabel *lblVar2;
@property (weak, nonatomic) IBOutlet UILabel *lblVar3;
@property (weak, nonatomic) IBOutlet UILabel *lblVar4;
@property (weak, nonatomic) IBOutlet UILabel *lblVar5;
@property (weak, nonatomic) IBOutlet UILabel *lblVar6;
@property (weak, nonatomic) IBOutlet UILabel *lblVar7;
@property (weak, nonatomic) IBOutlet UILabel *lblVar8;
@property (weak, nonatomic) IBOutlet UILabel *lblVar9;


@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar1;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar2;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar3;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar4;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar5;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar6;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar7;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar8;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldVar9;


@property (weak, nonatomic) IBOutlet UIButton *btnVar1;
@property (weak, nonatomic) IBOutlet UIButton *btnVar2;
@property (weak, nonatomic) IBOutlet UIButton *btnVar3;
@property (weak, nonatomic) IBOutlet UIButton *btnVar4;
@property (weak, nonatomic) IBOutlet UIButton *btnVar5;
@property (weak, nonatomic) IBOutlet UIButton *btnVar6;
@property (weak, nonatomic) IBOutlet UIButton *btnVar7;
@property (weak, nonatomic) IBOutlet UIButton *btnVar8;
@property (weak, nonatomic) IBOutlet UIButton *btnVar9;


@property (weak, nonatomic) IBOutlet UIView *vwView1;
@property (weak, nonatomic) IBOutlet UIView *vwView2;
@property (weak, nonatomic) IBOutlet UIView *vwView3;
@property (weak, nonatomic) IBOutlet UIView *vwView4;
@property (weak, nonatomic) IBOutlet UIView *vwView5;
@property (weak, nonatomic) IBOutlet UIView *vwView6;
@property (weak, nonatomic) IBOutlet UIView *vwView7;
@property (weak, nonatomic) IBOutlet UIView *vwView8;
@property (weak, nonatomic) IBOutlet UIView *vwView9;
@property (weak, nonatomic) IBOutlet UIScrollView *vwScrollView;

@end

@implementation PUVABaseResponseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    
    if ([self.responseVCType isEqual:COMMAND_VAS_FOR_MOBILE_SDK]) {
        [self setupForVAS];
    }
    else if ([self.responseVCType isEqual:COMMAND_CHECK_OFFER_STATUS]){
        [self setupForOfferStatus];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_EMI_AMOUNT_ACCORDING_TO_INTEREST]){
        [self setupForGetEMIDetails];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_USER_CARD]){
        [self setupForDeleteUserCard];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_PAYMENT_INSTRUMENT]){
        [self setupForDeleteTokenizedStoredCard];
    }
    else if ([self.responseVCType isEqual:COMMAND_CHECK_OFFER_DETAILS]){
        [self setupForOfferDetails];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_USER_CARDS]){
        [self setupForGetUserCards];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_PAYMENT_INSTRUMENT]){
        [self setupForGetUserCards];
    }
    else if ([self.responseVCType isEqual:COMMAND_VERIFY_PAYMENT]){
        [self setupForVerifyPayment];
    }
    else if ([self.responseVCType isEqual:COMMAND_EDIT_USER_CARD]){
        [self setupForEditUserCard];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_ONE_TAP_TOKEN]){
        [self setupForDeleteOneTapToken];
    }
    else if ([self.responseVCType isEqual:COMMAND_CHECK_IS_DOMESTIC]){
        [self setupForCheckIsDomestic];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_TRANSACTION_INFO]){
        [self setupForGetTransctionInfo];
    }
    else if ([self.responseVCType isEqual:COMMAND_SAVE_USER_CARD]){
        [self setupForSaveUserCard];
    }
    else if ([self.responseVCType isEqual:COMMAND_ELIGIBLE_BINS_FOR_EMI]){
        [self setupForEligibleBinForEMI];
    }
    else if ([self.responseVCType isEqual:COMMAND_MCP_LOOKUP]) {
        [self setupForMCPLookup];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_CHECKOUT_DETAILS]) {
        [self setupForCheckoutDetail];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_PAYMENT_DETAILS]) {
        [self setupForGetPaymentDetails];
    }
}

-(void)setupForGetPaymentDetails {
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    self.vwView3.hidden = FALSE;
    self.vwView4.hidden = FALSE;

    self.lblVar1.text = @"User Credentials";
    self.lblVar2.text = @"Card Token";
    self.lblVar3.text = @"Amount";
    self.lblVar4.text = @"Currency";
    
    self.txtFieldVar1.placeholder = @"JQBlG:abc";
    self.txtFieldVar2.placeholder = @"745d72e2fd9dasd8824fef4e7ed7dac1f";
    self.txtFieldVar3.placeholder = @"10.00";
    self.txtFieldVar4.placeholder = @"INR";

    self.txtFieldVar1.text = self.paymentParam.userCredentials;
    self.txtFieldVar4.text = @"INR";
    
    self.btnVar2.hidden = FALSE;
}

-(void)setupForCheckoutDetail {
    self.vwView1.hidden = FALSE;
    self.lblVar1.text = @"Mobile  Number";
    self.txtFieldVar1.text = @"";
}

-(void)setupForMCPLookup {
    self.vwView1.hidden = FALSE;
    self.lblVar1.text = @"Access Key";
    self.txtFieldVar1.text = @"E5ABOXOWAAZNXB6JEF5Z";
    self.vwView2.hidden = FALSE;
    self.lblVar2.text = @"Secret";
    self.txtFieldVar2.text = @"e425e539233044146a2d185a346978794afd7c66";
}

-(void)dealloc{
    [self removeKeyboardNotifications];
}

-(void)initialSetup{
    _defaultActivityIndicator = [[iOSDefaultActivityIndicator alloc]init];
    _webServiceResponse = [PayUWebServiceResponse new];
    _hashes = [PayUDontUseThisClass new];
    [self dismissKeyboardOnTapOutsideTextField];
    [self addKeyboardNotifications];
    self.scrollView = self.vwScrollView;
    self.navigationItem.title = self.responseVCType;
}

-(void)setupForVAS{
    self.vwView1.hidden = FALSE;
    
    self.lblVar1.text = @"BankCode/CardBin";
    
    self.txtFieldVar1.placeholder = @"AXIB/512345";
}

-(void)setupForOfferStatus{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    self.vwView3.hidden = FALSE;
    
    self.lblVar1.text = @"Offer Key";
    self.lblVar2.text = @"Amount";
    self.lblVar3.text = @"Card Number";
    
    self.txtFieldVar1.placeholder = @"@Offer123";
    self.txtFieldVar2.placeholder = @"100";
    self.txtFieldVar3.placeholder = @"5123456789012346";
}

-(void)setupForGetEMIDetails{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    
    self.lblVar1.text = @"Amount";
    self.lblVar2.text = @"Bank Code";
    
    self.txtFieldVar1.placeholder = @"100";
    self.txtFieldVar2.placeholder = @"EMIA9";
    
}

-(void)setupForDeleteUserCard{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    
    self.btnVar2.hidden = FALSE;
    
    self.lblVar1.text = @"User Cred";
    self.lblVar2.text = @"Stored Card";
    
    self.txtFieldVar1.placeholder = @"merchantKey:customerEmailID";
    self.txtFieldVar2.placeholder = @"Enter card Token";
    
    self.txtFieldVar1.text = self.paymentParam.userCredentials;
}

-(void)setupForDeleteTokenizedStoredCard{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    self.vwView3.hidden = FALSE;
    self.vwView4.hidden = FALSE;

    self.btnVar2.hidden = FALSE;
    
    self.lblVar1.text = @"User Cred";
    self.lblVar2.text = @"Stored Card";
    self.lblVar3.text = @"Network Token";
    self.lblVar4.text = @"Issuer Token";

    self.txtFieldVar1.placeholder = @"merchantKey:customerEmailID";
    self.txtFieldVar2.placeholder = @"Enter Card Token";
    self.txtFieldVar3.placeholder = @"Enter Network Token";
    self.txtFieldVar4.placeholder = @"Enter Issuer Token";

    self.txtFieldVar1.text = self.paymentParam.userCredentials;
}

-(void)setupForOfferDetails{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    self.vwView3.hidden = FALSE;
    self.vwView4.hidden = FALSE;
    
    self.btnVar1.hidden = FALSE;
    self.btnVar2.hidden = FALSE;
    
    self.lblVar1.text = @"Payment Type";
    self.lblVar2.text = @"Token/Bank/CC";
    self.lblVar3.text = @"Offer Key";
    self.lblVar4.text = @"Amount";
    
    self.txtFieldVar1.placeholder = @"Payment type";
    self.txtFieldVar2.placeholder = @"CardToken/BankCode/CardNumber";
    self.txtFieldVar3.placeholder = @"@offerKey";
    self.txtFieldVar4.placeholder = @"100";
    
    _arrPaymentType = [NSArray arrayWithObjects:PAYMENT_PG_STOREDCARD,PAYMENT_PG_ONE_TAP_STOREDCARD,PAYMENT_PG_NET_BANKING,PAYMENT_PG_CCDC, nil];
}

- (IBAction)btnClickedResponse:(id)sender {
    if ([self.responseVCType isEqual:COMMAND_VAS_FOR_MOBILE_SDK]) {
        [self btnClickedVAS];
    }
    else if ([self.responseVCType isEqual:COMMAND_CHECK_OFFER_STATUS]){
        [self btnClickedOfferStatus];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_EMI_AMOUNT_ACCORDING_TO_INTEREST]){
        [self btnClickedGetEMIDetails];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_USER_CARD]){
        [self btnClickedDeleteUserCard];
    }
    else if ([self.responseVCType isEqual:COMMAND_CHECK_OFFER_DETAILS]){
        [self btnClickedOfferDetails];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_USER_CARDS]){
        [self btnClickedGetUserCards];
    }
    else if ([self.responseVCType isEqual:COMMAND_VERIFY_PAYMENT]){
        [self btnClickedVerifyPayment];
    }
    else if ([self.responseVCType isEqual:COMMAND_EDIT_USER_CARD]){
        [self btnClickedEditUserCard];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_ONE_TAP_TOKEN]){
        [self btnClickedDeleteOneTapToken];
    }
    else if ([self.responseVCType isEqual:COMMAND_CHECK_IS_DOMESTIC]){
        [self btnClickedCheckIsDomestic];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_TRANSACTION_INFO]){
        [self btnClickedGetTransctionInfo];
    }
    else if ([self.responseVCType isEqual:COMMAND_SAVE_USER_CARD]){
        [self btnClickedSaveUserCard];
    }
    else if ([self.responseVCType isEqual:COMMAND_ELIGIBLE_BINS_FOR_EMI]){
        [self btnClickedEligibleBinForEMI];
    }
    else if ([self.responseVCType isEqual:COMMAND_MCP_LOOKUP]){
        [self btnClickedMCPLookUP];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_CHECKOUT_DETAILS]){
        [self btnClickedCheckoutDetail];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_PAYMENT_INSTRUMENT]){
        [self btnClickedDeleteTokenizedStoredCard];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_PAYMENT_INSTRUMENT]){
        [self btnClickedGetTokenizedStoredCards];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_PAYMENT_DETAILS]){
        [self btnClickedGetTokenizedPaymentDetails];
    }
}


-(void)btnClickedCheckoutDetail{
    self.paymentParam.amount = @"1000.00";
    self.paymentParam.checkCustomerEligibility = true;
    self.paymentParam.transactionID = [PayUUtils getCurrentTimeMiliSecond];
    self.paymentParam.phoneNumber = self.txtFieldVar1.text;
    self.paymentParam.checkAdditionalCharges = true;
    self.paymentParam.checkDownStatus = true;
    self.paymentParam.checkTaxSpecification = true;
    _vAConfig.secret = self.txtFieldVar2.text;
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse getCheckoutDetail:self.paymentParam withCompletionBlock:^(PayUModelPaymentRelatedDetail *paymentRelatedDetails, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (!errorMessage) {
                NSMutableString *message = [[NSMutableString alloc]init];
                for (PayUModelEMI *details in paymentRelatedDetails.EMIArray) {
                    [message appendFormat:@"bankName : %@\nEMICode : %@\nstatus : %@ \nreason : %@ \npaymentType : %@\n------\n", details.bankID, details.bankCode ,details.eligibility.status ? @"YES" : @"NO", details.eligibility.reason, details.paymentType];
                }
                [PUUIUtility showAlertWithTitle:@"Response" message:message viewController:self];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}

-(void)btnClickedMCPLookUP{
    self.paymentParam.amount = @"1.00";
    self.paymentParam.merchantAccessKey = self.txtFieldVar1.text;
    self.paymentParam.lookupRequestId = [[NSUUID UUID] UUIDString];
    self.paymentParam.hashes.lookupApiHash = [PayUDontUseThisClass hmacsha1:[NSString stringWithFormat:@"%@%@%@",@"INR",self.paymentParam.lookupRequestId,self.paymentParam.amount] secret: self.txtFieldVar2.text];
    _vAConfig.secret = self.txtFieldVar2.text;
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse mcpLookup:self.paymentParam
                            withCompletionBlock:^(PayUModelMultiCurrencyPayment *mcpINfo, NSString *errorMessage, id extraParam) {
                                [_defaultActivityIndicator stopAnimatingActivityIndicator];
                                if (!errorMessage) {
                                    NSMutableString *message = [[NSMutableString alloc]init];
                                    for (PayUModelMCPConversion *details in mcpINfo.mcpConversionBeans) {
                                        [message appendFormat:@"OfferAmount : %@\nOfferCurrency : %@\nOfferExchangeRate : %@\n------\n", details.offerAmount ,details.offerCurrency, details.offerExchangeRate];
                                    }
                                    [PUUIUtility showAlertWithTitle:@"Response" message:message viewController:self];
                                }
                                else{
                                    [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
                                }
                            }];
    }
}

-(void)btnClickedVAS{
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    
    [respo getVASStatusForCardBinOrBankCode:self.txtFieldVar1.text withCompletionBlock:^(id ResponseMessage, NSString *errorMessage, id extraParam) {
        if (errorMessage == nil) {
            if (ResponseMessage == nil) {
                [PUUIUtility showAlertWithTitle:@"Yeahh" message:@"Good to Go" viewController:self];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Down Time Message" message:(NSString *)ResponseMessage viewController:self];
            }
        }
        else{
            [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
        }
    }];
    
}

-(void)btnClickedOfferStatus{
 
    self.paymentParam.cardNumber = self.txtFieldVar3.text;
    self.paymentParam.offerKey = self.txtFieldVar1.text;
    self.paymentParam.amount = self.txtFieldVar2.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse getOfferStatus:self.paymentParam withCompletionBlock:^(PayUModelOfferStatus *offerStatus, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (errorMessage == nil) {
                NSString *fullMessage = [NSString stringWithFormat:@"Category = %@\nDiscount = %@\nErrorCode = %@\nMsg = %@\nOfferAvailedCount = %@\nOfferKey = %@\nOfferRemaining Count = %@\nOfferType = %@\nStatus = %@\n",offerStatus.category,offerStatus.discount,offerStatus.errorCode,offerStatus.msg,offerStatus.offerAvailedCount,offerStatus.OfferKey,offerStatus.OfferRemainingCount,offerStatus.OfferType,offerStatus.status];
                [PUUIUtility showAlertWithTitle:@"Discount" message:fullMessage viewController:self];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}


-(void)btnClickedGetEMIDetails{
    
    self.paymentParam.amount = self.txtFieldVar1.text;
    self.paymentParam.bankCode = self.txtFieldVar2.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse getEMIAmountAccordingToInterest:self.paymentParam withCompletionBlock:^(NSDictionary *dictEMIDetails, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (errorMessage) {
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
            else{
                NSMutableString *message = [[NSMutableString alloc]init];
                if ([self.paymentParam.bankCode length] > 0) {
                    PayUModelEMIDetails *emiDetails = [dictEMIDetails objectForKey:self.paymentParam.bankCode];
                    if (emiDetails) {
                        [message appendFormat:@"BankCode : %@\nBankName : %@\nemiBankInterest: %@\nbankRate: %@\nbankCharge: %@\namount: %@\ncard_type: %@\nemi_value: %@\nemi_interest_paid: %@",self.paymentParam.bankCode,emiDetails.bankReference,emiDetails.emiBankInterest,emiDetails.bankRate,emiDetails.bankCharge,emiDetails.amount,emiDetails.cardType,emiDetails.emiValue,emiDetails.emiInterestPaid];
                    }
                    else{
                        [message appendString:@"BankCode Not found"];
                    }
                }
                else{
                    [message appendFormat:@"BankName : BankCode : EMI_Value\n"];
                    for (NSString *bankCode in [dictEMIDetails allKeys]) {
                        PayUModelEMIDetails *emiDetails = [dictEMIDetails objectForKey:bankCode];
                        [message appendFormat:@"%@ : %@ : %@\n",emiDetails.bankReference,bankCode,emiDetails.emiValue];
                    }
                }
                [PUUIUtility showAlertWithTitle:@"Response" message:message viewController:self];
            }
        }];
    }
}

-(void)btnClickedDeleteUserCard{
    self.paymentParam.userCredentials = self.txtFieldVar1.text;
    self.paymentParam.cardToken = self.txtFieldVar2.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse deleteStoredCard:self.paymentParam withCompletionBlock:^(NSString *deleteStoredCardStatus, NSString *deleteStoredCardMessage, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (errorMessage) {
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
            else {
                NSString *responseMsg =[NSString stringWithFormat:@"Status: %@, Message: %@",deleteStoredCardStatus,deleteStoredCardMessage];
                if ([deleteStoredCardStatus integerValue] == 1) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseMsg];
                }
                else{
                    [PUUIUtility showAlertWithTitle:@"Response" message:responseMsg viewController:self];
                }
            }
        }];
    }
}

-(void)btnClickedDeleteTokenizedStoredCard{
    self.paymentParam.userCredentials = self.txtFieldVar1.text;
    self.paymentParam.cardToken = self.txtFieldVar2.text;
    self.paymentParam.networkToken = self.txtFieldVar3.text;
    self.paymentParam.issuerToken = self.txtFieldVar4.text;

    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse deleteTokenizedStoredCard:self.paymentParam withCompletionBlock:^(NSString *deleteStoredCardStatus, NSString *deleteStoredCardMessage, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (errorMessage) {
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
            else {
                NSString *responseMsg =[NSString stringWithFormat:@"Status: %@, Message: %@",deleteStoredCardStatus,deleteStoredCardMessage];
                if ([deleteStoredCardStatus integerValue] == 1) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseMsg];
                }
                else{
                    [PUUIUtility showAlertWithTitle:@"Response" message:responseMsg viewController:self];
                }
            }
        }];
    }
}

-(void)btnClickedGetTokenizedPaymentDetails{
    self.paymentParam.userCredentials = self.txtFieldVar1.text;
    self.paymentParam.cardToken = self.txtFieldVar2.text;
    self.paymentParam.amount = self.txtFieldVar3.text;
    self.paymentParam.currency = self.txtFieldVar4.text;

    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse getTokenizedPaymentDetails:self.paymentParam withCompletionBlock:^(PayUModelTokenizedPaymentDetails *tokenizedPaymentdetails, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (errorMessage) {
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            } else {
                NSString *responseMsg =[NSString stringWithFormat:@"cryptogram = %@\ncard_PAR = %@\ncardNo = %@\ncardToken = %@\none_click_status = %@\none_click_flow = %@\none_click_card_alias = %@\nnetworkToken = %@\nnetworkExpiryMonth = %@\nnetworkExpiryYear = %@\ncard_type = %@\ncard_mode = %@\ncard_name = %@\ntoken_refernce_id = %@\ntrid = %@\n\n",tokenizedPaymentdetails.cryptogram, tokenizedPaymentdetails.cardPAR, tokenizedPaymentdetails.cardNo, tokenizedPaymentdetails.cardToken, tokenizedPaymentdetails.oneClickStatus, tokenizedPaymentdetails.oneClickFlow, tokenizedPaymentdetails.oneClickCardAlias, tokenizedPaymentdetails.networkToken.token, tokenizedPaymentdetails.networkToken.expiryMonth, tokenizedPaymentdetails.networkToken.expiryYear, tokenizedPaymentdetails.cardType, tokenizedPaymentdetails.cardMode, tokenizedPaymentdetails.cardName, tokenizedPaymentdetails.tokenReferenceId, tokenizedPaymentdetails.trid];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseMsg];
            }
        }];
    }
}

-(void)btnClickedOfferDetails{
    self.paymentParam.offerKey = self.txtFieldVar3.text;
    self.paymentParam.amount = self.txtFieldVar4.text;
    
    self.paymentParam.bankCode = self.txtFieldVar2.text;
    self.paymentParam.cardToken = self.txtFieldVar2.text;
    self.paymentParam.cardNumber = self.txtFieldVar2.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse getOfferDetails:self.paymentParam forPaymentType:self.txtFieldVar1.text withCompletionBlock:^(PayUModelOfferDetails *offerDetails, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (errorMessage) {
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
            else{
                NSMutableString *offerKeyAndDiscount = [[NSMutableString alloc] init];
                [offerKeyAndDiscount appendString:@"OfferKey : Discount: Status\n\n"];
                for (PayUModelOfferAndStoredCard *offerAndStoredCard in offerDetails.arrOfferAndStoredCard ) {
                    NSString *cardNumber = offerAndStoredCard.storedCard.cardNo;
                    if (cardNumber){
                        [offerKeyAndDiscount appendFormat:@"\n%@\n\n",cardNumber];
                    }
                    for (PayUModelOffer *offerObj  in offerAndStoredCard.arrOffers) {
                        [offerKeyAndDiscount appendFormat:@"%@ : %@ :%@ \n",offerObj.OfferKey,offerObj.discount,offerObj.status];
                    }
                }
                [PUUIUtility showAlertWithTitle:@"Offer Status" message:offerKeyAndDiscount viewController:self];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController * navigationCntlr = [segue destinationViewController];
    _tableVC = (PUVATableVC *)[navigationCntlr topViewController];
    if ([self.responseVCType isEqual:COMMAND_DELETE_USER_CARD]) {
        [self prepareForDeleteSCSegue:segue sender:sender];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_PAYMENT_INSTRUMENT]) {
        [self prepareForDeleteSCSegue:segue sender:sender];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_PAYMENT_DETAILS]) {
        [self prepareForDeleteSCSegue:segue sender:sender];
    }
    else if ([self.responseVCType isEqual:COMMAND_CHECK_OFFER_DETAILS]){
        [self prepareForOfferDetailsSegue:segue sender:sender];
    }
    else if ([self.responseVCType isEqual:COMMAND_EDIT_USER_CARD]){
        [self prepareForEditUserCardSegue:segue sender:sender];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_ONE_TAP_TOKEN]){
        [self prepareForDeleteOneTapToken:segue sender:sender];
    }
}

- (void)prepareForDeleteSCSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:segueIdentiiferVar2]) {
        _tableVC.segueIdentifier = segueIdentiiferVar2;
        _tableVC.tableVCType = PAYMENT_PG_STOREDCARD;
        _tableVC.paymentRelatedDetail = self.paymentRelatedDetail;
    }
}

- (void)prepareForOfferDetailsSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:segueIdentiiferVar1]) {
        _tableVC.arrTextLabel = _arrPaymentType;
        _tableVC.segueIdentifier = segueIdentiiferVar1;
    }
    else if ([[segue identifier] isEqual:segueIdentiiferVar2]){
        if ([self.txtFieldVar1.text isEqual:PAYMENT_PG_NET_BANKING]) {
            _tableVC.tableVCType = PAYMENT_PG_NET_BANKING;
            _tableVC.segueIdentifier = segueIdentiiferVar2;
            _tableVC.paymentRelatedDetail = self.paymentRelatedDetail;
        }
        else if ([self.txtFieldVar1.text isEqual:PAYMENT_PG_STOREDCARD]) {
            _tableVC.tableVCType = PAYMENT_PG_STOREDCARD;
            _tableVC.segueIdentifier = segueIdentiiferVar2;
            _tableVC.paymentRelatedDetail = self.paymentRelatedDetail;
        }
        else if ([self.txtFieldVar1.text isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
            _tableVC.tableVCType = PAYMENT_PG_ONE_TAP_STOREDCARD;
            _tableVC.segueIdentifier = segueIdentiiferVar2;
            _tableVC.paymentRelatedDetail = self.paymentRelatedDetail;
        }
    }
    
}

#pragma mark - Unwind segue
- (IBAction)unwindToViewController:(UIStoryboardSegue *)unwindSegue
{
    _tableVC = [unwindSegue sourceViewController];
    if ([self.responseVCType isEqual:COMMAND_DELETE_USER_CARD]) {
        [self unwindToViewControllerForDeleteSC:unwindSegue];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_PAYMENT_INSTRUMENT]) {
        [self unwindToViewControllerForDeleteSC:unwindSegue];
    }
    else if ([self.responseVCType isEqual:COMMAND_GET_PAYMENT_DETAILS]) {
        [self unwindToViewControllerForDeleteSC:unwindSegue];
    }
    else if ([self.responseVCType isEqual:COMMAND_CHECK_OFFER_DETAILS]){
        [self unwindToViewControllerForOfferDetails:unwindSegue];
    }
    else if ([self.responseVCType isEqual:COMMAND_EDIT_USER_CARD]){
        [self unwindToViewControllerForEditUserCard:unwindSegue];
    }
    else if ([self.responseVCType isEqual:COMMAND_DELETE_ONE_TAP_TOKEN]){
        [self unwindToViewControllerForDeleteOneTapToken:unwindSegue];
    }
}
- (IBAction)unwindToViewControllerForDeleteSC:(UIStoryboardSegue *)unwindSegue{
    if ([[_tableVC segueIdentifier] isEqual:segueIdentiiferVar2]) {
        if (_tableVC.tappedOnUITableViewCell) {
            NSLog(@"Selected Index%ld",(long)_tableVC.selectedIndex);
            PayUModelStoredCard *storedCardObj = [self.paymentRelatedDetail.storedCardArray objectAtIndex:_tableVC.selectedIndex];
            self.txtFieldVar2.text = storedCardObj.cardToken;
        }
    }
}

- (IBAction)unwindToViewControllerForOfferDetails:(UIStoryboardSegue *)unwindSegue{
    if ([[_tableVC segueIdentifier] isEqual:segueIdentiiferVar1]) {
        if (_tableVC.tappedOnUITableViewCell) {
            NSLog(@"Selected Index%ld",(long)_tableVC.selectedIndex);
            self.txtFieldVar1.text = [_arrPaymentType objectAtIndex:_tableVC.selectedIndex];
        }
    }
    else if ([[_tableVC segueIdentifier] isEqual:segueIdentiiferVar2]){
        if (_tableVC.tappedOnUITableViewCell) {
            NSLog(@"Selected Index%ld",(long)_tableVC.selectedIndex);
            if ([_tableVC.tableVCType isEqual:PAYMENT_PG_NET_BANKING]){
                PayUModelNetBanking *objNetBanking = [self.paymentRelatedDetail.netBankingArray objectAtIndex:_tableVC.selectedIndex];
                self.txtFieldVar2.text = objNetBanking.bankCode;
            }
            else if ([_tableVC.tableVCType isEqual:PAYMENT_PG_STOREDCARD]) {
                PayUModelStoredCard *storedCardObj = [self.paymentRelatedDetail.storedCardArray objectAtIndex:_tableVC.selectedIndex];
                self.txtFieldVar2.text = storedCardObj.cardToken;
            }
            else if ([_tableVC.tableVCType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
                PayUModelStoredCard *storedCardObj = [self.paymentRelatedDetail.oneTapStoredCardArray objectAtIndex:_tableVC.selectedIndex];
                self.txtFieldVar2.text = storedCardObj.cardToken;
            }
        }
    }
    
}




#pragma mark - GetUserCards methods

-(void)setupForGetUserCards{
    self.vwView1.hidden = FALSE;
    
    self.lblVar1.text = @"User credential";
    
    self.txtFieldVar1.placeholder = @"merchantKey:customerEmailID";
    
    self.txtFieldVar1.text = self.paymentParam.userCredentials;
}

-(void)btnClickedGetUserCards{
    self.paymentParam.userCredentials = self.txtFieldVar1.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse getUserCards:self.paymentParam withCompletionBlock:^(NSDictionary *dictStoredCard, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            NSDictionary *dict = [extraParam objectForKey:KEY_POST_PARAM];
            NSLog(@"%@",dict);
            if (!errorMessage) {
                NSMutableString *responseMessage = [[NSMutableString alloc]init];
                for (NSString *cardtoken in [dictStoredCard allKeys]) {
                    [responseMessage appendFormat:@"%@\n",cardtoken];
                    PayUModelStoredCard *objSC = [dictStoredCard objectForKey:cardtoken];
                    [responseMessage appendFormat:@"card_bin = %@\ncard_brand = %@\ncard_cvv = %@\ncard_mode = %@\ncard_name = %@\ncard_no = %@\ncard_token = %@\ncard_type = %@\nexpiry_month = %@\nexpiry_year = %@\nisDomestic = %@\nis_expired = %@\nissuingBank = %@\nname_on_card = %@\n\n",objSC.cardBin,objSC.cardBrand,objSC.oneTapFlag,objSC.cardMode,objSC.cardName,objSC.cardNo,objSC.cardToken,objSC.cardType,objSC.expiryMonth,objSC.expiryYear,objSC.isDomestic,objSC.isExpired,objSC.issuingBank,objSC.nameOnCard];
                }
                [PUUIUtility showAlertWithTitle:@"Response" message:responseMessage viewController:self];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}

-(void)btnClickedGetTokenizedStoredCards{
    self.paymentParam.userCredentials = self.txtFieldVar1.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse getTokenizedStoredCards:self.paymentParam withCompletionBlock:^(NSDictionary *dictStoredCard, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            NSDictionary *dict = [extraParam objectForKey:KEY_POST_PARAM];
            NSLog(@"%@",dict);
            if (!errorMessage) {
                NSMutableString *responseMessage = [[NSMutableString alloc]init];
                for (NSString *cardtoken in [dictStoredCard allKeys]) {
                    [responseMessage appendFormat:@"%@\n",cardtoken];
                    PayUModelTokenizedStoredCard *objSC = [dictStoredCard objectForKey:cardtoken];
                    [responseMessage appendFormat:@"card_bin = %@\ncard_brand = %@\ncard_mode = %@\ncard_name = %@\ncard_no = %@\ncard_token = %@\ncard_type = %@\nisDomestic = %@\none_click_flow = %@\none_click_status = %@\none_click_card_alias = %@\ncard_PAR = %@\n\n",objSC.cardBin,objSC.cardBrand,objSC.cardMode,objSC.cardName,objSC.cardNo,objSC.cardToken,objSC.cardType,objSC.isDomestic,objSC.oneClickFlow,objSC.oneClickStatus,objSC.oneClickCardAlias,objSC.cardPAR];
                }
                [PUUIUtility showAlertWithTitle:@"Response" message:responseMessage viewController:self];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}

#pragma mark - VerifyPayment methods

-(void)setupForVerifyPayment{
    self.vwView1.hidden = FALSE;
    
    self.lblVar1.text = @"Txn ID";
    
    self.txtFieldVar1.placeholder = @"TxnID1|TxnID2|TxnID3..";
}

-(void)btnClickedVerifyPayment{
    self.paymentParam.transactionID = self.txtFieldVar1.text;
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse verifyPayment:self.paymentParam withCompletionBlock:^(NSDictionary *dictVerifyPayment, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (!errorMessage) {
                NSMutableString *responseMessage = [[NSMutableString alloc]init];
                for (NSString *txnID in [dictVerifyPayment allKeys]) {
                    [responseMessage appendFormat:@"\n\n%@\n",txnID];
                    PayUModelVerifyPayment *objVerifyPayment = [dictVerifyPayment objectForKey:txnID];
                    [responseMessage appendFormat:@"Merchant_UTR = %@, PG_Type = %@, settled_at = %@, addedOn = %@, additionalCharges = %@, amt = %@, bank_ref_num = %@, bankCode = %@, card_no = %@, card_type = %@, disc = %@, error_Message = %@, error_code = %@,  field9 = %@, firstname = %@,  mihpayid = %@, mode = %@, name_on_card = %@, net_amount_debit = %@, productinfo = %@, request_id = %@,  status = %@, transaction_amount = %@, txnid = %@, udf1 = %@,  udf2 = %@,  udf3 = %@,  udf4 = %@,  udf5 = %@,  unmappedstatus = %@, merchant_subvention_amount = %@",objVerifyPayment.MerchantUTR,objVerifyPayment.PGType,objVerifyPayment.SettledAt,objVerifyPayment.AddedOn,objVerifyPayment.AdditionalCharges,objVerifyPayment.Amt,objVerifyPayment.BankRefNum,objVerifyPayment.BankCode,objVerifyPayment.CardNo,objVerifyPayment.CardType,objVerifyPayment.Disc,objVerifyPayment.ErrorMessage,objVerifyPayment.ErrorCode,objVerifyPayment.Field9,objVerifyPayment.FirstName,objVerifyPayment.MihpayID,objVerifyPayment.Mode,objVerifyPayment.NameOnCard,objVerifyPayment.NetAmountDebit,objVerifyPayment.ProductInfo,objVerifyPayment.RequestId,objVerifyPayment.Status,objVerifyPayment.TransactionAmount,objVerifyPayment.TxnID,objVerifyPayment.Udf1,objVerifyPayment.Udf2,objVerifyPayment.Udf3,objVerifyPayment.Udf4,objVerifyPayment.Udf5,objVerifyPayment.UnmappedStatus,objVerifyPayment.merchantSubventionAmount];
                }
                [PUUIUtility showAlertWithTitle:@"Response" message:responseMessage viewController:self];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}


#pragma mark - EditUserCard Methods

-(void)setupForEditUserCard{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    self.vwView3.hidden = FALSE;
    self.vwView4.hidden = FALSE;
    self.vwView5.hidden = FALSE;
    self.vwView6.hidden = FALSE;
    self.vwView7.hidden = FALSE;
    self.vwView8.hidden = FALSE;
    self.vwView9.hidden = FALSE;
    
    self.btnVar2.hidden = FALSE;
    
    self.lblVar1.text = @"User Cred";
    self.lblVar2.text = @"Card Token";
    self.lblVar3.text = @"card Name";
    self.lblVar4.text = @"card mode";
    self.lblVar5.text = @"card Type";
    self.lblVar6.text = @"name on card";
    self.lblVar7.text = @"card No";
    self.lblVar8.text = @"MM";
    self.lblVar9.text = @"YYYY";
    
    self.txtFieldVar1.placeholder = @"merchantKey:customerEmailID";
    self.txtFieldVar2.placeholder = @"cardToken";
    self.txtFieldVar3.placeholder = @"Umang";
    self.txtFieldVar4.placeholder = @"CC or DC";
    self.txtFieldVar5.placeholder = @"AMEX or VISA";
    self.txtFieldVar6.placeholder = @"Umang";
    self.txtFieldVar7.placeholder = @"5123456789012346";
    self.txtFieldVar8.placeholder = @"Expiry Month";
    self.txtFieldVar9.placeholder = @"Expiry Year";
    
    self.txtFieldVar1.text = self.paymentParam.userCredentials;
}

-(void)btnClickedEditUserCard{
    self.paymentParam.userCredentials = self.txtFieldVar1.text;
    self.paymentParam.cardToken = self.txtFieldVar2.text;
    self.paymentParam.cardName = self.txtFieldVar3.text;
    self.paymentParam.cardMode = self.txtFieldVar4.text;
    self.paymentParam.cardType = self.txtFieldVar5.text;
    self.paymentParam.nameOnCard = self.txtFieldVar6.text;
    self.paymentParam.cardNo = self.txtFieldVar7.text;
    self.paymentParam.expiryMonth = self.txtFieldVar8.text;
    self.paymentParam.expiryYear = self.txtFieldVar9.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse editUserCard:self.paymentParam withCompletionBlock:^(PayUModelStoredCard *objStoredCard, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (!errorMessage) {
                NSString *responseMsg = [NSString stringWithFormat:@"Card_Token = %@\nCard Label = %@\nCard Number = %@",objStoredCard.cardToken,objStoredCard.cardName,objStoredCard.cardNo];
                [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseMsg];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}

- (void)prepareForEditUserCardSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:segueIdentiiferVar2]) {
        _tableVC.segueIdentifier = segueIdentiiferVar2;
        _tableVC.tableVCType = PAYMENT_PG_STOREDCARD;
        _tableVC.paymentRelatedDetail = self.paymentRelatedDetail;
    }
}

- (IBAction)unwindToViewControllerForEditUserCard:(UIStoryboardSegue *)unwindSegue{
    if ([[_tableVC segueIdentifier] isEqual:segueIdentiiferVar2]) {
        if (_tableVC.tappedOnUITableViewCell) {
            NSLog(@"Selected Index%ld",(long)_tableVC.selectedIndex);
            PayUModelStoredCard *storedCardObj = [self.paymentRelatedDetail.storedCardArray objectAtIndex:_tableVC.selectedIndex];
            self.txtFieldVar2.text = storedCardObj.cardToken;
            self.txtFieldVar3.text = storedCardObj.cardName ;
            self.txtFieldVar4.text = storedCardObj.cardMode ;
            self.txtFieldVar5.text = storedCardObj.cardType ;
            self.txtFieldVar6.text = storedCardObj.nameOnCard ;
            self.txtFieldVar7.text = storedCardObj.cardNo ;
            self.txtFieldVar8.text = storedCardObj.expiryMonth ;
            self.txtFieldVar9.text = storedCardObj.expiryYear ;
        }
    }
}


#pragma mark - DeleteOneTapToken Methods

-(void)setupForDeleteOneTapToken{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    
    self.btnVar2.hidden = FALSE;
    
    self.lblVar1.text = @"User Cred";
    self.lblVar2.text = @"Card Token";
    
    self.txtFieldVar1.placeholder = @"merchantKey:customerEmailID";
    self.txtFieldVar2.placeholder = @"cardToken";
    
    self.txtFieldVar1.text = self.paymentParam.userCredentials;
}

-(void)btnClickedDeleteOneTapToken{
    self.paymentParam.userCredentials = self.txtFieldVar1.text;
    self.paymentParam.cardToken = self.txtFieldVar2.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse deleteOneTapToken:self.paymentParam withCompletionBlock:^(NSString *deleteOneTapTokenMsg ,NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (!errorMessage) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:deleteOneTapTokenMsg];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}

- (void)prepareForDeleteOneTapToken:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:segueIdentiiferVar2]) {
        _tableVC.segueIdentifier = segueIdentiiferVar2;
        _tableVC.tableVCType = PAYMENT_PG_ONE_TAP_STOREDCARD;
        _tableVC.paymentRelatedDetail = self.paymentRelatedDetail;
    }
}

- (IBAction)unwindToViewControllerForDeleteOneTapToken:(UIStoryboardSegue *)unwindSegue{
    if ([[_tableVC segueIdentifier] isEqual:segueIdentiiferVar2]) {
        if (_tableVC.tappedOnUITableViewCell) {
            NSLog(@"Selected Index%ld",(long)_tableVC.selectedIndex);
            PayUModelStoredCard *storedCardObj = [self.paymentRelatedDetail.oneTapStoredCardArray objectAtIndex:_tableVC.selectedIndex];
            self.txtFieldVar2.text = storedCardObj.cardToken;
        }
    }
}


#pragma mark - CheckIsDomestic Methods

-(void)setupForCheckIsDomestic{
    self.vwView1.hidden = FALSE;
    
    self.lblVar1.text = @"Card Number";
    
    self.txtFieldVar1.placeholder = @"512345";
}

-(void)btnClickedCheckIsDomestic{
    self.paymentParam.cardNumber = self.txtFieldVar1.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse checkIsDomestic:self.paymentParam withCompletionBlock:^(PayUModelCheckIsDomestic *checkIsDomestic, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (!errorMessage) {
                NSString *responseMsg = [NSString stringWithFormat:@"isDomestic = %@\nissuingbank = %@\nCardType = %@\ncardCategory = %@",checkIsDomestic.isDomestic,checkIsDomestic.issuingBank,checkIsDomestic.cardType,checkIsDomestic.cardCategory];
                [PUUIUtility showAlertWithTitle:@"Response" message:responseMsg viewController:self];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}

#pragma mark - getTransctionInfo Methods

-(void)setupForGetTransctionInfo{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;

    self.lblVar1.text = @"Start Time";
    self.lblVar2.text = @"End Time";

    self.txtFieldVar1.placeholder = @"2014-01-12 16:00:00";
    self.txtFieldVar2.placeholder = @"2014-01-12 16:15:00";
}

-(void)btnClickedGetTransctionInfo{
    self.paymentParam.startTime = self.txtFieldVar1.text;
    self.paymentParam.endTime = self.txtFieldVar2.text;

    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse getTransactionInfo:self.paymentParam withCompletionBlock:^(NSArray *arrOfGetTxnInfo, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (!errorMessage) {
                NSMutableString * responseMsg = [[NSMutableString alloc] init];
                NSMutableString * responseMsgDisplay = [[NSMutableString alloc] init];
                if ([arrOfGetTxnInfo count]) {
                    for (PayUModelGetTxnInfo *objGetTxnInfo in arrOfGetTxnInfo) {
                        [responseMsg appendFormat:@"----Details----\n"];
                        [responseMsgDisplay appendFormat:@"----Details----\n"];
                        [responseMsg appendFormat:@"action = %@\naddedon = %@\nAdditionalCharges = %@\namount = %@\nbankName = %@\nbankRefNo = %@\ncardNo = %@\ncardType = %@\ndiscount = %@\nemail = %@\nerrorCode = %@\nfailureReason = %@\nfield2 = %@\nfirstname = %@\nibiboCode = %@\nthisid = %@\nip = %@\nissuingBank = %@\nmerchantKey = %@\nlastname = %@\nmerServiceFee = %@\nmerServiceTax = %@\nmerchantName = %@\nmode = %@\nofferKey = %@\nofferType = %@\npaymentGateway = %@\npgMID = %@\nphone = %@\nproductInfo = %@\nstatus = %@\ntransactionFee = %@\ntxnID = %@\nudf1 = %@\nmerchant_subvention_amount = %@",objGetTxnInfo.action,objGetTxnInfo.addedon,objGetTxnInfo.additionalCharges,objGetTxnInfo.amount,objGetTxnInfo.bankName,objGetTxnInfo.bankRefNo,objGetTxnInfo.cardNo,objGetTxnInfo.cardType,objGetTxnInfo.discount,objGetTxnInfo.email,objGetTxnInfo.errorCode,objGetTxnInfo.failureReason,objGetTxnInfo.field2,objGetTxnInfo.firstname,objGetTxnInfo.ibiboCode,objGetTxnInfo.thisid,objGetTxnInfo.ip,objGetTxnInfo.issuingBank,objGetTxnInfo.merchantKey,objGetTxnInfo.lastname,objGetTxnInfo.merServiceFee,objGetTxnInfo.merServiceTax,objGetTxnInfo.merchantName,objGetTxnInfo.mode,objGetTxnInfo.offerKey,objGetTxnInfo.offerType,objGetTxnInfo.paymentGateway,objGetTxnInfo.pgMID,objGetTxnInfo.phone,objGetTxnInfo.productInfo,objGetTxnInfo.status,objGetTxnInfo.transactionFee,objGetTxnInfo.txnID,objGetTxnInfo.udf1,objGetTxnInfo.merchantSubventionAmount];
                        [responseMsgDisplay appendFormat:@"id = %@\nip = %@\nissuingBank = %@\nmerchantKey = %@\nstatus = %@\ntransactionFee = %@\ntxnID = %@\nmerchant_subvention_amount = %@",objGetTxnInfo.thisid,objGetTxnInfo.ip,objGetTxnInfo.issuingBank,objGetTxnInfo.merchantKey,objGetTxnInfo.status,objGetTxnInfo.transactionFee,objGetTxnInfo.txnID,objGetTxnInfo.merchantSubventionAmount];
                        [responseMsgDisplay appendFormat:@"\n--------END--------\n\n"];
                        [responseMsg appendFormat:@"\n--------END--------\n\n"];
                    }
                    NSLog(@"%@",responseMsg);
                }
                [PUUIUtility showAlertWithTitle:@"Response" message:responseMsgDisplay viewController:self];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}


#pragma mark - saveUserCard Methods

-(void)setupForSaveUserCard{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    self.vwView3.hidden = FALSE;
    self.vwView4.hidden = FALSE;
    self.vwView5.hidden = FALSE;
    self.vwView6.hidden = FALSE;
    self.vwView7.hidden = FALSE;
    self.vwView8.hidden = FALSE;
    
    
    self.lblVar1.text = @"User Cred";
    self.lblVar2.text = @"card Name";
    self.lblVar3.text = @"card mode";
    self.lblVar4.text = @"card Type";
    self.lblVar5.text = @"name on card";
    self.lblVar6.text = @"card No";
    self.lblVar7.text = @"MM";
    self.lblVar8.text = @"YYYY";
    
    self.txtFieldVar1.placeholder = @"merchantKey:customerEmailID";
    self.txtFieldVar2.placeholder = @"Umang";
    self.txtFieldVar3.placeholder = @"CC or DC";
    self.txtFieldVar4.placeholder = @"AMEX or VISA";
    self.txtFieldVar5.placeholder = @"Umang";
    self.txtFieldVar6.placeholder = @"5123456789012346";
    self.txtFieldVar7.placeholder = @"Expiry Month";
    self.txtFieldVar8.placeholder = @"Expiry Year";
    
    self.txtFieldVar1.text = self.paymentParam.userCredentials;

}

-(void)btnClickedSaveUserCard{
    
    self.paymentParam.userCredentials = self.txtFieldVar1.text;
    self.paymentParam.cardName = self.txtFieldVar2.text;
    self.paymentParam.cardMode = self.txtFieldVar3.text;
    self.paymentParam.cardType = self.txtFieldVar4.text;
    self.paymentParam.nameOnCard = self.txtFieldVar5.text;
    self.paymentParam.cardNo = self.txtFieldVar6.text;
    self.paymentParam.expiryMonth = self.txtFieldVar7.text;
    self.paymentParam.expiryYear = self.txtFieldVar8.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse saveUserCard:self.paymentParam withCompletionBlock:^(PayUModelStoredCard *objStoredCard, NSString *errorMessage, id extraParam) {
            [_defaultActivityIndicator stopAnimatingActivityIndicator];
            if (!errorMessage) {
                NSString *responseMsg = [NSString stringWithFormat:@"Card_Token = %@\nCard Label = %@\nCard Number = %@",objStoredCard.cardToken,objStoredCard.cardName,objStoredCard.cardNo];
                [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseMsg];
            }
            else{
                [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
            }
        }];
    }
}

#pragma mark - eligibleBinForEMI Methods

-(void)setupForEligibleBinForEMI{
    self.vwView1.hidden = FALSE;
    self.vwView2.hidden = FALSE;
    
    self.lblVar1.text = @"Card Bin";
    self.lblVar2.text = @"Bank Name";
    
    self.txtFieldVar1.placeholder = @"512345";
    self.txtFieldVar2.placeholder = @"HDFC";
}

-(void)btnClickedEligibleBinForEMI{
    self.paymentParam.cardNumber = self.txtFieldVar1.text;
    self.paymentParam.issuingBank = self.txtFieldVar2.text;
    
    if ([self setHashes]) {
        [self startActivityIndicator];
        [_webServiceResponse eligibleBinsForEMI:self.paymentParam
                            withCompletionBlock:^(NSArray<PayUModelEMIDetails *> *arrEMIDetails, NSString *errorMessage, id extraParam) {
                                [_defaultActivityIndicator stopAnimatingActivityIndicator];
                                if (!errorMessage) {
                                    NSMutableString *message = [[NSMutableString alloc]init];
                                    for (PayUModelEMIDetails *emiDetails in arrEMIDetails) {
                                        [message appendFormat:@"BankName : %@\nSupportedBin : %@\nMinAmount : %@\nisEligible : %d\n------\n", emiDetails.bankReference ,emiDetails.supportedCardBins ,emiDetails.minTxnAmount,emiDetails.isEligible];
                                    }
                                    [PUUIUtility showAlertWithTitle:@"Response" message:message viewController:self];
                                }
                                else{
                                    [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
                                }
                            }];
    }
}

#pragma mark - Helper Methods

-(BOOL)setHashes{
    __block BOOL hashGenerated;
    [_hashes getPayUHashesWithPaymentParam:self.paymentParam merchantSalt:_vAConfig.salt merchantSecret: _vAConfig.secret  withCompletionBlock:^(PayUModelHashes *allHashes, PayUModelHashes *hashString, NSString *errorMessage) {
        if (!errorMessage) {
            self.paymentParam.hashes = allHashes;
            hashGenerated = TRUE;
        }
        else{
            hashGenerated = FALSE;
            [PUUIUtility showAlertWithTitle:@"Error" message:errorMessage viewController:self];
        }
    }];
    return hashGenerated;
}

-(void)startActivityIndicator{
    [_defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
}
@end
