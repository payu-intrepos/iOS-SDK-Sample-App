//
//  PUUIStoredCardView.m
//  PayUNonSeamlessTestApp
//
//  Created by Vipin Aggarwal on 21/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUUIStoredCardView.h"

@implementation PUUIStoredCardView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self.subviews.count ==0) {
            UIView* topView =  [[[NSBundle mainBundle] loadNibNamed:@"PUUIStoredCardView" owner:self options:nil] lastObject];
            self.bounds = self.view.bounds;
            [self addSubview:topView];
        }
    }

    [self setupGestureOnCheckboxView];
    return self;
}

- (void)setupGestureOnCheckboxView {
    UITapGestureRecognizer *gestureRecognizer
    = [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(oneClickCheckboxTapped:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    
    // recognize gestures on the label
    [self.viewCheckboxContainer addGestureRecognizer:gestureRecognizer];
}

- (void)oneClickCheckboxTapped:(UITapGestureRecognizer *)sender {
    self.btnOneClickCheckout.selected = !self.btnOneClickCheckout.selected;
    [self.delegate didSelectOneTapCheckBoxWithSelectionStatus:self.btnOneClickCheckout.selected];
    [self endEditing:YES];
}


@end
