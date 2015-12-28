//
//  PayUUIStoredCardViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUIStoredCardViewController.h"
#import "PayUSAOneTapToken.h"
#import "iOSDefaultActivityIndicator.h"


@interface PayUUIStoredCardViewController ()

@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;

@end

@implementation PayUUIStoredCardViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewStoredCard.delegate = self;
    self.tableViewStoredCard.dataSource = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.viewInside1 addGestureRecognizer:tap];
    
    if ([self.paymentType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
        [self hideStoredCardObject];
        self.paymentType = PAYMENT_PG_ONE_TAP_STOREDCARD;
    }
    else{
        self.textFieldCVV.hidden = false;
        self.paymentType = PAYMENT_PG_STOREDCARD;
        if (self.paymentParam.OneTapTokenDictionary == nil) {
            self.switchForOneTap.hidden = true;
            self.labelEnableOneTap.hidden = true;
        }
        else{
            self.switchForOneTap.hidden = false;
            self.labelEnableOneTap.hidden = false;
        }
    }
}

-(void)hideStoredCardObject{
    self.textFieldCVV.hidden = true;
    self.switchForOneTap.hidden = true;
    self.labelEnableOneTap.hidden = true;
}

-(void)dismissKeyboard {
    [self.textFieldPaymentTypeForSC resignFirstResponder];
    [self.textFieldCVV resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
}


#pragma TableView DataSource and Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.paymentType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
        return self.paymentRelatedDetail.oneTapStoredCardArray.count;
    }
    else{
        return self.paymentRelatedDetail.storedCardArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_STOREDCARD];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_STOREDCARD];
    }
    PayUModelStoredCard *modelStoredCard = [PayUModelStoredCard new];
    if ([self.paymentType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
        modelStoredCard = [self.paymentRelatedDetail.oneTapStoredCardArray objectAtIndex:indexPath.row];
    }
    else{
        modelStoredCard = [self.paymentRelatedDetail.storedCardArray objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = modelStoredCard.cardNo;
    cell.detailTextLabel.text = modelStoredCard.cardName;
    return cell;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self configurePaymentParamWithIndex:indexPath.row];
}

-(void)configurePaymentParamWithIndex:(NSInteger) index{
    PayUModelStoredCard *modelStoredCard = [PayUModelStoredCard new];
    //    PayUModelStoredCard *modelStoredCard = [self.paymentRelatedDetail.storedCardArray objectAtIndex:indexPath.row];
    if ([self.paymentType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
        modelStoredCard = [self.paymentRelatedDetail.oneTapStoredCardArray objectAtIndex:index];
    }
    else{
        modelStoredCard = [self.paymentRelatedDetail.storedCardArray objectAtIndex:index];
    }
    self.paymentParam.cardToken = modelStoredCard.cardToken;
    self.paymentParam.cardBin = modelStoredCard.cardBin;
    self.paymentParam.oneTapFlag = modelStoredCard.oneTapFlag;
}
-(PayUModelPaymentParams *) getPaymentParam{
    return self.paymentParam;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)PayBySC:(id)sender {
    
    self.createRequest = [PayUCreateRequest new];
    if ([self.paymentType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
        //self.paymentParam.isPaymentTypeOneTap = true;
        //            self.paymentParam.
    }
    else{
        self.paymentParam.CVV = self.textFieldCVV.text;
        if (self.switchForOneTap.on) {
            self.paymentParam.isOneTap = 1;
        }
    }
    
    
    [self.createRequest createRequestWithPaymentParam:self.paymentParam forPaymentType:self.paymentType withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error == nil) {
            //            UIStoryboard *stryBrd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
            webView.paymentRequest = request;
            webView.paymentParam = self.paymentParam;
            //            UINavigationController *navgCtr = (UINavigationController *)[stryBrd instantiateViewControllerWithIdentifier:NAVIGATION_CONTROLLER_IDENTIFIER];
            [self.navigationController pushViewController:webView animated:true];
            //            [navgCtr setModalTransitionStyle:UIModalTransitionStylePartialCurl];
            //            [self presentViewController:navgCtr animated:true completion:nil];
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"ERROR" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            
        }
    }];
}

- (IBAction)deleteStoredCard:(id)sender {
    self.defaultActivityIndicator = [[iOSDefaultActivityIndicator alloc]init];
    [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
    self.view.userInteractionEnabled = NO;
    
    //    if ([self.paymentType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
    //        PayUSAOneTapToken *oneTapToken = [PayUSAOneTapToken new];
    //        [oneTapToken deleteOneTapTokenForCardToken:self.paymentParam.cardToken withCompletionBlock:^(NSString *message, NSString *errorString) {
    //            [self.defaultActivityIndicator stopAnimatingActivityIndicator];
    //            if (errorString == nil) {
    //                [[NSNotificationCenter defaultCenter] postNotificationName:@"passData" object:message];
    //            }
    //            else{
    //                PAYUALERT(@"Error", errorString);
    //            }
    //        }];
    //    }
    //    else{
    self.webServiceResponse = [PayUWebServiceResponse new];
    [self.webServiceResponse deleteStoredCard:self.paymentParam withCompletionBlock:^(NSString *deleteStoredCardStatus, NSString *deleteStoredCardMessage, NSString *errorMessage, id extraParam) {
        [self.defaultActivityIndicator stopAnimatingActivityIndicator];
        if (errorMessage == nil) {
            NSString *fullMessage =[NSString stringWithFormat:@"Status:%@ & Message:%@",deleteStoredCardStatus,deleteStoredCardMessage];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"passData" object:fullMessage];
        }
        else
            PAYUALERT(@"Error",errorMessage);
    }];
    //    }
}

- (IBAction)checkVAS:(id)sender {
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    
    [respo getVASStatusForCardBinOrBankCode:self.paymentParam.cardBin withCompletionBlock:^(id ResponseMessage, NSString *errorMessage, id extraParam) {
        //
        if (errorMessage == nil) {
            //
            if (ResponseMessage == nil) {
                PAYUALERT(@"Yeahh", @"Good to Go");
            }
            else{
                NSString * responseData = [NSString new];
                responseData = [NSString stringWithFormat:@"%@",ResponseMessage];//(NSDictionary *) ResponseMessage;
                PAYUALERT(@"Down Time Message",responseData);
            }
        }
        else{
            PAYUALERT(@"Error", errorMessage);
        }
    }];
}




@end
