//
//  PUUIUtility.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <PayUBizCoreKit/PayUBizCoreKit.h>
#import "PUUIImageConstants.h"


@interface PUUIUtility : NSObject

+(NSString *)getNameOfImageForCardIssuer:(NSString *) issuer;

/*!
 * This method returns the name of the image of corresponing issuing bank passed as parameter
 * @param  [issuingBankName]                                [NSString type]
 */
+ (NSString*)getNameOfImageForCardBank:(NSString*) issuingBankName;

+ (UIPickerView *)showPickerViewWithDelegate:(id)delegate onWindow:(UIView *) window;
+ (void)hidePickerViewFromWindow:(UIView *) window;
+(BOOL)isUserCredentialValid:(NSString *) userCredential;
+(NSNumber *)getCardLengthForCardIssuer:(NSString *) cardIssuer;
+(NSNumber *)getCVVLengthForCardIssuer:(NSString *) cardIssuer;

+ (void)showAlertWithTitle:(NSString *) title message:(NSString *) title viewController:(UIViewController *) vc;

@end
