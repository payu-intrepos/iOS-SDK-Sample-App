//
//  ViewController.m
//  PayUTestApp
//
//  Created by Suryakant Sharma on 14/02/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#import "ViewController.h"
#import "PayUConnectionHandlerController.h"
#import "PayUPaymentResultViewController.h"

#define USER_CARD       @"user_cards"
#define CARD_NUMBER     @"card_no"
#define CARD_NAME       @"card_name"
#define CARD_TOKEN      @"card_token"

#define BANK_TITLE              @"title"
#define NET_BANKING             @"netbanking"
#define PARAM_BANK_CODE         @"bankcode"


@interface ViewController () <UITableViewDataSource,UITableViewDelegate,PayUConnectionHandlerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cardNumber;

@property (weak, nonatomic) IBOutlet UITextField *cardName;
@property (weak, nonatomic) IBOutlet UITextField *mm;
@property (weak, nonatomic) IBOutlet UITextField *yy;
@property (weak, nonatomic) IBOutlet UITextField *cvv;
@property (weak, nonatomic) IBOutlet UITextField *cardNameToStore;
@property (weak, nonatomic) IBOutlet UITextField *bankCode;



@property (weak, nonatomic) IBOutlet UITextField *ccordc;
@property (weak, nonatomic) IBOutlet UITableView *StoredCard;
@property (weak, nonatomic) IBOutlet UIButton *PayNowButton;
@property (weak, nonatomic) IBOutlet UITableView *storedCardTableView;
@property (weak, nonatomic) IBOutlet UITableView *nbTableView;

@property (nonatomic,strong) PayUConnectionHandlerController *connectionHandler;

- (IBAction)payNow:(id)sender;

@property (nonatomic, strong) NSDictionary *storedCardDict;
@property (nonatomic, strong) NSDictionary *netBanking;

@property (nonatomic,strong) NSMutableArray *cardList;

@property(nonatomic,strong) NSArray *bankDetails;

@property(nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) CGPoint originalCenter;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storedCardTableView.dataSource = self;
    _storedCardTableView.delegate  = self;
    
    _nbTableView.dataSource = self;
    _nbTableView.delegate  = self;
    
    _connectionHandler = [[PayUConnectionHandlerController alloc] init:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"product",@"productinfo",
                            @"username",@"firstname",
                            [NSNumber numberWithFloat:1.36],@"amount",
                            @"email@testsdk.com",@"email",
                            @"9999999999", @"phone",
                            @"https://dl.dropboxusercontent.com/s/y911hgtgdkkiy0w/success_iOS.html",@"surl",
                            @"https://dl.dropboxusercontent.com/s/h6m11xr93mxhfvf/Failure_iOS.html",@"furl",
                            [self randomStringWithLength:15],@"txnid",
                            @"ra:ra",@"user_credentials", nil]];
    
    //_connectionHandler.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [_connectionHandler listOfStoredCardWithCallback:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *errorJson=nil;
         NSMutableDictionary* allStoredCards = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson] mutableCopy];
         NSLog(@"listOfStoredCardWithCallback response = %@, JSONerror = %@ NSURLConnection = %@",allStoredCards,errorJson,connectionError);
        [self listAllStoredCard :allStoredCards];
        [_StoredCard performSelectorOnMainThread:@selector(reloadData) withObject:_StoredCard waitUntilDone:NO];
    }];
    
    [_connectionHandler listOfInternetBankingOptionCallback:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *errorJson=nil;
        NSMutableDictionary* allStoredCards = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson] mutableCopy];
        NSLog(@"listOfInternetBankingOption response = %@, JSONerror = %@ NSURLConnection = %@",allStoredCards,errorJson,connectionError);
         [self extractAllInternetBankingOption : allStoredCards];
        [_nbTableView performSelectorOnMainThread:@selector(reloadData) withObject:_nbTableView waitUntilDone:NO];

    }];
    
    _originalCenter = self.view.center;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transactionDone) name:@"payment_success_notifications" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transactionDone) name:@"payment_failure_notifications" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transactionDone) name:@"payment_cancel_notifications" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancel:)
        name:@"payu_notifications" object:nil];

    
}

-(void) transactionDone{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new center to your view
    [UIView animateWithDuration:0.2
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.center = CGPointMake(_originalCenter.x, _originalCenter.y - 140);
                     }
                     completion:nil];
    
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    // Assign original center to your view
    [UIView animateWithDuration:0.2
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.view.center = _originalCenter;
                     }
                     completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength:(int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }
    
    return randomString;
}

