//
//  ViewController.m
//  PayU_iOS_SDK_TestApp
//
//  Created by Suryakant Sharma on 04/12/14.
//  Copyright (c) 2014 PayU, India. All rights reserved.
//

#import "ViewController.h"
#import "PayUConstant.h"



@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *OfferKey;
@property (nonatomic, strong) IBOutlet UITableView *paymentModeTableView;
@property (nonatomic, strong) NSArray *optionList;
@property (nonatomic, strong) NSArray *headerNames;
@property (nonatomic, strong) NSString *txnID;
@property (nonatomic, strong) NSDictionary *hashDict;
@property (nonatomic, strong) UIView *transparentView;

typedef void (^urlRequestCompletionBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationItem.title = @"PayU Test App";
    
    // setting up this class as delegate and dataSource for paymentModeTableView
    _paymentModeTableView.delegate = self;
    _paymentModeTableView.dataSource = self;
    
    //creating a array of option to display.
    _optionList = @[@"Start Payment"/*,@"CC DC NB CASH",@"DC CASH NB CC",@"PAYU_MONEY STORED_CARDS CC",@"Make payment CC",@"Make Payment Stored Card",@"Stored Card",@"Edit Card",@"Delete Card",@"Test Enforce",@"Test Drop Category",@"Test Offer",@"Back Button disabled"*/];
    
    _headerNames = @[@"Without user defined modes"/*,@"With user defined modes",@"Use payU fragments", @"Enforce method", @"Drop Category", @"With Offer"*/];
    
    //NSLog(@"Bundle Object = %@ Path = %@", [NSBundle mainBundle], [[NSBundle mainBundle] pathForResource:@"WebViewJavascriptBridge.js" ofType:@"txt"]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(success:) name:@"payment_success_notifications" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failure:) name:@"payment_failure_notifications" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancel:) name:@"payu_notifications" object:nil];
    //[self.activityIndicator startAnimating];
    // Get all required hash values
    
    
}


- (void) viewWillAppear:(BOOL)animated{
    _OfferKey.text = @"test123@6622";
    [super viewWillAppear:animated];
    _txnID = [self randomStringWithLength:17];
//    _transparentView = [[UIView alloc] initWithFrame:self.view.frame];
//    _transparentView.backgroundColor = [UIColor grayColor];
//    _transparentView.alpha = 0.5f;
//    _transparentView.opaque = NO;
//    _transparentView.userInteractionEnabled = NO;
    [self.view addSubview:_transparentView];
    [self generateHashFromServer:nil withCompletionBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //[_transparentView removeFromSuperview];
        });
        NSLog(@"-->>Hash has been created = %@",_hashDict);
    }];
}

- (void) success:(NSDictionary *)info{
    NSLog(@"Sucess Dict: %@",info);
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) failure:(NSDictionary *)info{
    NSLog(@"failure Dict: %@",info);
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void) cancel:(NSDictionary *)info{
    NSLog(@"failure Dict: %@",info);
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength:(int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }
    
    return randomString;
}

