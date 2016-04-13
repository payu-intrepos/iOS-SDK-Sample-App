//
//  PUUIPaymentOptionVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIPaymentOptionVC.h"
#import "UIColor+PUUIColor.h"
#import "PayUTabBarTopView.h"
#import "AppDelegate.h"
#import "PUUICCDCVC.h"
#import "PUUINBVC.h"
#import "PUUIStoredCardVC.h"
#import "PUUIWebViewVC.h"
#import "PUUIConstants.h"
#import "PUUIStoredCardCarouselVC.h"
#import "PUUIPayUMoneyVC.h"

@interface PUUIPaymentOptionVC () <KHTabPagerDataSource, KHTabPagerDelegate>
{
    PayUModelPaymentParams *paymentParam2;
    NSInteger currentIndex;
    NSArray *supportedPaymentOption;
    NSMutableArray *actualPaymentOption;
    NSMutableArray *arrStoredCards;
    
}

- (IBAction)btnClickedPayNow:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnPayNow;

@end

@implementation PUUIPaymentOptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subscribeToNotifications];
    [self customInitialization];
    [self reloadData];
}
-(void)dealloc{
    [self unsubscribeFromNotifications];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:TRUE];
}

- (void)subscribeToNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablePayNow:) name:kPUUINotiEnablePayNow object:nil];
}

- (void)unsubscribeFromNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)customInitialization
{
    [self setDataSource:self];
    [self setDelegate:self];
    APP_DELEGATE.paymentOptionVC = self;
    
    // Setting supported payment option by current SDK UI
    supportedPaymentOption = [NSArray arrayWithObjects:
                              PAYMENT_PG_STOREDCARD,
                              PAYMENT_PG_CCDC,
                              PAYMENT_PG_NET_BANKING,
                              PAYMENT_PG_PAYU_MONEY, nil];
    
    //Modify available options recieved
    [self modifyAvailablePaymentOptions];
    
    actualPaymentOption = [NSMutableArray new];
    for (NSString *paymentOption in supportedPaymentOption) {
        if ([self.paymentRelatedDetail.availablePaymentOptionsArray containsObject:paymentOption]) {
            [actualPaymentOption addObject:paymentOption];
        }
    }
    
    if (!actualPaymentOption.count) {
        [actualPaymentOption addObject:@"Something went wrong with Parameters"];
    }
    
    NSMutableArray *arrObj = [NSMutableArray arrayWithArray:self.paymentRelatedDetail.storedCardArray];
    [arrObj addObjectsFromArray:self.paymentRelatedDetail.oneTapStoredCardArray];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cardName" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    arrStoredCards = [NSMutableArray arrayWithArray:[arrObj sortedArrayUsingDescriptors:sortDescriptors]];
//    NSLog(@"sortedArray-----%@", sortedArray);    
    
    [self enablePayNow:nil];
}

//If PAYMENT_PG_ONE_TAP_STOREDCARD is one of the available options, change it to PAYMENT_PG_STOREDCARD
//As we will show both of them inside Stored Cards
- (void)modifyAvailablePaymentOptions {
    //This method will replace PAYMENT_PG_ONE_TAP_STOREDCARD with PAYMENT_PG_STOREDCARD in available methods.
    //If PAYMENT_PG_STOREDCARD already exists, it will not add it again.
    NSString *oneTapPaymentOption = PAYMENT_PG_ONE_TAP_STOREDCARD;
    NSString *storedCardPaymentOption = PAYMENT_PG_STOREDCARD;
    if ([self.paymentRelatedDetail.availablePaymentOptionsArray containsObject:oneTapPaymentOption]) {
        [self.paymentRelatedDetail.availablePaymentOptionsArray removeObject:oneTapPaymentOption];

        //As we have deleted one tap payment method, we should make sure that stored card payment method is present
        if (![self.paymentRelatedDetail.availablePaymentOptionsArray containsObject:storedCardPaymentOption]) {
            [self.paymentRelatedDetail.availablePaymentOptionsArray addObject:storedCardPaymentOption];
        }
    }
}

#pragma mark - KHTabPagerDataSource

