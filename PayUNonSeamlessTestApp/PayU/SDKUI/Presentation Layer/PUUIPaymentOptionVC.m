//
//  PUUIPaymentOptionVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIPaymentOptionVC.h"
#import "UIColor+PUUIColor.h"
#import "PUUITabBarTopView.h"
#import "AppDelegate.h"
#import "PUUICCDCVC.h"
#import "PUUINBVC.h"
#import "PUUIWebViewVC.h"
#import "PUUIConstants.h"
#import "PUCBWebVC.h"
#import "PUUIWrapperPayUSDK.h"
#import "PUUIStoredCardCarouselVC.h"
#import "PUUIPayUMoneyVC.h"

#define KEY_REQUEST     @"Request"
@interface PUUIPaymentOptionVC () <KHTabPagerDataSource, KHTabPagerDelegate, PUCBWebVCDelegate>
{
    PayUModelPaymentParams *paymentParam2;
    NSInteger currentIndex, bankSimulatorType;
    NSMutableArray *actualPaymentOption;
    NSMutableArray *arrStoredCards;
    BOOL isSimplifiedCB, withCustomisations, withPostParam, shouldPresentVC;
    
}

- (IBAction)btnClickedPayNow:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnPayNow;

@end

@implementation PUUIPaymentOptionVC

@synthesize paymentOption = _paymentOption;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subscribeToNotifications];
    [self customInitialization];
    [self reloadData];
    isSimplifiedCB = YES;
    withCustomisations = YES;
    withPostParam = NO;
    shouldPresentVC = NO;
//    bankSimulatorType = PUCBBankSimulatorLocal;
}
-(void)dealloc{
    [self unsubscribeFromNotifications];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
    
    //Modify available options recieved
    [self modifyAvailablePaymentOptions];
    
    actualPaymentOption = [NSMutableArray new];
    for (NSString *paymentOption in self.paymentOption) {
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
    PUUITabBarTopView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PUUITabBarTopView class]) owner:self options:nil] objectAtIndex:0];
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

#pragma mark - Pay Now Related Methods

- (IBAction)btnClickedPayNow:(id)sender {
    [self payNow];
}
-(void)payNow{
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
    NSURLRequest *request;
    NSString *postParam;
    if (bankSimulatorType == PUCBBankSimulatorLocal && ([paymentType isEqual:PAYMENT_PG_STOREDCARD] || [paymentType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD] || [paymentType isEqual:PAYMENT_PG_CCDC])) {
        NSBundle *bundle = [NSBundle mainBundle];
        id className = [bundle classNamed:@"PUSAUtils"];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if (className && [className respondsToSelector:@selector(getNSURLRequestForLocalBankSimulator)]) {
            request = (NSMutableURLRequest *)[className performSelector:@selector(getNSURLRequestForLocalBankSimulator)];
        }
        
#pragma clang diagnostic pop
    }
    
    if (!request) {
        bankSimulatorType = PUCBDefault;
        NSDictionary *dict = [self getNSURLRequestWithPaymentParams:paymentParam2 andPaymentType:paymentType];
        request = [dict objectForKey:KEY_REQUEST];
        postParam = [dict objectForKey:KEY_POST_PARAM];
    }
    
    if (request) {
        NSError *err = nil;
        
        if (isSimplifiedCB) {
            PUCBWebVC *webVC;
            
            if (withPostParam) {
                webVC = [[PUCBWebVC alloc] initWithPostParam:postParam
                                                         url:request.URL
                                                 merchantKey:self.paymentParam.key
                                                       error:&err];
            }
            else{
                webVC = [[PUCBWebVC alloc] initWithNSURLRequest:request
                                                    merchantKey:self.paymentParam.key
                                                          error:&err];
            }
            
            if (err) {
                PAYUALERT(@"Error creating PUCBWebVC", err.description);
                return;
            }
            
            
            if (withCustomisations) {
                webVC.cbWebVCDelegate = self;
                PUCBConfiguration *cbConfig = [PUCBConfiguration getSingletonInstance];
                
                cbConfig.shouldShowPayULoader = YES;
                cbConfig.isMagicRetry = YES;
                cbConfig.isAutoOTPSelect = NO;
                cbConfig.transactionId = self.paymentParam.transactionID;
                cbConfig.bankSimulatorType = bankSimulatorType;
            }
            
            if (shouldPresentVC) {
                [self presentViewController:webVC animated:true completion:nil];
            }
            else{
                [self.navigationController pushViewController:webVC animated:true];
            }
        }
        else{
            PUUIWebViewVC *WVVC;
            WVVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_WEBVIEW];
            WVVC.request = request;
            WVVC.paymentParam = paymentParam2;
            WVVC.bankSimulatorType = bankSimulatorType;
            [self.navigationController pushViewController:WVVC animated:true];
        }
    }
    else{
        
    }
}