-(void) withoutUserDefinedModeBtnClick{
    
    PayUPaymentOptionsViewController *paymentOptionsVC = nil;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            paymentOptionsVC = [[PayUPaymentOptionsViewController alloc] initWithNibName:@"AllPaymentOprionsView" bundle:nil];
        }
        else
        {
            paymentOptionsVC = [[PayUPaymentOptionsViewController alloc] initWithNibName:@"PayUPaymentOptionsViewController" bundle:nil];
        }
    }

    NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      @"Nokia",@"productinfo",
                                      @"Ram",@"firstname",
                                      @"1.6",@"amount",
                                      @"email@testsdk1.com",@"email",
                                      @"1111111111", @"phone",
                                      @"https://dl.dropboxusercontent.com/s/y911hgtgdkkiy0w/success_iOS.html",@"surl",
                                      @"https://dl.dropboxusercontent.com/s/h6m11xr93mxhfvf/Failure_iOS.html",@"furl",
                                      _txnID,@"txnid",
                                      @"ra:ra",@"user_credentials",
                                      _OfferKey.text,@"offer_key",
                                      @"u1",@"udf1",
                                      @"u2",@"udf2",
                                      @"u3",@"udf3",
                                      @"u4",@"udf4",
                                      @"u5",@"udf5"
                                      ,nil];
    paymentOptionsVC.parameterDict = paramDict;
    paymentOptionsVC.callBackDelegate = self;
    paymentOptionsVC.totalAmount  = 1.6;
    paymentOptionsVC.appTitle     = @"PayU test App";
    
    if(_hashDict)
    paymentOptionsVC.allHashDict = _hashDict;
    
    [self.navigationController pushViewController:paymentOptionsVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) generateHashFromServer:(NSDictionary *) paramDict withCompletionBlock:(urlRequestCompletionBlock)completionBlock{
    
    void(^serverResponseForHashGenerationCallback)(NSURLResponse *response, NSData *data, NSError *error) = completionBlock;
    
    //NSURL *restURL = [NSURL URLWithString:PAYU_PAYMENT_ALL_AVAILABLE_PAYMENT_OPTION];
    NSURL *restURL = [NSURL URLWithString:@"https://payu.herokuapp.com/get_hash"];

    // create the request
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:restURL
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:60.0];
    // Specify that it will be a POST request
    theRequest.HTTPMethod = @"POST";
    
    //NSString *var1Str = [NSString stringWithFormat:@"{\"amount\":\"%@\",\"txnid\":\"%@\",\"email\":\"%@\",\"productinfo\":\"%@\",\"firstname\":\"%@\",\"udf1\":\"%@\",\"udf2\":\"%@\",\"udf3\":\"%@\",\"udf4\":\"%@\",\"udf5\":\"%@\",\"user_credentials\":\"%@\"}",@"1100.60",_txnID,@"email@testsdk1.com",@"Nokia",@"Ram",@"u1",@"u2",@"u3",@"u4",@"u5",@"ra:ra"];
//    str = [str stringByReplacingOccurrencesOfString:@" = " withString:@":"];
    
    //NSString *postData = [NSString stringWithFormat:@"command=%@&key=%@&hash=%@&var1=%@",@"get_hashes",@"0MQaQP",@"hash",var1Str];
    NSString *postData = [NSString stringWithFormat:@"offer_key=%@&key=%@&hash=%@&email=%@&amount=%@&firstname=%@&txnid=%@&user_credentials=%@&udf1=u1&udf2=u2&udf3=u3&udf4=u4&udf5=u5&productinfo=%@&phone=%@",_OfferKey.text,@"gtKFFx",@"hash",@"email@testsdk1.com",@"1.6",@"Ram",_txnID,@"ra:ra",@"Nokia",@"1111111111"];
    
    NSLog(@"-->>Hash generation Post Param = %@",postData);
    
    //set request content type we MUST set this value.
    [theRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set post data of request
    [theRequest setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *networkQueue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:theRequest queue:networkQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *errorJson = nil;
        //NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
        _hashDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
//        NSLog(@"Hash API response : %@",responseDict);
        //_hashDict = [NSDictionary dictionaryWithDictionary:[responseDict valueForKey:@"result"]];
        serverResponseForHashGenerationCallback(response, data,connectionError);
        
    }];

}

#pragma mark - TableView DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return _headerNames.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _headerNames[section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRow = 0;
    switch (section) {
        case 0:
            numberOfRow = 1;
            break;
        case 1:
            numberOfRow = 3;
            break;
        case 2:
            numberOfRow = 5;
            break;
        case 3:
            numberOfRow = 1;
            break;
        case 4:
            numberOfRow = 1;
            break;
        case 5:
            numberOfRow = 2;
            break;
        default:
            break;
    }
    return numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [_optionList objectAtIndex:indexPath.row];;
            break;
        case 1:
            //calculation of array index should be (rows in previos section + row)
            cell.textLabel.text = [_optionList objectAtIndex:(indexPath.row+1)];
            break;
        case 2:
            cell.textLabel.text = [_optionList objectAtIndex:(indexPath.row+3+1)];
            break;
        case 3:
            cell.textLabel.text = [_optionList objectAtIndex:(indexPath.row+5+3+1)];
            break;
        case 4:
            cell.textLabel.text = [_optionList objectAtIndex:(indexPath.row+1+5+3+1)];
            break;
        case 5:
            cell.textLabel.text = [_optionList objectAtIndex:(indexPath.row+1+1+5+3+1)];
            break;
        default:
            break;
    }

    return cell;
}

#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self withoutUserDefinedModeBtnClick];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        default:
            break;
    }

}


@end
