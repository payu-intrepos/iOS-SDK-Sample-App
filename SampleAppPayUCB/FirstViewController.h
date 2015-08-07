//
//  FirstViewController.h
//  SampleAppPayUCB
//
//  Created by Umang Arya on 24/07/15.
//  Copyright (c) 2015 Umang Arya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *CardNumber;
@property (weak, nonatomic) IBOutlet UITextField *CardName;
@property (weak, nonatomic) IBOutlet UITextField *MM;
@property (weak, nonatomic) IBOutlet UITextField *YY;
@property (weak, nonatomic) IBOutlet UITextField *CVV;
- (IBAction)Pay:(id)sender;

@end