-(void)enablePayNow:(NSNotification *) noti{
    if ([noti object]) {
        paymentParam2 = (PayUModelPaymentParams *)[noti object];
        self.btnPayNow.userInteractionEnabled = YES;
        [self.btnPayNow setBackgroundColor:[UIColor payNowEnableColor]];
        if ([noti.userInfo objectForKey:kPUUIPayNow]) {
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

- (NSDictionary*)getNSURLRequestWithPaymentParams:(PayUModelPaymentParams*)paymentParams andPaymentType:(NSString*)paymentType {
    PayUCreateRequest *createRequest = [[PayUCreateRequest alloc] init];
    __block NSURLRequest *resultingRequest = nil;
    __block NSString *resultingPostParam;
    [createRequest createRequestWithPaymentParam:paymentParam2 forPaymentType:paymentType withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error) {
            PAYUALERT(@"Error", error);
        }
        else{
            resultingRequest = (NSURLRequest*)request;
            resultingPostParam = postParam;
        }
    }];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:resultingRequest,KEY_REQUEST,resultingPostParam,KEY_POST_PARAM, nil];
}

-(void)PayUSuccessResponse:(id)response{
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:[NSMutableData dataWithData:response ]];
}


-(void)PayUFailureResponse:(id)response{
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:[NSMutableData dataWithData:response ]];
}

- (void)PayUConnectionError:(NSDictionary *)notification {
//    PAYUALERT(@"Response", notification.description);
}

- (void)PayUTransactionCancel {
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:nil];
}

#pragma mark - Back Button Handling

-(BOOL) shouldDismissVCOnBackPress
{
    UIAlertView *backbtnAlertView = [[UIAlertView alloc]initWithTitle:@"Overridden" message:@"Do you want to cancel this transaction?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    backbtnAlertView.tag = 512;
    [backbtnAlertView show];
    return NO;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if((buttonIndex==1 && alertView.tag ==512 )) {
        [self removeViewController];
    }
}

/*!
 * Removed current view controller from screen
 */
- (void) removeViewController {
    if (shouldPresentVC) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

-(NSArray *)paymentOption{
    NSOrderedSet *setSupportedPaymentOption = [[NSOrderedSet alloc] initWithArray:[NSArray arrayWithObjects:
                                                                            PAYMENT_PG_STOREDCARD,
                                                                            PAYMENT_PG_CCDC,
                                                                            PAYMENT_PG_NET_BANKING,
                                                                            PAYMENT_PG_PAYU_MONEY, nil]];
    NSArray *arr;
    if ([_paymentOption count]) {
        NSMutableOrderedSet *setGivenPaymentOption = [[NSMutableOrderedSet alloc] initWithArray:_paymentOption];
        [setGivenPaymentOption intersectOrderedSet:setSupportedPaymentOption];
        arr = (NSArray *)setGivenPaymentOption;
    }
    else{
        arr = (NSArray *)setSupportedPaymentOption;
    }
    
    return arr;
}
@end
