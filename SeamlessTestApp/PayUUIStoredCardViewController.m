//
//  PayUUIStoredCardViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUIStoredCardViewController.h"

@interface PayUUIStoredCardViewController ()

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
}

-(void)dismissKeyboard {
    [self.textFieldPaymentTypeForSC resignFirstResponder];
    [self.textFieldCVV resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    self.textFieldPaymentTypeForSC.text = @"SC";
}


#pragma TableView DataSource and Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.paymentRelatedDetail.storedCardArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_STOREDCARD];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_STOREDCARD];
    }
    
    PayUModelStoredCard *modelStoredCard = [PayUModelStoredCard new];
    modelStoredCard = [self.paymentRelatedDetail.storedCardArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = modelStoredCard.cardNo;
    cell.detailTextLabel.text = modelStoredCard.cardName;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PayUModelStoredCard *modelStoredCard = [PayUModelStoredCard new];
    modelStoredCard = [self.paymentRelatedDetail.storedCardArray objectAtIndex:indexPath.row];
    self.paymentParam.cardToken = modelStoredCard.cardToken;
//    self.paymentParam.cardMode = modelStoredCard.cardMode;
//    self.paymentParam.cardType = modelStoredCard.cardType;
    self.paymentParam.cardBin = modelStoredCard.cardBin;
//    self.paymentParam.storedCard = [self.paymentRelatedDetail.storedCardArray objectAtIndex:indexPath.row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)PayBySC:(id)sender {
    self.paymentParam.CVV = self.textFieldCVV.text;
    self.createRequest = [PayUCreateRequest new];
    [self.createRequest createRequestWithPaymentParam:self.paymentParam forPaymentType:self.textFieldPaymentTypeForSC.text withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error == nil) {
            PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
            webView.paymentRequest = request;
            [self.navigationController pushViewController:webView animated:true];
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"ERROR" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            
        }
    }];
}

- (IBAction)deleteStoredCard:(id)sender {
    self.webServiceResponse = [PayUWebServiceResponse new];
    [self.webServiceResponse deleteStoredCard:self.paymentParam withCompletionBlock:^(NSString *deleteStoredCardStatus, NSString *deleteStoredCardMessage, NSString *errorMessage, id extraParam) {
        if (errorMessage == nil) {
            NSString *fullMessage =[NSString stringWithFormat:@"Status:%@ & Message:%@",deleteStoredCardStatus,deleteStoredCardMessage];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"passData" object:fullMessage];
        }
        else
        PAYUALERT(@"Error",errorMessage);
    }];
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
