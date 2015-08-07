//
//  PaymentViewController.h
//  SampleAppPayUCB
//
//  Created by Umang Arya on 23/07/15.
//  Copyright (c) 2015 Umang Arya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *resultWebView;
@property (strong,nonatomic) NSMutableURLRequest *theRequest;

@end