- (IBAction)payNow:(id)sender {
    
    NSMutableDictionary *paramDict = [NSMutableDictionary new];
    
    [paramDict setValue:_cardName.text forKey:@"ccname"];
    [paramDict setValue:_cardNumber.text forKey:@"ccnum"];
    
    if(![_mm.text isEqualToString:@""])
        [paramDict setValue:[NSNumber numberWithInt:[_mm.text intValue]] forKey:@"ccexpmon"];
    if(![_yy.text isEqualToString:@""])
        [paramDict setValue:[NSNumber numberWithInt:[_yy.text intValue]] forKey:@"ccexpyr"];
    if(![_cvv.text isEqualToString:@""])
    [paramDict setValue:[NSNumber numberWithInt:[_cvv.text intValue]] forKey:@"ccvv"];
//    [paramDict setValue:_ccordc forKey:@"ccvv"];
    
    if([_ccordc.text isEqualToString:@"1"]){
        [paramDict setValue:[NSNumber numberWithInt:1] forKey:@"store_card"];
        [paramDict setValue:_cardNameToStore.text forKey:@"card_name"];
    }
    
    if( [_bankCode.text caseInsensitiveCompare:@"DC"] == NSOrderedSame){
        [paramDict setValue:@"VISA" forKey:@"bankcode"];
        [paramDict setValue:@"DC" forKey:@"pg"];

    }
    else{
        [paramDict setValue:@"CC" forKey:@"bankcode"];
        [paramDict setValue:@"CC" forKey:@"pg"];
    }
    
    PayUPaymentResultViewController *resultViewController = [[PayUPaymentResultViewController alloc] initWithNibName:@"PayUPaymentResultViewController" bundle:nil];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            resultViewController.flag = YES;
            
        }
        else{
            resultViewController.flag = NO;
        }
        
    }
    
    resultViewController.request = [_connectionHandler URLRequestForCardPayment:paramDict andTransactionID:[self randomStringWithLength:15]];
    //[self presentViewController:resultViewController animated:YES completion:nil];
    resultViewController.flag = NO;
    [self.navigationController pushViewController:resultViewController animated:YES];


}

- (void) listAllStoredCard : (NSDictionary *) allStoredCards{
    NSDictionary *allCard = [allStoredCards objectForKey:USER_CARD];
    if(allCard){
        if(!_cardList){
            _cardList = [[NSMutableArray alloc] init];
        }
        for(NSString *aKey in allCard){
            [_cardList addObject:[allCard objectForKey:aKey]];
        }
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    return YES;
}

- (void) cancel:(NSDictionary *)info{
    NSLog(@"failure Dict: %@",info);
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

// dismiss the keyboard when click on View
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_cardNumber resignFirstResponder];
    [_mm resignFirstResponder];

    [_yy resignFirstResponder];

    [_cardName resignFirstResponder];

    [_cardNameToStore resignFirstResponder];

    [_bankCode resignFirstResponder];
    [_ccordc resignFirstResponder];

    [_cardNameToStore resignFirstResponder];

}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if([tableView isEqual:_storedCardTableView]){
        return _cardList.count;
    }
    else  if([tableView isEqual:_nbTableView]){
        return _bankDetails.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.backgroundColor = [UIColor colorWithRed:240.0f green:240.0f blue:240.0f alpha:1.0f];
    }
    if([tableView isEqual:_storedCardTableView]){
        cell.textLabel.text =  [_cardList[indexPath.row] objectForKey:CARD_NUMBER];
        cell.detailTextLabel.text = [_cardList[indexPath.row] objectForKey:CARD_NAME];

    }
    else{
        cell.textLabel.text = [[_bankDetails objectAtIndex:indexPath.row] valueForKey:@"title"];

    }
    
    return cell;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  
    if(1 == buttonIndex){
        NSString *cvv =  [alertView textFieldAtIndex:0].text;
        [[alertView textFieldAtIndex:0] resignFirstResponder];
        PayUPaymentResultViewController *resultViewController = [[PayUPaymentResultViewController alloc] initWithNibName:@"PayUPaymentResultViewController" bundle:nil];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                resultViewController.flag = YES;
                
            }
            else{
                resultViewController.flag = NO;
            }
            
        }
        NSMutableDictionary *param = [_cardList[_selectedIndex] mutableCopy];
        if(![cvv isEqualToString:@""])
        [param setValue:cvv forKey:@"ccvv"];
        resultViewController.request = [_connectionHandler URLRequestForPaymentWithStoredCard:param andTransactionID:[self randomStringWithLength:15]];
        //[self presentViewController:resultViewController animated:YES completion:nil];
        resultViewController.flag = NO;
        [self.navigationController pushViewController:resultViewController animated:YES];
        
    }


}

