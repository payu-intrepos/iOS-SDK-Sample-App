//
//  PUUIUtility.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUIUtility.h"
#import "AppDelegate.h"
#import "PUUIConstants.h"


@implementation PUUIUtility

+ (UIPickerView *)showPickerViewWithDelegate:(id)delegate
{
    UIView *viewActivity = [APP_DELEGATE.window viewWithTag:502];
    UIPickerView *cityPickerView = nil;
    
    if(!viewActivity) {
        viewActivity = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(APP_DELEGATE.window.frame)- (162 + 44), CGRectGetWidth(APP_DELEGATE.window.frame), (162+44))];
        viewActivity.tag = 502;
        viewActivity.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        [APP_DELEGATE.window addSubview:viewActivity];
        
        cityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(viewActivity.frame)- 162, CGRectGetWidth(viewActivity.frame), 162)];
        cityPickerView.tag = 503;
        cityPickerView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        cityPickerView.delegate = delegate;
        cityPickerView.showsSelectionIndicator = YES;
        [viewActivity addSubview:cityPickerView];
        
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        toolbar.frame = CGRectMake(0, CGRectGetHeight(viewActivity.frame)- (162 + 44), CGRectGetWidth(viewActivity.frame), 44);
        UIBarButtonItem *cancelBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:delegate action:@selector(clickedBtnCancelToPicker:)];
        //        [cancelBarBtn setTintColor:[UIColor WHFeedDescriptionColor]];
        
        UIBarButtonItem *spaceBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *doneBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:delegate action:@selector(clickedBtnDoneToPicker:)];
        //        [doneBarBtn setTintColor:[UIColor WHPinkColor]];
        UIBarButtonItem *fixedSpaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpaceButton.width = 10.0;
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:fixedSpaceButton,cancelBarBtn, spaceBarBtn, doneBarBtn,fixedSpaceButton, nil];
        
        [toolbar setItems:items animated:NO];
        [viewActivity addSubview:toolbar];
        
        
    } else {
        cityPickerView = (UIPickerView *)[viewActivity viewWithTag:503];
    }
    
    return cityPickerView;
}

+ (void)clickedBtnCancelToPicker:(id)sender {
    /*
     Implemented in delegate class
     */
}
+ (void)clickedBtnDoneToPicker:(id)sender {
    /*
     Implemented in delegate class
     */
}

+ (void)hidePickerView
{
    UIView *viewActivity = [APP_DELEGATE.window viewWithTag:502];
    
    if(viewActivity)
        [viewActivity removeFromSuperview];
}

+(NSString *)getNameOfImageForCardIssuer:(NSString *) issuer{
    if ([issuer isEqual:ISSUER_VISA]) {
        return imgVisa;
    }
    else if ([issuer isEqual:ISSUER_LASER]){
        return imgLaser;
    }
    else if ([issuer isEqual:ISSUER_SMAE] || [issuer isEqual:ISSUER_MAES]){
        return imgMaestro;
    }
    else if ([issuer isEqual:ISSUER_MAST]){
        return imgMaster;
    }
    else if ([issuer isEqual:ISSUER_AMEX]){
        return imgAmex;
    }
    else if ([issuer isEqual:ISSUER_DINR]){
        return imgDiner;
    }
    else if ([issuer isEqual:ISSUER_JCB]){
        return imgJCB;
    }
    else if ([issuer isEqual:ISSUER_RUPAY]){
        return imgRupay;
    }
    else{
        return imgCard;
    }    
}

+ (NSString*)getNameOfImageForCardBank:(NSString*) issuingBankName {
    
    
    
    if (([issuingBankName caseInsensitiveCompare:@"sbinet"] == NSOrderedSame) || ([issuingBankName caseInsensitiveCompare:@"sbi"] == NSOrderedSame) || ([issuingBankName caseInsensitiveCompare:@"sbidc"] == NSOrderedSame)){
        return imgSBI;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"icici"] == NSOrderedSame) || ([issuingBankName caseInsensitiveCompare:@"icicinet"] == NSOrderedSame) || ([issuingBankName caseInsensitiveCompare:@"icicicc"] == NSOrderedSame)){
        return imgICICI;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"kotaknet"] == NSOrderedSame) || ([issuingBankName caseInsensitiveCompare:@"kotak"] == NSOrderedSame)){
        return imgKOTAK;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"indus"] == NSOrderedSame)||([issuingBankName caseInsensitiveCompare:@"INDUSIND"] == NSOrderedSame)){
        return imgINDUS;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"hdfc"] == NSOrderedSame) || ([issuingBankName caseInsensitiveCompare:@"hdfcnet"] == NSOrderedSame)){
        return imgHDFC;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"yesnet"] == NSOrderedSame)){
        return imgYES;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"sc"] == NSOrderedSame)){
        return imgSC;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"axisnet"] == NSOrderedSame) || ([issuingBankName caseInsensitiveCompare:@"axis"] == NSOrderedSame)){
        return imgAXIS;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"amex"] == NSOrderedSame)){
        return imgAmex;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"ing"] == NSOrderedSame)){
        return imgING;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"idbi"] == NSOrderedSame)){
        return imgIDBI;
    }
    else if (([issuingBankName caseInsensitiveCompare:@"citi"] == NSOrderedSame)){
        return imgCITI;
    }
    else{
        return nil;
    }
}

+(BOOL)isUserCredentialValid:(NSString *) userCredential{
    if (userCredential && [userCredential containsString:@":"] && [userCredential rangeOfString:@":"].location > 0 && [userCredential rangeOfString:@":"].location <userCredential.length-1) {
        return YES;
    }
    else{
        return NO;
    }
}

+(NSNumber *)getCardLengthForCardIssuer:(NSString *) cardIssuer{
    NSNumber *CardLength;
    if ([cardIssuer isEqual:ISSUER_SMAE]) {
        CardLength = [NSNumber numberWithInt:19];
    }
    else if ([cardIssuer isEqual:ISSUER_AMEX]){
        CardLength = [NSNumber numberWithInt:15];
    }
    else if ([cardIssuer isEqual:ISSUER_DINR]){
        CardLength = [NSNumber numberWithInt:14];
    }
    else{
        CardLength = [NSNumber numberWithInt:16];
    }
    return CardLength;
}

+(NSNumber *)getCVVLengthForCardIssuer:(NSString *) cardIssuer{
    NSNumber *CVVLength;
    if ([cardIssuer isEqual:ISSUER_SMAE]) {
        CVVLength = [NSNumber numberWithInt:0];
    }
    else if ([cardIssuer isEqual:ISSUER_AMEX]){
        CVVLength = [NSNumber numberWithInt:4];
    }
    else{
        CVVLength = [NSNumber numberWithInt:3];
    }
    return CVVLength;
}


@end
