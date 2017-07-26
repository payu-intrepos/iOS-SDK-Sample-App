//
//  PUUIEMITopView.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 9/29/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUUIEMITopView.h"
#import "PayUConstants.h"
#import "PUUICardOptionVC.h"
#import "PUUIConstants.h"

@interface PUUIEMITopView () <CardOptionDelegate>
{
    PUUICardOptionVC *_cardOptionVC;
    NSArray *_arrEMI, *_arrbankName, *_arrDuration;
    NSDictionary *_emiDict;
    NSString *_selectedBankName, *_selectedEMIDuration;
}
@property (weak, nonatomic) IBOutlet UIButton *btnSelectBank;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectDuration;
@property (weak, nonatomic) IBOutlet UIView *vwTop;
@property (weak, nonatomic) PUUICCDCVC *parentVC;
@property (nonatomic, weak) NSString *paymentType;
@end


@implementation PUUIEMITopView

-(instancetype)initWithPaymentType:(NSString *) paymentType parentVC:(PUUICCDCVC *) parentVC{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PUUIEMITopView class])  owner:self options:nil] firstObject];
    if (self) {
        self.parentVC = parentVC;
        self.paymentType = paymentType;

        if ([paymentType isEqual:PAYMENT_PG_NO_COST_EMI]) {
            PayUSDKLog(@"No Cost EMI EMI Top view created");
            _arrEMI = parentVC.paymentRelatedDetail.NoCostEMIArray;
            _emiDict = [PayUModelEMI getEligibleNoCostEMIDictFromEMIModelArray:_arrEMI WRTToAmount:self.parentVC.paymentParam.amount];
        }
        else if ([paymentType isEqual:PAYMENT_PG_EMI]){
            PayUSDKLog(@"EMI Top view created");
            _arrEMI = parentVC.paymentRelatedDetail.EMIArray;
            _emiDict = [PayUModelEMI getEMIDictFromEMIModelArray:_arrEMI];
            [self.vwTop removeFromSuperview];
            [self.vwBottom setNeedsLayout];
            [self.vwBottom layoutIfNeeded];
        }
        
        [self.btnSelectBank.layer setBorderColor:[UIColor payUViewBorderColor].CGColor];
        [self.btnSelectDuration.layer setBorderColor:[UIColor payUViewBorderColor].CGColor];
        
    }
    return self;
}

-(void)addConstraint{
    PayUSDKLog(@"Constraint Added");
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *leftConstraint, *rigthConstraint, *bottomConstraint, *topConstraint;
    
    leftConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    leftConstraint.active = YES;
    
    rigthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    rigthConstraint.active = YES;
    
    bottomConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    bottomConstraint.active = YES;
    
    topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    topConstraint.active = YES;
    
//    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40];
//    heightConstraint.active = YES;
}

- (void)showSubViewOnView:(UIView *)view {
    PayUSDKLog(@"showSubViewOnView method called");
    [view addSubview:self];
    [self addConstraint];
}


- (IBAction)btnClickedSelectDuration:(id)sender {
    PayUSDKLog(@"btnClickedSelectDuration called");
    UINavigationController *navigationCtrlr = [self getNavigationControllerInstance];
    _cardOptionVC = (PUUICardOptionVC *)[navigationCtrlr topViewController];
    _cardOptionVC.arrStoredCards = (NSMutableArray *)_arrDuration;
    _cardOptionVC.delegate = self;
    if (!_selectedEMIDuration) {
        _cardOptionVC.cardIndex = -1;
    }
    else{
        _cardOptionVC.cardIndex = [_arrDuration indexOfObject:_selectedEMIDuration];
    }
    _cardOptionVC.tableViewType = TableViewTypeEMIDuration;
    
    [self.parentVC presentViewController:navigationCtrlr animated:YES completion:nil];
}


- (IBAction)btnClickedSelectBank:(id)sender {
    PayUSDKLog(@"btnClickedSelectBank called");
    UINavigationController *navigationCtrlr = [self getNavigationControllerInstance];
    _cardOptionVC = (PUUICardOptionVC *)[navigationCtrlr topViewController];
    _arrbankName = [[_emiDict allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    _cardOptionVC.arrStoredCards = (NSMutableArray *)_arrbankName;
    _cardOptionVC.delegate = self;
    if (!_selectedBankName) {
        _cardOptionVC.cardIndex = -1;
    }
    else{
        _cardOptionVC.cardIndex = [_arrbankName indexOfObject:_selectedBankName];
    }
    _cardOptionVC.tableViewType = TableViewTypeEMIBank;
    
    [self.parentVC presentViewController:navigationCtrlr animated:YES completion:nil];
}


- (void) cardOptionSelectedWithIndex:(NSInteger)cardIndex{
    if (cardIndex >=0) {
        if (_cardOptionVC.tableViewType == TableViewTypeEMIBank){
            PayUSDKLog(@"cardOptionSelectedWithIndex for EMIBank method called");
            NSString *bankName = [_arrbankName objectAtIndex:cardIndex];
            if (![bankName isEqualToString:_selectedBankName]) {
                _selectedBankName = bankName;
                _arrDuration = [[[_emiDict valueForKey:_selectedBankName] allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
                [self setEMIDurationRelatedObjects:0];
            }
            [self.btnSelectBank setTitle:_selectedBankName forState:UIControlStateNormal];
        }
        else if (_cardOptionVC.tableViewType == TableViewTypeEMIDuration) {
            [self setEMIDurationRelatedObjects:cardIndex];
        }
    }
    else{
        if (_cardOptionVC.tableViewType == TableViewTypeEMIBank){
//            [self setEMIDurationParamToDefault];
        }
    }
}

-(UINavigationController *)getNavigationControllerInstance{
    UIStoryboard *stryBrd = [UIStoryboard storyboardWithName:@"PUUIMainStoryBoard" bundle:nil];
    UINavigationController *navigationCtrlr = [stryBrd instantiateViewControllerWithIdentifier:@"NavSC"];
    return navigationCtrlr;
}

//-(void)setEMIDurationParamToDefault{
//    _arrDuration = nil;
//    _selectedEMIDuration = nil;
//    self.parentVC.paymentParam.bankCode = nil;
//    [self.btnSelectDuration setTitle:self.defaultSelectDurationTitile forState:UIControlStateNormal];
//}
//
-(void)setEMIDurationRelatedObjects:(NSInteger) cardIndex{
    _selectedEMIDuration = [_arrDuration objectAtIndex:cardIndex];
    [self.btnSelectDuration setTitle:_selectedEMIDuration forState:UIControlStateNormal];
    self.parentVC.paymentParam.bankCode = [(PayUModelEMI *)[[_emiDict valueForKey:_selectedBankName] valueForKey:_selectedEMIDuration] bankCode];

}

@end
