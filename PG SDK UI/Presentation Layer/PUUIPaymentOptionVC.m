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
#import "PUUICCDCVC.h"
#import "PUUINBVC.h"
#import "PUUIConstants.h"
#import <PayUCustomBrowser/PayUCustomBrowser.h>
#import <PayUBizCoreKit/PayUBizCoreKit.h>
#import "PUUIStoredCardCarouselVC.h"
#import "PUUIPayUMoneyVC.h"
#import "iOSDefaultActivityIndicator.h"
#import "PUUIPayUUPIVC.h"
#import "PUUIUtility.h"

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


typedef NS_ENUM(NSUInteger, VCDisplayMode) {
    VCDisplayPush,
    VCDisplayPresent
};


#define KEY_REQUEST     @"Request"
@interface PUUIPaymentOptionVC () <KHTabPagerDataSource, KHTabPagerDelegate, PUCBWebVCDelegate>
{
    PayUModelPaymentParams *paymentParam2;
    NSInteger currentIndex;
    NSMutableArray *actualPaymentOption;
    NSMutableArray *arrStoredCards;
    BOOL withCustomisations, withPostParam, shouldPresentVC, isReviewOrderBuild ,isDefaultReviewOrderView, presentVCOnFullScreen;
    NSString *paymentType;
    BOOL _shouldWebViewStartWithLocalHTML;
}

- (IBAction)btnClickedPayNow:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnPayNow;
@property (strong, nonatomic) iOSDefaultActivityIndicator *defaultActivityIndicator;
@property (strong, nonatomic) PUCBWebVC *webVC;
@end

@implementation PUUIPaymentOptionVC

@synthesize paymentOption = _paymentOption;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subscribeToNotifications];
    [self customInitialization];
    [self reloadData];
    withCustomisations = YES;
    withPostParam = YES;
    shouldPresentVC = self.presentCB;
    isReviewOrderBuild = self.showRO;
    isDefaultReviewOrderView = YES;
    presentVCOnFullScreen = self.presentCBFullscreen;
//    _shouldWebViewStartWithLocalHTML =YES;
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
    //    APP_DELEGATE.paymentOptionVC = self;
    
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

#pragma mark - Loading HTML data into CB

-(void)getHTMLDataForPostParams:(NSString*)params
                        fromURL:(NSURL*)url
            withCompletionBlock:(void (^)(NSString *htmlData, NSString *errorMessage))completion{
    
    //Append requied parameter in params to get HTML data
    NSString *paramsForHTMLData = [NSString stringWithFormat:@"%@&txn_s2s_flow=1",params];
    
    NSMutableURLRequest *urlRequest = [[PayUUtils new] getURLRequestWithPostParam:paramsForHTMLData withURL:url httpHeaderField:nil httpMethod:HTTP_METHOD_POST];
    
    [[PayUUtils new] getWebServiceResponse:urlRequest withCompletionBlock:^(id JSON, NSString *errorMessage, id extraParam) {
        if (JSON && JSON[@"result"]) {
            NSString *postData = [[JSON objectForKey:@"result"] objectForKey:@"post_data"];
            
            if (postData) {
                NSString *htmlData = [self getBase64DecodedStringFromString:postData];
                completion(htmlData, nil);
            }
        }
        else if (JSON && JSON[@"error"]){
            completion(nil ,JSON[@"error"]);
        }
    }];
    
}

