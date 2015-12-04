//
//  PayUSAStartScreenViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 29/09/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUSAStartScreenViewController.h"
#import "PayUUIPaymentOptionViewController.h"
#import "PayUUIConstants.h"
#import "PayUSAGetHashes.h"
#import "iOSDefaultActivityIndicator.h"
#import "PayUSAGetTransactionID.h"

@interface PayUSAStartScreenViewController ()
@property (strong, nonatomic) PayUModelPaymentParams *paymentParam;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (strong, nonatomic) NSMutableArray *listOfNilKeys;
@property (strong, nonatomic) NSArray * listofAllKeys;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;
@property (strong, nonatomic) PayUSAGetHashes *getHashesFromServer;
@property (strong, nonatomic) PayUSAGetTransactionID *getTransactionID;
@property (strong, nonatomic) UISwitch *switchForSalt;


@end

@implementation PayUSAStartScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];
    self.defaultActivityIndicator = [[iOSDefaultActivityIndicator alloc]init];
    self.paymentParam = [PayUModelPaymentParams new];
    self.paymentParam.key = @"0MQaQP"; //gtKFFx //0MQaQP
    self.paymentParam.amount = @"10.0";
    self.paymentParam.productInfo = @"Nokia";
    self.paymentParam.firstName = @"Ram";
    self.paymentParam.email = @"email@testsdk1.com";
    self.paymentParam.userCredentials = @"ra:ra";
    self.paymentParam.phoneNumber = @"1111111111";
    self.paymentParam.SURL = @"https://payu.herokuapp.com/ios_success";
    self.paymentParam.FURL = @"https://payu.herokuapp.com/ios_failure";
    self.paymentParam.udf1 = @"u1";
    self.paymentParam.udf2 = @"u2";
    self.paymentParam.udf3 = @"u3";
    self.paymentParam.udf4 = @"u4";
    self.paymentParam.udf5 = @"u5";
    self.paymentParam.environment = ENVIRONMENT_PRODUCTION;
    self.paymentParam.offerKey = @"test123@6622";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"passData" object:nil];
    
    for (int counter = 1; counter < 18; counter ++) {
        UISwitch *tempSwitch = (UISwitch *)[self.startScreenScrollView viewWithTag:counter];
        tempSwitch.hidden = true;
//        [(UISwitch *)[self.startScreenScrollView viewWithTag:counter++] setHidden:true];
    }
}


-(void)dataReceived:(NSNotification *)noti
{
    NSLog(@"dataReceived from surl/furl:%@", noti.object);
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSString *message = [NSString stringWithFormat:@"%@",noti.object];
    PAYUALERT(@"Status", message);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    self.getTransactionID = [PayUSAGetTransactionID new];

    self.textFieldKey.text = self.paymentParam.key;
    self.textFieldAmount.text = self.paymentParam.amount;
    self.textFieldProductInfo.text = self.paymentParam.productInfo;
    self.textFieldFirstName.text = self.paymentParam.firstName;
    self.textFieldEmail.text = self.paymentParam.email;
    self.textFieldTransactionID.text = [self.getTransactionID getTransactionIDWithLength:15];
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
    [self registerForKeyboardNotifications];
}

