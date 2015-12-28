//
//  PayUUINetBankingViewController.m
//  SeamlessTestApp
//
//  Created by Umang Arya on 08/10/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PayUUINetBankingViewController.h"


@interface PayUUINetBankingViewController ()
@property (weak,nonatomic) UITextField *textFieldName;
@end

@implementation PayUUINetBankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableViewNetBanking.delegate = self;
    self.tableViewNetBanking.dataSource = self;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.insideView1 addGestureRecognizer:tap];
    
//    [self keyboardHideShowMethod];
}
-(void)dismissKeyboard {
    [self.bankCodeForNetBanking resignFirstResponder];
    [self.paymentTypeForNetBanking resignFirstResponder];
}
-(void)keyboardHideShowMethod{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap)];
    [self.view addGestureRecognizer:singleTap];
    [self registerForKeyboardNotifications];

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
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    self.view.contentInset = contentInsets;
//    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
//    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your application might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    //    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//    //        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
//    //        [self.startScreenScrollView setContentOffset:scrollPoint animated:YES];
//    //    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    self.startScreenScrollView.contentInset = contentInsets;
//    self.startScreenScrollView.scrollIndicatorInsets = contentInsets;
}

-(void)handleSingleTap{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
//    self.bankCodeForNetBanking.text = @"AXIB";
    if ([self.paymentType isEqual:PAYMENT_PG_CASHCARD]) {
        self.paymentTypeForNetBanking.text = PAYMENT_PG_CASHCARD;
        self.VASButton.hidden = true;
    }
    else{
        self.paymentTypeForNetBanking.text = PAYMENT_PG_NET_BANKING;
        self.VASButton.hidden = false;
    }
    
}

- (IBAction)PayByNetBanking:(id)sender {
    NSString *bankCode = self.bankCodeForNetBanking.text;
    
    self.paymentParam.bankCode = bankCode;
    
    if([bankCode isEqualToString:CASH_CARD_CPMC])
    {
        PayUUICCDCViewController *ccdcView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_CCDC];
        ccdcView.paymentType = PAYMENT_PG_CASHCARD;
        ccdcView.paymentParam = [self.paymentParam copy];
        [self.navigationController pushViewController:ccdcView animated:YES];
    }
    else
    {
        self.createRequest = [PayUCreateRequest new];
        [self.createRequest createRequestWithPaymentParam:self.paymentParam forPaymentType:self.paymentTypeForNetBanking.text withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
            if (error == nil) {
                PayUUIPaymentUIWebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:VIEW_CONTROLLER_IDENTIFIER_PAYMENT_UIWEBVIEW];
                webView.paymentRequest = request;
                webView.paymentParam = self.paymentParam;
                [self.navigationController pushViewController:webView animated:true];
            }
            else{
                [[[UIAlertView alloc] initWithTitle:@"ERROR" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                
            }
        }];
    }
}

#pragma TableView DataSource and Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.paymentType isEqual:PAYMENT_PG_CASHCARD]) {
        return self.paymentRelatedDetail.cashCardArray.count;
    }
    else{
        return self.paymentRelatedDetail.netBankingArray.count;

    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_NETBANKING];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_NETBANKING];
    }
    
    
    if ([self.paymentType isEqual:PAYMENT_PG_CASHCARD]) {
        PayUModelCashCard *modelCashCard = [PayUModelCashCard new];
        modelCashCard = [self.paymentRelatedDetail.cashCardArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = modelCashCard.bankCode;
        cell.detailTextLabel.text = modelCashCard.title;
    }
    else{
        PayUModelNetBanking *modelNetBanking = [PayUModelNetBanking new];
        modelNetBanking = [self.paymentRelatedDetail.netBankingArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = modelNetBanking.bankCode;
        cell.detailTextLabel.text = modelNetBanking.title;
    }
    
    

    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.paymentType isEqual:PAYMENT_PG_CASHCARD]) {
        PayUModelCashCard *modelCashCard = [PayUModelCashCard new];
        modelCashCard = [self.paymentRelatedDetail.cashCardArray objectAtIndex:indexPath.row];
        self.bankCodeForNetBanking.text = modelCashCard.bankCode;
    }
    else{
        PayUModelNetBanking *modelNetBanking = [PayUModelNetBanking new];
        modelNetBanking = [self.paymentRelatedDetail.netBankingArray objectAtIndex:indexPath.row];
        self.bankCodeForNetBanking.text = modelNetBanking.bankCode;
    }
}

- (IBAction)checkVAS:(id)sender {
    PayUWebServiceResponse *respo = [PayUWebServiceResponse new];
    
    [respo getVASStatusForCardBinOrBankCode:self.bankCodeForNetBanking.text withCompletionBlock:^(id ResponseMessage, NSString *errorMessage, id extraParam) {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