- (NSString*)getBase64DecodedStringFromString:(NSString*)str {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSLog(@"Decode String Value: %@", decodedString);
    return decodedString;
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
    else if ([[actualPaymentOption objectAtIndex:index] isEqualToString:PAYMENT_PG_CASHCARD]) {
        //If neither we have stored cards or one tap cards, don't display its tab
        if (arrStoredCards.count < 1 && self.paymentRelatedDetail.oneTapStoredCardArray.count < 1) {
            return nil;
        }
        
        PUUIStoredCardCarouselVC *SCVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_STORED_CARD_CAROUSEL];
        SCVC.paymentParam = [self.paymentParam copy];
        SCVC.paymentRelatedDetail = self.paymentRelatedDetail;
        SCVC.arrStoredCards = self.paymentRelatedDetail.cashCardArray;
        return SCVC;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_CCDC]) {
        PUUICCDCVC * CCDCVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_CCDC];
        CCDCVC.paymentParam = [self.paymentParam copy];
        CCDCVC.paymentRelatedDetail = self.paymentRelatedDetail;
        CCDCVC.paymentType = PAYMENT_PG_CCDC;
        return CCDCVC;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_NET_BANKING]) {
        PUUINBVC *NBVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_NET_BANKING];
        NBVC.paymentParam = [self.paymentParam copy];
        NBVC.paymentRelatedDetail = self.paymentRelatedDetail;
        NBVC.paymentType = PAYMENT_PG_NET_BANKING;
        return NBVC;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_PAYU_MONEY]) {
        PUUIPayUMoneyVC *payUMoney = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_PAYU_MONEY];
      
        payUMoney.messageString = @"Click PAYNOW to pay through PayUMoney";
        payUMoney.paymentParam = self.paymentParam;
      
      
        return payUMoney;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_EMI]) {
        PUUICCDCVC * CCDCVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_CCDC];
        CCDCVC.paymentParam = [self.paymentParam copy];
        CCDCVC.paymentRelatedDetail = self.paymentRelatedDetail;
        CCDCVC.paymentType = PAYMENT_PG_EMI;
        return CCDCVC;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_NO_COST_EMI]) {
        PUUICCDCVC * CCDCVC = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_CCDC];
        CCDCVC.paymentParam = [self.paymentParam copy];
        CCDCVC.paymentRelatedDetail = self.paymentRelatedDetail;
        CCDCVC.paymentType = PAYMENT_PG_NO_COST_EMI;
        return CCDCVC;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_LAZYPAY]) {
      
      PUUIPayUMoneyVC *lazyPay = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_PAYU_MONEY];
      
      lazyPay.messageString = @"Click PAYNOW to pay through Lazy Pay";
      
      
      lazyPay.paymentParam = self.paymentParam;

      
      return lazyPay;
    }
    else if ([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_UPI]) {
        PUUIPayUUPIVC *upi = [self.storyboard instantiateViewControllerWithIdentifier:VC_IDENTIFIER_PAYU_UPI];
        upi.paymentParam = [self.paymentParam copy];
        return upi;
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
    paymentType = [actualPaymentOption objectAtIndex:currentIndex];
    if ([paymentType  isEqual: PAYMENT_PG_STOREDCARD ]) {
        for (PayUModelStoredCard *modelStoredcard in self.paymentRelatedDetail.oneTapStoredCardArray) {
            if (modelStoredcard.cardToken == paymentParam2.cardToken){
                paymentType = PAYMENT_PG_ONE_TAP_STOREDCARD;
                break;
            }
        }
    } else if ([paymentType  isEqual: PAYMENT_PG_NO_COST_EMI]) {
        paymentParam2.hashes.paymentHash = self.subventionPaymentHash;
    }
    NSURLRequest *request;
    NSString *postParam;
    
    if (!request) {
        NSDictionary *dict = [self getNSURLRequestWithPaymentParams:paymentParam2 andPaymentType:paymentType];
        request = [dict objectForKey:KEY_REQUEST];
        postParam = [dict objectForKey:KEY_POST_PARAM];
    }
    
    //Statement to support HTML Load support in CB
    //Begin
    if (_shouldWebViewStartWithLocalHTML) { //Wait to receive HTMLData from API
        self.defaultActivityIndicator = [iOSDefaultActivityIndicator new];
        [self.defaultActivityIndicator startAnimatingActivityIndicatorWithSelfView:self.view];
        self.view.userInteractionEnabled = NO;
        
        [self getHTMLDataForPostParams:postParam
                               fromURL:request.URL
                   withCompletionBlock:^(NSString *htmlData, NSString *errorMessage) {
                       if (htmlData) {
                           [self.defaultActivityIndicator stopAnimatingActivityIndicator];
                           
                           [self startWebViewWithRequest:request
                                                htmlData:htmlData
                                           andPostparams:postParam];
                       }
                   }];
    }
    //End
    else { //Straight away start loading webview
        [self startWebViewWithRequest:request
                             htmlData:nil
                        andPostparams:postParam];
    }
}

