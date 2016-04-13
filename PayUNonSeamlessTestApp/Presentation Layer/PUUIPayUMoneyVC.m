//
//  PUUIPayUMoneyVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIPayUMoneyVC.h"

@interface PUUIPayUMoneyVC ()

@end

@implementation PUUIPayUMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self enableDisablePayNowButton];
    
}

-(void)enableDisablePayNowButton{
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:self.paymentParam];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