#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayUPaymentResultViewController *resultViewController = [[PayUPaymentResultViewController alloc] initWithNibName:@"PayUPaymentResultViewController" bundle:nil];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            resultViewController.flag = YES;
            
        }
        else{
            resultViewController.flag = NO;
        }
        
    }
    
    if([tableView isEqual:_StoredCard]){
        
        _selectedIndex = indexPath.row;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Enter cvv"
                                                       delegate:self
                                              cancelButtonTitle:@"cancel"
                                              otherButtonTitles:@"Done",nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    
    }
    else{
        resultViewController.request = [_connectionHandler URLRequestForInternetBankingWithBankCode:[[_bankDetails objectAtIndex:indexPath.row] valueForKey:@"bankcode"] andTransactionID:[self randomStringWithLength:15]];
//        [self presentViewController:resultViewController animated:YES completion:nil];
        resultViewController.flag = NO;
        [self.navigationController pushViewController:resultViewController animated:YES];


    }
    

    
    
    

}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithRed:240.0/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //[_connectionHandler deleteStoredCardWithCardToken:(NSNumber *)[[_cardList objectAtIndex:indexPath.row] objectForKey:CARD_TOKEN]];
        [_connectionHandler deleteStoredCardWithCardToken:(NSNumber *)[[_cardList objectAtIndex:indexPath.row] objectForKey:CARD_TOKEN] withCompletionBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if(nil == connectionError){
                [_cardList removeObjectAtIndex:indexPath.row];
                [_StoredCard performSelectorOnMainThread:@selector(reloadData) withObject:_StoredCard waitUntilDone:NO];
            }
        }];
        
        
    }
}

-(void) extractAllInternetBankingOption : (NSDictionary *)aDict{
    NSDictionary *allInternetBankingOptionsDict = [aDict objectForKey:NET_BANKING];
    NSMutableArray *allInternetBankingOptions = nil;
    if(allInternetBankingOptionsDict.allKeys.count)
    {
        allInternetBankingOptions =  [[NSMutableArray alloc] init];
        for(NSString *aKey in allInternetBankingOptionsDict){
            NSMutableDictionary *bankDict = [NSMutableDictionary dictionaryWithDictionary:[allInternetBankingOptionsDict objectForKey:aKey]];
            [bankDict setValue:aKey forKey:PARAM_BANK_CODE];
            [allInternetBankingOptions addObject:bankDict];
        }
    }
    NSArray *listOfBankAvailableForNetBanking = [allInternetBankingOptions sortedArrayUsingComparator:^(NSDictionary *item1, NSDictionary *item2) {
        return [item1[BANK_TITLE] compare:item2[BANK_TITLE] options:NSCaseInsensitiveSearch];
    }];
    NSLog(@"Sorted Bank by default = %@",listOfBankAvailableForNetBanking);
    //    NSLog(@"Sorted Bank bt sorted selector = %@",[listOfBankAvailableForNetBanking sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]);
    
    _bankDetails = listOfBankAvailableForNetBanking;
    [_nbTableView reloadData];

}


- (void) successResponse:(NSDictionary *) responseDict;
{
    if([[responseDict objectForKey:@"paymenttype"] isEqualToString:@"SC"]){
    
    NSLog(@"StoredCard = %@",responseDict);
    [self listAllStoredCard :responseDict];
    [_StoredCard reloadData];
    }
    if([[responseDict objectForKey:@"paymenttype"] isEqualToString:@"NB"]){
    [self extractAllInternetBankingOption : responseDict];
    NSLog(@"StoredCard = %@",_bankDetails);
    }
    
    if([[responseDict objectForKey:@"paymenttype"] isEqualToString:@"DELETESC"]){
        [_StoredCard reloadData];
    }
}
- (void) failureResponse:(NSDictionary *)errorDict
{
    NSLog(@"StoredCard = %@",errorDict);
}
@end
