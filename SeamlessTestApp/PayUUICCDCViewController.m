//
//  PayUUICCDCViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 07/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUICCDCViewController.h"
#import "PayUUIPaymentUIWebViewController.h"
#import "PayUUIConstants.h"
#import "iOSDefaultActivityIndicator.h"

@interface PayUUICCDCViewController()

@property (nonatomic, strong) PayUCreateRequest *createRequest;
@property (nonatomic, strong) PayUValidations *validations;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;


@end

@implementation PayUUICCDCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.textFieldCardNumber.text = @"5123456789012346";
    self.textFieldCVV.text = @"123";
    self.textFieldExpiryMonth.text = @"12";
    self.textFieldExpiryYear.text = @"2019";
    self.textFieldNameOnCard.text = @"NOC";
    self.textFieldstoreCardName.text = @"SCN";
    
    if (self.paymentParam.OneTapTokenDictionary == nil) {
        self.labelOneTap.hidden = true;
    }
    else{
        self.labelOneTap.hidden = false;
    }

    [self saveStoreCard:nil];
    
}
-(void)dismissKeyboard {
    [self.textFieldCardNumber resignFirstResponder];
    [self.textFieldCVV resignFirstResponder];
    [self.textFieldExpiryMonth resignFirstResponder];
    [self.textFieldExpiryYear resignFirstResponder];
    [self.textFieldNameOnCard resignFirstResponder];
    [self.textFieldstoreCardName resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
}


- (IBAction)payByCCDC:(id)sender {
    
    self.paymentParam.expiryYear = self.textFieldExpiryYear.text;
    self.paymentParam.expiryMonth = self.textFieldExpiryMonth.text;
    self.paymentParam.nameOnCard = self.textFieldNameOnCard.text;
    self.paymentParam.cardNumber = self.textFieldCardNumber.text;
    self.paymentParam.CVV = self.textFieldCVV.text;
    
    
    self.createRequest = [PayUCreateRequest new];
    
    if ([self.paymentType isEqual:PAYMENT_PG_CASHCARD]) {
        
        [self sendPaymentRequestWithPaymentType:PAYMENT_PG_CASHCARD];
    }
    else{
        if (self.switchSaveStoreCard.on) {
            self.paymentParam.storeCardName = self.textFieldstoreCardName.text;
            if (self.switchForOneTap.on) {
                self.paymentParam.isOneTap = 1;
            }
        }
        else{
            self.paymentParam.storeCardName = nil;
        }
        
        [self sendPaymentRequestWithPaymentType:PAYMENT_PG_CCDC];
        
    }
    
}
-(void)sendPaymentRequestWithPaymentType:(NSString *)paymentType
{
    [self.createRequest createRequestWithPaymentParam:self.paymentParam forPaymentType:paymentType withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error == nil) {
            PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
            webView.paymentRequest = (NSURLRequest *)request;
            webView.paymentParam = self.paymentParam;
            [self.navigationController pushViewController:webView animated:true];
        }
        else{
            NSLog(@"URL request from createRequestWithPostParam: %@",request);
            NSLog(@"PostParam from createRequestWithPostParam:%@",postParam);
            NSLog(@"Error from createRequestWithPostParam:%@",error);
            [[[UIAlertView alloc] initWithTitle:@"ERROR" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            
        }
    }];
    
}



- (IBAction)checkCardBrand:(id)sender {
    self.validations = [PayUValidations new];
    self.labelCardBrandName.text = [self.validations getIssuerOfCardNumber:self.textFieldCardNumber.text];
}
- (IBAction)checkOffer:(id)sender {
    self.defaultActivityIndicator = [[iOSDefaultActivityIndicator alloc]init];
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
    self.webServiceResponse = [PayUWebServiceResponse new];
    self.paymentParam.cardNumber = self.textFieldCardNumber.text;
    [self.webServiceResponse getOfferStatus:self.paymentParam withCompletionBlock:^(PayUModelOfferStatus *offerStatus, NSString *errorMessage, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        //
        if (errorMessage == nil) {
            NSString *fullMessage = [NSString stringWithFormat:@"Status =%@ & Discount =%@ & Msg = %@",offerStatus.status,offerStatus.discount,offerStatus.msg];
            PAYUALERT(@"Discount", fullMessage);
        }
        else{
            PAYUALERT(@"Error", errorMessage);
        }
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return true;
}// return NO to not change text

- (IBAction)checkVAS:(id)sender {
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    
    [respo getVASStatusForCardBinOrBankCode:self.textFieldCardNumber.text withCompletionBlock:^(id ResponseMessage, NSString *errorMessage, id extraParam) {
        //
        if (errorMessage == nil) {
            //
            if (ResponseMessage == nil) {
                PAYUALERT(@"Yeahh", @"Good to Go");
            }
            else{
                NSString * responseMessage;// = [NSString new];
                responseMessage = (NSString *) ResponseMessage;
                PAYUALERT(@"Down Time Message", responseMessage);
            }
        }
        else{
            PAYUALERT(@"Error", errorMessage);
        }
    }];
}

- (IBAction)saveStoreCard:(id)sender {
    if ([self.paymentType isEqual:PAYMENT_PG_CASHCARD]) {
        self.switchSaveStoreCard.hidden = true;
        self.switchForOneTap.hidden = true;
        self.labelOneTap.hidden = true;
        self.textFieldstoreCardName.hidden = true;
    }
    else {
        [self.switchForOneTap setOn:false];
        
        if (self.switchSaveStoreCard.on) {
            self.textFieldstoreCardName.hidden = false;
            if (self.paymentParam.OneTapTokenDictionary == nil) {
                self.switchForOneTap.hidden = true;
            }
            else{
                self.switchForOneTap.hidden = false;
            }
        }
        else{
            self.textFieldstoreCardName.hidden = true;
            self.switchForOneTap.hidden = true;
        }
    }
}

-(void)dealloc{
    NSLog(@"Inside Dealloc of CCDC");
}


@end