- (void)startWebViewWithRequest:(NSURLRequest*)request
                       htmlData:(NSString*)htmlData
                  andPostparams:(NSString*)postParam {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Setting Custom Browser's configuration
        PUCBConfiguration *cbConfig = [PUCBConfiguration getSingletonInstance];
        cbConfig.surePayCount = self.surePayCount;
        cbConfig.htmlData = htmlData;
//        cbConfig.merchantResponseTimeout = 10.000;
        if (request) {
            NSError *err = nil;
            
            if (withPostParam) {
                self.webVC = [[PUCBWebVC alloc] initWithPostParam:postParam
                                                         url:request.URL
                                                 merchantKey:self.paymentParam.key
                                                       error:&err];
            }
            else{
                self.webVC = [[PUCBWebVC alloc] initWithNSURLRequest:request
                                                    merchantKey:self.paymentParam.key
                                                          error:&err];
            }
            
            if (err) {
                [PUUIUtility showAlertWithTitle:@"Error creating PUCBWebVC" message:err.description viewController:self];
                return;
            }
            
            
            if (withCustomisations) {
                self.webVC.cbWebVCDelegate = self;
                cbConfig.shouldShowPayULoader = YES;
                cbConfig.isAutoOTPSelect = NO;
                cbConfig.isAutoOTPSubmit = YES;
                cbConfig.transactionId = self.paymentParam.transactionID;
                
                cbConfig.paymentURL = [request.URL absoluteString];
                cbConfig.paymentPostParam = postParam;
                
                [self setReviewOrderView];
            }
            
            if (shouldPresentVC) {
                [self showVC:self.webVC withMode:VCDisplayPresent];
            }
            else{
                [self showVC:self.webVC withMode:VCDisplayPush];
            }
        }
    });
    
}

- (void)showVC:(UIViewController*)vc withMode:(VCDisplayMode)mode {
    if (mode == VCDisplayPush) {
        [self.navigationController pushViewController:vc animated:true];
    } else {
        if (presentVCOnFullScreen) {
            vc.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:vc animated:YES completion:nil];
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

- (NSDictionary*)getNSURLRequestWithPaymentParams:(PayUModelPaymentParams*)paymentParams andPaymentType:(NSString*)pymtType {
    PayUCreateRequest *createRequest = [[PayUCreateRequest alloc] init];
    __block NSURLRequest *resultingRequest = nil;
    __block NSString *resultingPostParam;
    [createRequest createRequestWithPaymentParam:paymentParams forPaymentType:pymtType withCompletionBlock:^(NSMutableURLRequest *request, NSString *postParam, NSString *error) {
        if (error) {
            [PUUIUtility showAlertWithTitle:@"Error" message:error viewController:self];
        }
        else{
            resultingRequest = (NSURLRequest*)request;
            resultingPostParam = postParam;
            NSLog(@"PostParams: %@",postParam);
        }
    }];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:resultingRequest,KEY_REQUEST,resultingPostParam,KEY_POST_PARAM, nil];
}

-(void)PayUSuccessResponse:(id)response{
    
}


-(void)PayUFailureResponse:(id)response{
    
}

- (void)PayUSuccessResponse:(id)payUResponse SURLResponse:(id)surlResponse{
    [self removeViewController];
    NSError *serializationError;
    id payUResponseInJSON = [NSDictionary new];
    id surlResponseInJSON = surlResponse ? surlResponse : @"";
    if (payUResponse && [payUResponse isKindOfClass:[NSString class]]) {
        payUResponseInJSON = [NSJSONSerialization JSONObjectWithData:[payUResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&serializationError];
    }
    NSDictionary *responseDict = [NSDictionary dictionaryWithObjectsAndKeys:payUResponseInJSON,kPUUIPayUResponse, surlResponseInJSON, kPUUIMerchantResponse, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseDict];
}

- (void)PayUFailureResponse:(id)payUResponse FURLResponse:(id)furlResponse{
    [self removeViewController];
    NSError *serializationError;
    id payUResponseInJSON = [NSDictionary new];
    id furlResponseInJSON = furlResponse ? furlResponse : @"";
    if (payUResponse && [payUResponse isKindOfClass:[NSString class]]) {
        payUResponseInJSON = [NSJSONSerialization JSONObjectWithData:[payUResponse dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&serializationError];
    }
    NSDictionary *responseDict = [NSDictionary dictionaryWithObjectsAndKeys:payUResponseInJSON,kPUUIPayUResponse, furlResponseInJSON, kPUUIMerchantResponse, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:responseDict];
}

- (void)PayUConnectionError:(NSDictionary *)notification {
    //    PAYUALERT(@"Response", notification.description);
}

- (void)PayUTransactionCancel {
    [self removeViewController];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:nil];
}

- (void)PayUTerminateTransaction {
    [self removeViewController];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiPaymentResponse object:nil];
}



#pragma mark - Back Button Handling

- (void) shouldDismissVCOnBackPress
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Cancel Transaction?" message:@"Do you want to cancel this transaction?" preferredStyle:UIAlertControllerStyleAlert];
    __weak PUUIPaymentOptionVC *weakSelf = self;
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.webVC markPayUTxnCancelInDBWithCompletionBlock:^(BOOL success) {
                [weakSelf removeViewController];
            }];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil]];
    [self.webVC presentViewController:alertVC animated:true completion:nil];
}

