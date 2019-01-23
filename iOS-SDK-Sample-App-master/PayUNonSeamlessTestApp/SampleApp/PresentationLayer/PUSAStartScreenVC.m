//
//  PUSAStartScreenVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUSAStartScreenVC.h"
#import "PUUIPaymentOptionVC.h"
#import "PUSAHelperClass.h"
#import "iOSDefaultActivityIndicator.h"
#import "PUVAOptionsVC.h"

static NSString * const verifyAPIStoryBoard = @"PUVAMainStoryBoard";
static NSString * const pUUIStoryBoard = @"PUUIMainStoryBoard";

@interface PUSAStartScreenVC ()

{
    BOOL _isVerifyAPIBtnTapped, _isStartBtnTapped;
}

// IBOutlets
@property (weak, nonatomic) IBOutlet UITextField *textFieldKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTransactionID;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAmount;
@property (weak, nonatomic) IBOutlet UITextField *textFieldProductInfo;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSURL;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFURL;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEnvironment;
@property (weak, nonatomic) IBOutlet UITextField *textFieldOfferKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF1;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF2;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF3;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF4;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUDF5;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserCredential;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSalt;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSVAmount;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSVEligibility;
@property (weak, nonatomic) IBOutlet UIScrollView *startScreenScrollView;
- (IBAction)switchButtonForNil:(id)sender;
- (IBAction)clickedBtnStart:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchBtnSVAmount;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtnSVEligibility;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtnOfferKey;

@property (strong, nonatomic) UISwitch *switchForSalt;
@property (strong, nonatomic) UISwitch *switchForOneTap;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;


@end

@implementation PUSAStartScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    [self dismissKeyboardOnTapOutsideTextField];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    [self addKeyboardNotifications];
    self.textFieldTransactionID.text = [PUSAHelperClass getTransactionIDWithLength:15];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:true];
    [self removeKeyboardNotifications];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initialSetup{
    self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];
    self.paymentParam = [PayUModelPaymentParams new];
    
    self.scrollView = self.startScreenScrollView;
    
    self.switchForSalt = (UISwitch *)[self.startScreenScrollView viewWithTag:18];
    self.switchForOneTap = (UISwitch *)[self.startScreenScrollView viewWithTag:19];
    
//    self.paymentParam.key = @"0MQaQP";//@"gtKFFx";//@"0MQaQP";
    self.paymentParam.amount = @"10";
    self.paymentParam.productInfo = @"Nokia";
    self.paymentParam.firstName = @"Ram";
    self.paymentParam.email = @"email@testsdk1.com";
    self.paymentParam.userCredentials = @"ra:ra";
    self.paymentParam.phoneNumber = @"1111111111";
    self.paymentParam.SURL = @"https://payu.herokuapp.com/success";
    self.paymentParam.FURL = @"https://payu.herokuapp.com/failure";
    self.paymentParam.udf1 = @"u1";
    self.paymentParam.udf2 = @"u2";
    self.paymentParam.udf3 = @"u3";
    self.paymentParam.udf4 = @"u4";
    self.paymentParam.udf5 = @"u5";
    
//    self.paymentParam.environment = ENVIRONMENT_PRODUCTION;
    [self setEnvironment:ENVIRONMENT_PRODUCTION];
    //It is a security vulnerability to keep salt in the app.
    //We are using here for demonstration purpose only. Never do that.
    //Keep salt on your server.
    [self setSalt:@"1b1b0"];
    
    self.paymentParam.offerKey = @"test123@6622"; //bins@8427,srioffer@8428,cc2@8429,gtkffx@7236
    
    [self initialSetupForViewInput];
    [self addPaymentResponseNotofication];
}

- (void)setEnvironment:(NSString*)env {
    self.paymentParam.environment = env;
    if ([env isEqualToString:ENVIRONMENT_PRODUCTION]) {
        self.paymentParam.key = @"smsplus";
    } else {
        self.paymentParam.key = @"gtKFFx";
    }
}

