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
@property (strong, nonatomic) PayUModelPaymentParams *paymentParamForPassing;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (strong, nonatomic) NSMutableArray *listOfNilKeys;
@property (strong, nonatomic) NSArray * listofAllKeys;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;
@property (strong, nonatomic) PayUSAGetHashes *getHashesFromServer;
@property (strong, nonatomic) PayUSAGetTransactionID *getTransactionID;


@end

@implementation PayUSAStartScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];
    self.defaultActivityIndicator = [[iOSDefaultActivityIndicator alloc]init];
    self.paymentParamForPassing = [PayUModelPaymentParams new];
    self.paymentParamForPassing.key = @"gtKFFx";
    self.paymentParamForPassing.amount = @"10.0";
    self.paymentParamForPassing.productInfo = @"Nokia";
    self.paymentParamForPassing.firstName = @"Ram";
    self.paymentParamForPassing.email = @"email@testsdk1.com";
    self.paymentParamForPassing.userCredentials = @"ra:ra";
    self.paymentParamForPassing.phoneNumber = @"1111111111";
    self.paymentParamForPassing.SURL = @"https://payu.herokuapp.com/ios_success";
    self.paymentParamForPassing.FURL = @"https://payu.herokuapp.com/ios_failure";
    self.paymentParamForPassing.udf1 = @"u1";
    self.paymentParamForPassing.udf2 = @"u2";
    self.paymentParamForPassing.udf3 = @"u3";
    self.paymentParamForPassing.udf4 = @"u4";
    self.paymentParamForPassing.udf5 = @"u5";
    self.paymentParamForPassing.Environment = @"1";
    self.paymentParamForPassing.offerKey = @"offertest@1411";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"passData" object:nil];
//    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
//    [respo callVASForMobileSDKWithPaymentParam:self.paymentParamForPassing];        //FORVAS1

}


-(void)dataReceived:(NSNotification *)noti
{
    NSLog(@"dataReceived from surl/furl:%@", noti.object);
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSString *message = [NSString stringWithFormat:@"%@",noti.object];
    PAYUALERT(@"Status", message);
//    
////    _dataResponse=noti.object;
//    if(_dataResponse)
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Data" message:_dataResponse delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
//        [alert show];
//    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    self.getTransactionID = [PayUSAGetTransactionID new];

    self.textFieldKey.text = self.paymentParamForPassing.key;
    self.textFieldAmount.text = self.paymentParamForPassing.amount;
    self.textFieldProductInfo.text = self.paymentParamForPassing.productInfo;
    self.textFieldFirstName.text = self.paymentParamForPassing.firstName;
    self.textFieldEmail.text = self.paymentParamForPassing.email;
    self.textFieldTransactionID.text = [self.getTransactionID getTransactionIDWithLength:15];
    self.textFieldUserCredential.text = self.paymentParamForPassing.userCredentials;
    self.textFieldPhone.text = self.paymentParamForPassing.phoneNumber;
    self.textFieldSURL.text = self.paymentParamForPassing.SURL;
    self.textFieldFURL.text = self.paymentParamForPassing.FURL;
    self.textFieldUDF1.text = self.paymentParamForPassing.udf1;
    self.textFieldUDF2.text = self.paymentParamForPassing.udf2;
    self.textFieldUDF3.text = self.paymentParamForPassing.udf3;
    self.textFieldUDF4.text = self.paymentParamForPassing.udf4;
    self.textFieldUDF5.text = self.paymentParamForPassing.udf5;
    self.textFieldEnvironment.text = self.paymentParamForPassing.Environment;
    self.textFieldOfferKey.text = self.paymentParamForPassing.offerKey;
    [self registerForKeyboardNotifications];
}

