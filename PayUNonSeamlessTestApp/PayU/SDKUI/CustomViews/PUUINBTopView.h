//
//  PUUINBTopView.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 14/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PUUINBTopView : UIView

-(instancetype)initWithFrame:(CGRect)frame withBankDict:(NSDictionary *) dictBankName withBtnTagStartValue:(NSInteger) btnTagStart withDelegate:(id) delegate;

@end