-(void)setSalt:(NSString *) salt{
    [self.switchForSalt setOn:YES];
    self.textFieldSalt.hidden = false;

    self.textFieldSalt.text = salt;

}

-(void)initialSetupForViewInput{
    self.textFieldKey.text = self.paymentParam.key;
    self.textFieldAmount.text = self.paymentParam.amount;
    self.textFieldProductInfo.text = self.paymentParam.productInfo;
    self.textFieldFirstName.text = self.paymentParam.firstName;
    self.textFieldEmail.text = self.paymentParam.email;
    self.textFieldTransactionID.text = [PUSAHelperClass getTransactionIDWithLength:15];
    self.textFieldUserCredential.text = self.paymentParam.userCredentials;
    self.textFieldPhone.text = self.paymentParam.phoneNumber;
    self.textFieldSURL.text = self.paymentParam.SURL;
    self.textFieldFURL.text = self.paymentParam.FURL;
    self.textFieldUDF1.text = self.paymentParam.udf1;
    self.textFieldUDF2.text = self.paymentParam.udf2;
    self.textFieldUDF3.text = self.paymentParam.udf3;
    self.textFieldUDF4.text = self.paymentParam.udf4;
    self.textFieldUDF5.text = self.paymentParam.udf5;
    self.textFieldEnvironment.text = self.paymentParam.environment;
    self.textFieldOfferKey.text = self.paymentParam.offerKey;
    
}

-(void)addPaymentResponseNotofication{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responseReceived:) name:kPUUINotiPaymentResponse object:nil];
    
}