/*!
 * Removed current view controller from screen
 */
- (void) removeViewController {
    if (shouldPresentVC) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }

    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(NSArray *)paymentOption{
    NSOrderedSet *setSupportedPaymentOption = [[NSOrderedSet alloc] initWithArray:[NSArray arrayWithObjects:
                                                                                   PAYMENT_PG_STOREDCARD,
                                                                                   PAYMENT_PG_CCDC,
                                                                                   PAYMENT_PG_NET_BANKING,
                                                                                   PAYMENT_PG_UPI,
                                                                                   PAYMENT_PG_PAYU_MONEY,
                                                                                   PAYMENT_PG_EMI,
                                                                                   PAYMENT_PG_CASHCARD,
                                                                                   PAYMENT_PG_NO_COST_EMI,
                                                                                   PAYMENT_PG_LAZYPAY,
                                                                                   PAYMENT_PG_ZESTMONEY,
                                                                                   nil]];
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

-(void)setReviewOrderView{
    NSError *err;
    PUCBReviewOrderConfig *reviewOrderConfig;
    if (isReviewOrderBuild) {
        PUCBConfiguration *cbConfig = [PUCBConfiguration getSingletonInstance];
        NSMutableArray *arrOfDictForReviewOrder;
        if (isDefaultReviewOrderView) {
            arrOfDictForReviewOrder = [[NSMutableArray alloc] init];
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.paymentParam.amount,@"Amount", nil]];
            //            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.paymentParam.productInfo,@"Product Info", nil]];
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.paymentParam.phoneNumber,@"Mobile", nil]];
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.paymentParam.email,@"Email", nil]];
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"GET10",@"Coupon Code", nil]];
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"10% cashback",@"Coupon Detail", nil]];
            
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.paymentParam.transactionID,@"Txn ID", nil]];
            
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Airtel",@"Operator", nil]];
            
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Full TT",@"Recharge Type", nil]];
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Full Talktime Rs. 154 - Roaming Incoming calls free - Roaming Outgoing\nLocal @ Rs. 0.80/min - Roaming Outgoing STD @ Rs. 1.15/min\nValidity: 14 Days",@"Detail", nil]];
            
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sample Value1",@"Sample Key1", nil]];
            
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sample Value2",@"Sample Key2", nil]];
            
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sample Value3",@"Sample Key3", nil]];
            
            [arrOfDictForReviewOrder addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Sample Value4",@"Sample Key4", nil]];
            reviewOrderConfig = [[PUCBReviewOrderConfig alloc] initWithArrForReviewOrder:arrOfDictForReviewOrder error:&err];
        }
        else{
            //                        UIView *vwRO = [[UIView alloc] initWithFrame:CGRectMake(30, 50, 3000, 3000)];
            //                        [vwRO setBackgroundColor:[UIColor redColor]];
            //                        reviewOrderConfig = [[PUCBReviewOrderConfig alloc] initWithCustomView:vwRO error:&err];
            
            reviewOrderConfig = [[PUCBReviewOrderConfig alloc] initWithCustomView:self.customReviewOrderView error:&err];
        }
        if (err) {
            NSLog(@"%@",err.description);
        }
        cbConfig.reviewOrderConfig = reviewOrderConfig;
        //        Set ReviewOrder Btn Text,Header Text, backgroundColor and textColor
        //        cbConfig.reviewOrderConfig.btnText = @"Umang";
        //        cbConfig.reviewOrderConfig.btnBGColor = [UIColor greenColor];
        //        cbConfig.reviewOrderConfig.btnTxtColor = [UIColor yellowColor];
        //        cbConfig.reviewOrderConfig.ReviewOrderHeaderForDefaultView = @"test";
    }
    else{
        [PUCBConfiguration getSingletonInstance].reviewOrderConfig = nil;
        // We are not going to do anything related to ReviewOrder Stuff
    }
}
@end
