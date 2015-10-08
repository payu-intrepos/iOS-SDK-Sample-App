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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UILabel *myEnv;

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UITextField *OfferKey;
@property (nonatomic, strong) IBOutlet UITableView *paymentModeTableView;
@property (nonatomic, strong) NSArray *optionList;
@property (nonatomic, strong) NSArray *headerNames;
@property (nonatomic, strong) NSString *txnID;
@property (nonatomic, strong) NSDictionary *hashDict;
@property(nonatomic,strong)NSString*myKey;
@property(nonatomic,strong) UIView *grayView;

typedef void (^urlRequestCompletionBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationController.navigationItem.title = @"PayU Test App";
   
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
_myKey=[dict valueForKey:@"key"];
    
    
    _myLabel.text=_myKey;
    
    if([_myKey isEqualToString:@"gtKFFx" ]||[_myKey isEqualToString:@"smsplus"])
    {
    _myEnv.text=@"test";
    
    }
    else if([_myKey isEqualToString:@"0MQaQP"])
    {
        _myEnv.text=@"Production";
    }
    else
        _myEnv.text=@"Not PayU key";
    //
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:@"plist"];
//    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    
  // NSString *name= [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
    


    
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
    
    [self.activity setHidesWhenStopped:YES];
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _OfferKey.text = @"test123@6622";
    [self.activity startAnimating];
    _txnID = [self randomStringWithLength:17];
    self.grayView = [[UIView alloc]initWithFrame:self.view.frame];
    self.grayView.backgroundColor = [UIColor grayColor];
    self.grayView.alpha = 0.5f;
    self.grayView.opaque = NO;
    self.view.userInteractionEnabled=NO;
    self.grayView.userInteractionEnabled = NO;
    [self.view addSubview:self.grayView];
    [self.view bringSubviewToFront:self.grayView];
    [self.grayView bringSubviewToFront:self.activity];
    _hashDict =nil;
    [self generateHashFromServer:nil withCompletionBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.grayView removeFromSuperview];
            [self.activity stopAnimating];
            self.view.userInteractionEnabled=YES;
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
                                      @"10",@"amount",
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
    paymentOptionsVC.totalAmount  = 10;
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
    
    
    _hashDict=nil;
    
    PayUPaymentOptionsViewController *paymentOptionsVC = nil;
    
    NSURL *restURL = [NSURL URLWithString:@"https://payu.herokuapp.com/get_hash"];

    // create the request
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:restURL
                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                        timeoutInterval:60.0];
    // Specify that it will be a POST request
    theRequest.HTTPMethod = @"POST";
    NSString *postData = [NSString stringWithFormat:@"offer_key=%@&key=%@&hash=%@&email=%@&amount=%@&firstname=%@&txnid=%@&user_credentials=%@&udf1=u1&udf2=u2&udf3=u3&udf4=u4&udf5=u5&productinfo=%@&phone=%@",_OfferKey.text,@"0MQaQP",@"hash",@"email@testsdk1.com",@"10",@"Ram",_txnID,@"ra:ra",@"Nokia",@"1111111111"];
    
    NSLog(@"-->>Hash generation Post Param = %@",postData);
    
    //set request content type we MUST set this value.
    [theRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set post data of request
    [theRequest setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *networkQueue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:theRequest queue:networkQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *errorJson = nil;
        _hashDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
        
        if(_hashDict)
        {
            paymentOptionsVC.allHashDict = _hashDict;
        }
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
            cell.textLabel.text=@"hi";
            break;
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