-(void)responseReceived:(NSNotification *) notification{
    [self.navigationController popToRootViewControllerAnimated:NO];
//    self.textFieldTransactionID.text = [PUSAHelperClass getTransactionIDWithLength:15];
    NSString *strConvertedRespone = [NSString stringWithFormat:@"%@",notification.object];
    NSLog(@"Response Received %@",strConvertedRespone);
    
    NSError *serializationError;
    id JSON = [NSJSONSerialization JSONObjectWithData:[strConvertedRespone dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&serializationError];
    if (serializationError == nil && notification.object) {
        NSLog(@"%@",JSON);
        PAYUALERT([JSON objectForKey:@"status"], strConvertedRespone);
        if ([[JSON objectForKey:@"status"] isEqual:@"success"]) {
            NSString *merchant_hash = [JSON objectForKey:@"merchant_hash"];
            if ([[JSON objectForKey:@"card_token"] length] >1 && merchant_hash.length >1 && self.paymentParam) {
                NSLog(@"Saving merchant hash---->");
                [PUSAHelperClass saveOneTapTokenForMerchantKey:self.paymentParam.key withCardToken:[JSON objectForKey:@"card_token"] withUserCredential:self.paymentParam.userCredentials andMerchantHash:merchant_hash withCompletionBlock:^(NSString *message, NSString *errorString) {
                    if (errorString == nil) {
                        NSLog(@"Merchant Hash saved succesfully %@",message);
                    }
                    else{
                        NSLog(@"Error while saving merchant hash %@", errorString);
                    }
                }];
            }
        }
    }
    else{
        PAYUALERT(@"Response", strConvertedRespone);
    }
}

- (IBAction)clickedBtnStart:(id)sender {
    _isStartBtnTapped = YES;
    [self setPaymentParamAndStartProcess];
}
- (IBAction)btnClickedVerifyAPI:(id)sender {
    _isVerifyAPIBtnTapped = YES;
    [self setPaymentParamAndStartProcess];
}

-(void)setPaymentParamAndStartProcess{
    self.paymentParam.key = self.textFieldKey.text;
    self.paymentParam.transactionID = self.textFieldTransactionID.text;
    self.paymentParam.amount = self.textFieldAmount.text;
    self.paymentParam.productInfo = self.textFieldProductInfo.text;
    self.paymentParam.SURL = self.textFieldSURL.text;
    self.paymentParam.FURL = self.textFieldFURL.text;
    self.paymentParam.firstName = self.textFieldFirstName.text;
    self.paymentParam.email = self.textFieldEmail.text;
    self.paymentParam.phoneNumber = self.textFieldPhone.text;
    self.paymentParam.environment = self.textFieldEnvironment.text;
    self.paymentParam.offerKey = self.textFieldOfferKey.text;
    self.paymentParam.udf1 = self.textFieldUDF1.text;
    self.paymentParam.udf2 = self.textFieldUDF2.text;
    self.paymentParam.udf3 = self.textFieldUDF3.text;
    self.paymentParam.udf4 = self.textFieldUDF4.text;
    self.paymentParam.udf5 = self.textFieldUDF5.text;
    self.paymentParam.userCredentials = self.textFieldUserCredential.text;
  
    // set notify URL if you want to pay through Lazy Pay
    self.paymentParam.notifyURL= @"https://notifyURL.com";
 
  
    [self setSubventionParamter];
    [self setOfferKey];
    
    [self dismissKeyboard];
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
    
    if (self.switchForSalt.on) {
        PayUDontUseThisClass *obj = [PayUDontUseThisClass new];
        [obj getPayUHashesWithPaymentParam:self.paymentParam merchantSalt:self.textFieldSalt.text withCompletionBlock:^(PayUModelHashes *allHashes, PayUModelHashes *hashString, NSString *errorMessage) {
            [self callSDKWithHashes:allHashes withError:errorMessage];
        }];
    }
    else{
        [PUSAHelperClass generateHashFromServer:self.paymentParam withCompletionBlock:^(PayUModelHashes *hashes, NSString *errorString) {
            [self callSDKWithHashes:hashes withError:errorString];
        }];
        
    }
}

-(void)callSDKWithHashes:(PayUModelHashes *) allHashes withError:(NSString *) errorMessage{
    if (errorMessage == nil) {
        self.paymentParam.hashes = allHashes;
        if (self.switchForOneTap.on) {
            [PUSAHelperClass getOneTapTokenDictionaryFromServerWithPaymentParam:self.paymentParam CompletionBlock:^(NSDictionary *CardTokenAndOneTapToken, NSString *errorString) {
                if (errorMessage) {
                    [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                    PAYUALERT(@"Error", errorMessage);
                }
                else{
                    [self callSDKWithOneTap:CardTokenAndOneTapToken];
                }
            }];
        }
        else{
            [self callSDKWithOneTap:nil];
        }
    }
    else{
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        PAYUALERT(@"Error", errorMessage);
    }
}

-(void) callSDKWithOneTap:(NSDictionary *)oneTapDict{
    
    self.paymentParam.OneTapTokenDictionary = oneTapDict;
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    self.webServiceResponse = [PayUWebServiceResponse new];
    [self.webServiceResponse getPayUPaymentRelatedDetailForMobileSDK:self.paymentParam withCompletionBlock:^(PayUModelPaymentRelatedDetail *paymentRelatedDetails, NSString *errorMessage, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (errorMessage) {
            PAYUALERT(@"Error", errorMessage);
        }
        else{
            if (_isStartBtnTapped) {
                [respo callVASForMobileSDKWithPaymentParam:self.paymentParam];        //FORVAS
                UIStoryboard *stryBrd = [UIStoryboard storyboardWithName:pUUIStoryBoard bundle:nil];
                PUUIPaymentOptionVC * paymentOptionVC = [stryBrd instantiateViewControllerWithIdentifier:VC_IDENTIFIER_PAYMENT_OPTION];
                paymentOptionVC.paymentParam = self.paymentParam;
                paymentOptionVC.paymentRelatedDetail = paymentRelatedDetails;
                _isStartBtnTapped = FALSE;
                [self.navigationController pushViewController:paymentOptionVC animated:true];
            }
            else if (_isVerifyAPIBtnTapped){
                if (self.switchForSalt.on) {
                    UIStoryboard *stryBrd = [UIStoryboard storyboardWithName:verifyAPIStoryBoard bundle:nil];
                    PUVAOptionsVC *verifyAPIOptionsTVC = [stryBrd instantiateViewControllerWithIdentifier:NSStringFromClass([PUVAOptionsVC class])];
                    verifyAPIOptionsTVC.paymentParam = [PayUModelPaymentParams new];
                    verifyAPIOptionsTVC.paymentParam.key = self.paymentParam.key;
                    verifyAPIOptionsTVC.paymentParam.environment = self.paymentParam.environment;
                    verifyAPIOptionsTVC.paymentParam.userCredentials = self.paymentParam.userCredentials;
                    verifyAPIOptionsTVC.paymentParam.hashes.VASForMobileSDKHash = self.paymentParam.hashes.VASForMobileSDKHash;
                    verifyAPIOptionsTVC.paymentRelatedDetail = paymentRelatedDetails;
                    verifyAPIOptionsTVC.salt = self.textFieldSalt.text;
                    _isVerifyAPIBtnTapped = FALSE;
                    [respo callVASForMobileSDKWithPaymentParam:verifyAPIOptionsTVC.paymentParam];        //FORVAS
                    [self.navigationController pushViewController:verifyAPIOptionsTVC animated:true];
                    
                }
                else{
                    PAYUALERT(@"Error", @"For Verify API Salt is mandatory field");
                }
            }
        }
    }];
}



- (IBAction)switchButtonForNil:(id)sender {
    if (self.switchForSalt.on) {
        self.textFieldSalt.hidden = false;
    }
    else{
        self.textFieldSalt.hidden = true;
        self.textFieldSalt.text = @"";
        [self.view endEditing:YES];
    }
}

-(IBAction)switchBtnClickedSVAmount:(id)sender{
    UISwitch *switchbtn = (UISwitch *)sender;
    if (switchbtn.on) {
        // It means user has switched on the button
        // and we need to show textFieldSVAmount
        self.textFieldSVAmount.hidden = NO;
    }
    else{
        // we need to hide textFieldSVAmount
        self.textFieldSVAmount.hidden = YES;
    }
}

-(IBAction)switchBtnClickedSVEligibility:(id)sender{
    UISwitch *switchbtn = (UISwitch *)sender;
    if (switchbtn.on) {
        // It means user has switched on the button
        // and we need to show textFieldSVEligibility
        self.textFieldSVEligibility.hidden = NO;
    }
    else{
        // we need to hide textFieldSVEligibility
        self.textFieldSVEligibility.hidden = YES;
    }
}

-(void)setSubventionParamter{
    // set SVAmount and SVEligibility if switch is on
    
    if (self.switchBtnSVAmount.on) {
        self.paymentParam.subventionAmount = self.textFieldSVAmount.text;
    }
    else{
        self.paymentParam.subventionAmount = nil;
    }
    
    if (self.switchBtnSVEligibility.on) {
        self.paymentParam.subventionEligibility = self.textFieldSVEligibility.text;
    }
    else{
        self.paymentParam.subventionEligibility = nil;
    }
}

- (IBAction)switchBtnClickedOfferKey:(id)sender {
    UISwitch *switchbtn = (UISwitch *)sender;
    if (switchbtn.on) {
        // It means user has switched on the button
        // and we need to show textFieldOfferKey
        self.textFieldOfferKey.hidden = NO;
    }
    else{
        // we need to hide textFieldOfferKey
        self.textFieldOfferKey.hidden = YES;
    }
}

-(void)setOfferKey{
    if (self.switchBtnOfferKey.on) {
        self.paymentParam.offerKey = self.textFieldOfferKey.text;
    }
    else{
        self.paymentParam.offerKey = nil;
    }
}


#pragma UITextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.txtFieldActive = textField;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)txtUPI:(id)sender {
}
@end
