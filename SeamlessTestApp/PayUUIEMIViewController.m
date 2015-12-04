//
//  PayUUIEMIViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 28/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUIEMIViewController.h"

@interface PayUUIEMIViewController ()

@property (nonatomic, strong) PayUCreateRequest *createRequest;
@property (nonatomic, strong) PayUValidations *validations;
@property (strong, nonatomic) PayUWebServiceResponse *webServiceResponse;
@property (strong, nonatomic) NSMutableArray *bankNameArray;
@property (strong, nonatomic) NSMutableArray *arrayOfIndexForSelectedBank;//arrayOfIndexForSelectedBank


@end

@implementation PayUUIEMIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewBankName.delegate = self;
    self.tableViewBankName.dataSource = self;
    
    self.tableViewEMIDuration.delegate = self;
    self.tableViewEMIDuration.dataSource = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.bottomView addGestureRecognizer:tap];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    self.bankNameArray = [NSMutableArray new];
    for (PayUModelEMI *modelEMI in self.paymentRelatedDetail.EMIArray) {
        if (self.bankNameArray.count) {
            if (![self.bankNameArray containsObject:modelEMI.bankName]) {
                [self.bankNameArray addObject:modelEMI.bankName];
            }
        }
        else{
            [self.bankNameArray addObject:modelEMI.bankName];
        }
    }
}

-(void)dismissKeyboard {
    [self.textFieldCardNumber resignFirstResponder];
    [self.textFieldCVV resignFirstResponder];
    [self.textFieldExpiryMonth resignFirstResponder];
    [self.textFieldExpiryYear resignFirstResponder];
    [self.textFieldNameOnCard resignFirstResponder];
}

-(void)payByEMI:(id)sender{

    self.paymentParam.expiryYear = self.textFieldExpiryYear.text;
    self.paymentParam.expiryMonth = self.textFieldExpiryMonth.text;
    self.paymentParam.nameOnCard = self.textFieldNameOnCard.text;
    self.paymentParam.cardNumber = self.textFieldCardNumber.text;
    self.paymentParam.CVV = self.textFieldCVV.text;
    self.createRequest = [PayUCreateRequest new];
    [self.createRequest createRequestWithPaymentParam:self.paymentParam forPaymentType:PAYMENT_PG_EMI withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error == nil) {
            PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
            webView.paymentRequest = request;
            webView.merchantKey = self.paymentParam.key;
            webView.txnID = self.paymentParam.transactionID;
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

-(void)checkCardBrand:(id)sender{
    self.validations = [PayUValidations new];
    self.labelCardBrandName.text = [self.validations getIssuerOfCardNumber:self.textFieldCardNumber.text];
}

-(void)checkVAS:(id)sender{
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    
    [respo getVASStatusForCardBinOrBankCode:self.textFieldCardNumber.text withCompletionBlock:^(id ResponseMessage, NSString *errorMessage, id extraParam) {
        //
        if (errorMessage == nil) {
            //
            if (ResponseMessage == nil) {
                PAYUALERT(@"Yeahh", @"Good to Go");
            }
            else{
                NSString * responseMessage = [NSString new];
                responseMessage = (NSString *) ResponseMessage;
                PAYUALERT(@"Down Time Message", responseMessage);
            }
        }
        else{
            PAYUALERT(@"Error", errorMessage);
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PayUModelEMI *modelEMIForParsing;
    if (tableView == self.tableViewBankName){
        self.paymentParam.bankCode = nil;
        modelEMIForParsing = [PayUModelEMI new];
        self.arrayOfIndexForSelectedBank = [NSMutableArray new];
        for (int counter = 0; counter < self.paymentRelatedDetail.EMIArray.count; counter++) {
            modelEMIForParsing = [self.paymentRelatedDetail.EMIArray objectAtIndex:counter];
            if ([modelEMIForParsing.bankName isEqual:[self.bankNameArray objectAtIndex:indexPath.row]]) {
                [self.arrayOfIndexForSelectedBank addObject:[NSNumber numberWithInt:counter]];
            }
        }
        [self.tableViewEMIDuration reloadData];
    }
    else{
        modelEMIForParsing = [PayUModelEMI new];
        modelEMIForParsing = [self.paymentRelatedDetail.EMIArray objectAtIndex:[[self.arrayOfIndexForSelectedBank objectAtIndex:indexPath.row] integerValue]];
        self.paymentParam.bankCode = modelEMIForParsing.bankCode;
        NSLog(@"EMI selected BankCode%@",self.paymentParam.bankCode);
        NSLog(@"EMI selected BankName%@",modelEMIForParsing.bankName);
        NSLog(@"EMI selected Title%@",modelEMIForParsing.title);
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableViewBankName){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_EMI_BANKNAME];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_EMI_BANKNAME];
        }
        cell.textLabel.text = [self.bankNameArray objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_EMI_DURATION];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_EMI_DURATION];
        }
        PayUModelEMI *modelEMI = [PayUModelEMI new];
        NSLog(@"%@",[self.arrayOfIndexForSelectedBank objectAtIndex:indexPath.row]);
        modelEMI = [self.paymentRelatedDetail.EMIArray objectAtIndex:[[self.arrayOfIndexForSelectedBank objectAtIndex:indexPath.row] integerValue]];
        cell.textLabel.text = modelEMI.title;
        return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableViewBankName){
        return self.bankNameArray.count;
    }
    else{
        NSLog(@"Number of Index %lu",(unsigned long)self.arrayOfIndexForSelectedBank.count);
        return self.arrayOfIndexForSelectedBank.count;
    }
//    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
