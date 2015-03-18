//
//  ViewController.m
//  PayU_iOS_SDK_TestApp
//
//  Created by Suryakant Sharma on 04/12/14.
//  Copyright (c) 2014 PayU, India. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "Constant.h"




@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *paymentModeTableView;
@property (nonatomic, strong) NSArray *optionList;
@property (nonatomic, strong) NSArray *headerNames;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.title = @"PayU Test App";
    
    // setting up this class as delegate and dataSource for paymentModeTableView
    _paymentModeTableView.delegate = self;
    _paymentModeTableView.dataSource = self;
    
    //creating a array of option to display.
    _optionList = @[@"Start SDK"];
    _headerNames = @[@"Without user defined modes"];
    
    // after init call
    // setting notification callbacks for webview payments
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successFromWebView:) name:PAYMENT_SUCCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failureFromWebView:) name:PAYMENT_FAILURE_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelFromWebView:) name:PAYMENT_CANCEL_NOTIFICATION object:nil];
    
}

- (NSString *) createCheckSumString:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    // This is an iOS5-specific method.
    // It takes in the data, data size and then output format, which in this case is an int array.
    CC_SHA512(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    // Parse through the CC_SHA256 results (stored inside of digest[]).
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
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
                                      @"product",@"productinfo",
                                      @"username",@"firstname",
                                      [NSNumber numberWithFloat:10.36],@"amount",
                                      @"email@testsdk.com",@"email",
                                      @"9999999999", @"phone",
                                      @"https://dl.dropboxusercontent.com/s/y911hgtgdkkiy0w/success_iOS.html",@"surl",
                                      @"https://dl.dropboxusercontent.com/s/h6m11xr93mxhfvf/Failure_iOS.html",@"furl",
                                      [self randomStringWithLength:15],@"txnid", nil];
    
    //  To start using save card feature, please provide user_credentials also in the form of merchantKey:userid, to keep it unique for us
    //                                      merchantKey:userid,@"user_credentials", nil];
    
    paymentOptionsVC.parameterDict = paramDict;
    paymentOptionsVC.callBackDelegate = self;
    paymentOptionsVC.appTitle       = @"PayU Test App";
    
    [self.navigationController pushViewController:paymentOptionsVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            break;
        default:
            break;
    }

}

#pragma mark - Callbacks from resultview methods
- (void) successFromWebView:(NSNotification *)notification {
    if ([[notification object] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictResponse = [notification object];
        if ([dictResponse objectForKey:@"response"]) {
            NSLog(@"successFromWebView: response %@", dictResponse);
        } else {
            NSLog(@"successFromWebView: Wrong response dictionary");
        }
    } else {
        NSLog(@"successFromWebView: Wrong response dictionary");
    }
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void) failureFromWebView:(NSNotification *)notification {
    if ([[notification object] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictResponse = [notification object];
        if ([dictResponse objectForKey:@"response"]) {
            NSLog(@"failureFromWebView: response %@", dictResponse);
        } else {
            NSLog(@"failureFromWebView: Wrong response dictionary");
        }
    } else {
        NSLog(@"failureFromWebView: Wrong response dictionary");
    }
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void) cancelFromWebView:(NSNotification *)notification {
    if ([[notification object] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictResponse = [notification object];
        if ([dictResponse objectForKey:@"response"]) {
            NSLog(@"cancelFromWebView: response %@", dictResponse);
        } else {
            NSLog(@"cancelFromWebView: Wrong response dictionary");
        }
    } else {
        NSLog(@"cancelFromWebView: Wrong response dictionary");
    }
    [self.navigationController popToRootViewControllerAnimated:true];
}


@end
