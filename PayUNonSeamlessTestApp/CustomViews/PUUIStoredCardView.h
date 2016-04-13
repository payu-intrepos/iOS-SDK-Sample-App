//
//  PUUIStoredCardView.h
//  PayUNonSeamlessTestApp
//
//  Created by Vipin Aggarwal on 21/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PUUIStoredCardViewDelegate <NSObject>
- (void)didSelectOneTapCheckBoxWithSelectionStatus:(BOOL)isSelected;
@end

@interface PUUIStoredCardView : UIView


@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *imgIssuer;
@property (weak, nonatomic) IBOutlet UIImageView *imgCardBrand;

@property (weak, nonatomic) IBOutlet UILabel *lblCardNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblCVV;
@property (weak, nonatomic) IBOutlet UITextField *tfCVV;
@property (weak, nonatomic) IBOutlet UILabel *lblCardName;
@property (weak, nonatomic) IBOutlet UILabel *lblCardType;
@property NSUInteger CVVLength;
@property (weak, nonatomic) IBOutlet UIButton *btnOneClickCheckout;
@property (weak, nonatomic) IBOutlet UIView *viewCheckboxContainer;

@property (weak, nonatomic) id <PUUIStoredCardViewDelegate> delegate;
@end