- (NSInteger)numberOfViewControllers
{
    return actualPaymentOption.count;
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    if ([[actualPaymentOption objectAtIndex:index] isEqualToString:PAYMENT_PG_STOREDCARD] ||
        [[actualPaymentOption objectAtIndex:index] isEqualToString:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
        //If neither we have stored cards or one tap cards, don't display its tab
        if (arrStoredCards.count < 1 && self.paymentRelatedDetail.oneTapStoredCardArray.count < 1) {
            return nil;
        }
        
        PUUIStoredCardCarouselVC *SCVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_STORED_CARD_CAROUSEL];
        SCVC.paymentParam = [self.paymentParam copy];
        SCVC.paymentRelatedDetail = self.paymentRelatedDetail;
        SCVC.arrStoredCards = arrStoredCards;
        return SCVC;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_CCDC]) {
        PUUICCDCVC * CCDCVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_CCDC];
        CCDCVC.paymentParam = [self.paymentParam copy];
        CCDCVC.paymentRelatedDetail = self.paymentRelatedDetail;
        return CCDCVC;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_NET_BANKING]) {
        PUUINBVC *NBVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_NET_BANKING];
        NBVC.paymentParam = [self.paymentParam copy];
        NBVC.paymentRelatedDetail = self.paymentRelatedDetail;
        return NBVC;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_PAYU_MONEY]) {
        PUUIPayUMoneyVC *payUMoney = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_PAYU_MONEY];
        payUMoney.paymentParam = self.paymentParam;
        return payUMoney;
    }
    else{
        UIViewController *vc = [PUUIBaseVC new];
        [[vc view] setBackgroundColor:[UIColor whiteColor]];
        return vc;
    }
}

// Implement either viewForTabAtIndex: or titleForTabAtIndex:
//- (UIView *)viewForTabAtIndex:(NSInteger)index {
//  return <#UIView#>;
//}

- (NSString *)titleForTabAtIndex:(NSInteger)index {
    return [actualPaymentOption objectAtIndex:index];
}

- (CGFloat)tabHeight {
    // Default: 44.0f
    return 40.0f;
}

- (CGFloat)tabBarTopViewHeight {
    //Default 0.0f;
    return 100.0f;
}

- (UIView *)tabBarTopView {
    PayUTabBarTopView *view = [[[NSBundle mainBundle] loadNibNamed:@"PayUTabBarTopView" owner:self options:nil] objectAtIndex:0];
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y , self.view.frame.size.width, view.frame.size.height);
    view.autoresizingMask = UIViewAutoresizingNone;
    //    view.autoresizingMask = UIViewAutoresizingNone;
    view.lblAmount.text = [NSString stringWithFormat:@"Amount: %@", self.paymentParam.amount]; //@"Amount: 10.0";
    view.lblTxnID.text = [NSString stringWithFormat:@"Txnid: %@", self.paymentParam.transactionID]; //@"Txnid: 1654496695";
    return view;
}

- (UIColor *)tabColor {
    return [UIColor payUTabIndicatorColor];
}

-(UIColor *)tabBackgroundColor {
    return [UIColor payUTabBarBackgroundColor];
}

-(UIColor *)titleColor {
    return [UIColor darkGrayColor];
}

-(UIFont *)titleFont {
    return [UIFont systemFontOfSize:15];
}

-(BOOL)isProgressiveTabBar{
    return YES;
}


#pragma mark - Tab Pager Delegate

- (void)tabPager:(KHTabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index {
    NSLog(@"Will transition from tab %ld to %ld", (long)[self selectedIndex], (long)index);
}

- (void)tabPager:(KHTabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index {
    NSLog(@"Did transition to tab %ld", (long)index);
    currentIndex = index;
}

- (IBAction)btnClickedPayNow:(id)sender {
    [self payNow];
}
-(void)payNow{
    PayUCreateRequest *createRequest = [PayUCreateRequest new];
    NSString *paymentType;
    paymentType = [actualPaymentOption objectAtIndex:currentIndex];
    if ([paymentType  isEqual: PAYMENT_PG_STOREDCARD ]) {
        for (PayUModelStoredCard *modelStoredcard in self.paymentRelatedDetail.oneTapStoredCardArray) {
            if (modelStoredcard.cardToken == paymentParam2.cardToken){
                paymentType = PAYMENT_PG_ONE_TAP_STOREDCARD;
                break;
            }
        }
    }
    
    [createRequest createRequestWithPaymentParam:paymentParam2 forPaymentType:paymentType withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error) {
            PAYUALERT(@"Error", error);
        }
        else{
            PUUIWebViewVC *WVVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_WEBVIEW];
            WVVC.request = request;
            WVVC.paymentParam = paymentParam2;
            [self.navigationController pushViewController:WVVC animated:true];
        }
    }];
}

-(void)enablePayNow:(NSNotification *) noti{
    if ([noti object]) {
        paymentParam2 = (PayUModelPaymentParams *)[noti object];
        self.btnPayNow.userInteractionEnabled = YES;
        [self.btnPayNow setBackgroundColor:[UIColor payNowEnableColor]];
        if ([noti.userInfo valueForKey:kPUUIPayNow]) {
            [self payNow];
        }
    }
    else{
        paymentParam2 = nil;
        self.btnPayNow.userInteractionEnabled = NO;
        [self.btnPayNow setBackgroundColor:[UIColor payNowDisableColor]];
//        self.btnPayNow.alpha = ALPHA_HALF;
    }
}
@end