- (IBAction)startPayment:(id)sender {
    self.paymentParam = [PayUModelPaymentParams new];
//    int counter = 1;
//    self.paymentParam.key = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldKey.text:nil;
//    self.paymentParam.transactionID = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldTransactionID.text:nil;
//    self.paymentParam.amount = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldAmount.text:nil;
//    self.paymentParam.productInfo = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldProductInfo.text:nil;
//    self.paymentParam.SURL = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldSURL.text:nil;
//    self.paymentParam.FURL = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldFURL.text:nil;
//    self.paymentParam.firstName = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldFirstName.text:nil;
//    self.paymentParam.email = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldEmail.text:nil;
//    self.paymentParam.phoneNumber = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldPhone.text:nil;
//    self.paymentParam.Environment = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldEnvironment.text:nil;
//    self.paymentParam.offerKey = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldOfferKey.text:nil;
//    self.paymentParam.udf1 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF1.text:nil;
//    self.paymentParam.udf2 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF2.text:nil;
//    self.paymentParam.udf3 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF3.text:nil;
//    self.paymentParam.udf4 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF4.text:nil;
//    self.paymentParam.udf5 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF5.text:nil;
//    self.paymentParam.userCredentials = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUserCredential.text:nil;

    
    
    // Use below commented code snippet if using without UISwitch implementation

    
    
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

    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
    self.getHashesFromServer = [PayUSAGetHashes new];
    
    if (self.switchForSalt.on) {
                    PayUDontUseThisClass *obj = [PayUDontUseThisClass new];
        [obj getPayUHashesWithPaymentParam:self.paymentParam merchantSalt:self.textFieldSalt.text withCompletionBlock:^(PayUModelHashes *allHashes, PayUModelHashes *hashString, NSString *errorMessage) {
            if (errorMessage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                    PAYUALERT(@"Error", errorMessage);
                });
            }
            else{
                self.paymentParam.hashes = allHashes;
                PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
                [respo callVASForMobileSDKWithPaymentParam:self.paymentParam];        //FORVAS1
                self.webServiceResponse = [PayUWebServiceResponse new];
                [self.webServiceResponse getPayUPaymentRelatedDetailForMobileSDK:self.paymentParam withCompletionBlock:^(PayUModelPaymentRelatedDetail *paymentRelatedDetails, NSString *errorMessage, id extraParam) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                        if (errorMessage) {
                            PAYUALERT(@"Error", errorMessage);
                        }
                        else{
                            PayUUIPaymentOptionViewController *paymentOptionVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_OPTION];
                            paymentOptionVC.paymentParam = self.paymentParam;
                            paymentOptionVC.paymentRelatedDetail = paymentRelatedDetails;
                            [self.navigationController pushViewController:paymentOptionVC animated:true];
                        }
                    });
                }];
            }
        }];
    }
    else{
        [self.getHashesFromServer generateHashFromServer:self.paymentParam withCompletionBlock:^(PayUModelHashes *hashes, NSString *errorString) {
            if (errorString) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                    PAYUALERT(@"Error", errorString);
                });
            }
            else{
                self.paymentParam.hashes = hashes;
                //            __block PayUHashes *hashfromSDK = [PayUHashes new];
                
                PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
                [respo callVASForMobileSDKWithPaymentParam:self.paymentParam];        //FORVAS1
                self.webServiceResponse = [PayUWebServiceResponse new];
                [self.webServiceResponse getPayUPaymentRelatedDetailForMobileSDK:self.paymentParam withCompletionBlock:^(PayUModelPaymentRelatedDetail *paymentRelatedDetails, NSString *errorMessage, id extraParam) {
                    [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                    if (errorMessage) {
                        PAYUALERT(@"Error", errorMessage);
                    }
                    else{
                        PayUUIPaymentOptionViewController *paymentOptionVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_OPTION];
                        paymentOptionVC.paymentParam = self.paymentParam;
                        paymentOptionVC.paymentRelatedDetail = paymentRelatedDetails;
                        [self.navigationController pushViewController:paymentOptionVC animated:true];
                    }
                }];
            }
        }];

    }
    
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.startScreenScrollView.contentInset = contentInsets;
    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
//        [self.startScreenScrollView setContentOffset:scrollPoint animated:YES];
//    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.startScreenScrollView.contentInset = contentInsets;
    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
}

-(void)handleSingleTap{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:true];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (IBAction)switchButtonForNil:(id)sender {
    self.switchForSalt = (UISwitch *)[self.startScreenScrollView viewWithTag:18];

    if (self.switchForSalt.on) {
        self.textFieldSalt.hidden = false;
    }
    else
        self.textFieldSalt.hidden = true;
}
@end
