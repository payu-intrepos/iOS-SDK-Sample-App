//
//  FirstViewController.m
//  SampleAppPayUCB
//
//  Created by Umang Arya on 24/07/15.
//  Copyright (c) 2015 Umang Arya. All rights reserved.
//

#import "FirstViewController.h"
#import "PaymentViewController.h"
#import <CommonCrypto/CommonDigest.h>


@interface FirstViewController ()
@property (nonatomic,strong) NSMutableURLRequest *req;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _CardName.text = @"Ram";
    _MM.text = @"10";
    _YY.text = @"2019";
    _CVV.text = @"123";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    [_CardNumber resignFirstResponder];
    [_CardName resignFirstResponder];
    [_MM resignFirstResponder];
    [_YY resignFirstResponder];
    [_CVV resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Pay:(id)sender {
    UIStoryboard *stry = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PaymentViewController *PVC = [stry instantiateViewControllerWithIdentifier:@"PVC"];
    
    NSURL *restURL = [NSURL URLWithString:@"https://secure.payu.in/_payment"];
    _req=[NSMutableURLRequest requestWithURL:restURL
                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                             timeoutInterval:60.0];
    _req.HTTPMethod = @"POST";
    NSString *postData = [[NSString alloc]init];
    NSString *txnID = [self randomStringWithLength:15];
    NSString *hashValue = [NSString stringWithFormat:@"0MQaQP|%@|1.36|Nokia Lumia 625|Ram|email@testsdk.com|||||||||||13p0PXZk",txnID];
    
    postData = [NSString stringWithFormat:@"furl=https://dl.dropboxusercontent.com/s/h6m11xr93mxhfvf/Failure_iOS.html&productinfo=Nokia Lumia 625&phone=9876543210&amount=1.36&firstname=Ram&txnid=%@&key=0MQaQP&var1=default&command=get_merchant_ibibo_codes&user_credentials=ra:ra&email=email@testsdk.com&surl=https://dl.dropboxusercontent.com/s/y911hgtgdkkiy0w/success_iOS.html&pg=CC&ccnum=%@&ccname=%@&ccexpmon=%@&ccexpyr=%@&bankcode=CC&ccvv=%@&&device_type=2&hash=%@", txnID,_CardNumber.text,_CardName.text,_MM.text,_YY.text,_CVV.text,[self createCheckSumString:hashValue]];
    [_req setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [_req setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    PVC.theRequest = _req;
    
    [self.navigationController pushViewController:PVC animated:true];
}


NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength:(int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((u_int32_t)[letters length])]];
    }
    
    return randomString;
}

-(NSString *) createCheckSumString:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    // This is an iOS5-specific method.
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA512(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    // Parse through the CC_SHA256 results (stored inside of digest[]).
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}
@end
