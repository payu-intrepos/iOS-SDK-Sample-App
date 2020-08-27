//
//  PUUIEMITopView.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 9/29/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PUUICCDCVC.h"

@interface PUUIEMITopView : UIView

@property (weak, nonatomic) IBOutlet UIView *vwBottom;
-(instancetype)initWithPaymentType:(NSString *) paymentType parentVC:(PUUICCDCVC *) parentVC;
- (void)showSubViewOnView:(UIView *)view;

@end