- (IBAction)startPayment:(id)sender {
    self.paymentParamForPassing = [PayUModelPaymentParams new];
    int counter = 1;
    self.paymentParamForPassing.key = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldKey.text:nil;
    self.paymentParamForPassing.transactionID = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldTransactionID.text:nil;
    self.paymentParamForPassing.amount = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldAmount.text:nil;
    self.paymentParamForPassing.productInfo = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldProductInfo.text:nil;
    self.paymentParamForPassing.SURL = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldSURL.text:nil;
    self.paymentParamForPassing.FURL = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldFURL.text:nil;
    self.paymentParamForPassing.firstName = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldFirstName.text:nil;
    self.paymentParamForPassing.email = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldEmail.text:nil;
    self.paymentParamForPassing.phoneNumber = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldPhone.text:nil;
    self.paymentParamForPassing.Environment = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldEnvironment.text:nil;
    self.paymentParamForPassing.offerKey = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldOfferKey.text:nil;
    self.paymentParamForPassing.udf1 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF1.text:nil;
    self.paymentParamForPassing.udf2 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF2.text:nil;
    self.paymentParamForPassing.udf3 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF3.text:nil;
    self.paymentParamForPassing.udf4 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF4.text:nil;
    self.paymentParamForPassing.udf5 = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUDF5.text:nil;
    self.paymentParamForPassing.userCredentials = ((UISwitch *) [self.startScreenScrollView viewWithTag:counter++]).on?self.textFieldUserCredential.text:nil;

    
    
    // Use below commented code snippet if using without UISwitch implementation

//    self.paymentParamForPassing.key = self.textFieldKey.text;
//    self.paymentParamForPassing.transactionID = self.textFieldTransactionID.text;
//    self.paymentParamForPassing.amount = self.textFieldAmount.text;
//    self.paymentParamForPassing.productInfo = self.textFieldProductInfo.text;
//    self.paymentParamForPassing.SURL = self.textFieldSURL.text;
//    self.paymentParamForPassing.FURL = self.textFieldFURL.text;
//    self.paymentParamForPassing.firstName = self.textFieldFirstName.text;
//    self.paymentParamForPassing.email = self.textFieldEmail.text;
//    self.paymentParamForPassing.phoneNumber = self.textFieldPhone.text;
//    self.paymentParamForPassing.Environment = self.textFieldEnvironment.text;
//    self.paymentParamForPassing.offerKey = self.textFieldOfferKey.text;
//    self.paymentParamForPassing.udf1 = self.textFieldUDF1.text;
//    self.paymentParamForPassing.udf2 = self.textFieldUDF2.text;
//    self.paymentParamForPassing.udf3 = self.textFieldUDF3.text;
//    self.paymentParamForPassing.udf4 = self.textFieldUDF4.text;
//    self.paymentParamForPassing.udf5 = self.textFieldUDF5.text;
//    self.paymentParamForPassing.userCredentials = self.textFieldUserCredential.text;
    
    
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
    self.getHashesFromServer = [PayUSAGetHashes new];
    [self.getHashesFromServer generateHashFromServer:self.paymentParamForPassing withCompletionBlock:^(PayUHashes *hashes, NSString *errorString) {
        if (errorString) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                PAYUALERT(@"Error", errorString);
            });
        }
        else{
            self.paymentParamForPassing.hashes = hashes;
                PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
                [respo callVASForMobileSDKWithPaymentParam:self.paymentParamForPassing];        //FORVAS1
            self.webServiceResponse = [PayUWebServiceResponse new];
            [self.webServiceResponse getPayUPaymentRelatedDetailForMobileSDK:self.paymentParamForPassing withCompletionBlock:^(PayUModelPaymentRelatedDetail *paymentRelatedDetails, NSString *errorMessage, id extraParam) {
                [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                if (errorMessage) {
                    PAYUALERT(@"Error", errorString);
                }
                else{
                        PayUUIPaymentOptionViewController *paymentOptionVC = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_OPTION];
                        paymentOptionVC.paymentParam = self.paymentParamForPassing;
                        paymentOptionVC.paymentRelatedDetail = paymentRelatedDetails;
                        [self.navigationController pushViewController:paymentOptionVC animated:true];
                }
            }];
        }
    }];
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
}
@end
