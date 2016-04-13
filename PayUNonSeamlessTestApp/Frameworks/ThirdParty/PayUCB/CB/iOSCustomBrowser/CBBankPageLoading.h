//
//  CBBankPageLoading.h
//  PayU_iOS_SDK_TestApp
//
//  Created by Suryakant Sharma on 15/05/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

/*!
 * This class is used to show intermediate loader on CB.
 */
#import <UIKit/UIKit.h>
#import "CBConnectionHandler.h"

@interface CBBankPageLoading : UIView

@property (nonatomic,weak) CBConnectionHandler *handler;
@property(nonatomic,strong)  NSTimer  *loadingTimer;

/*!
 * This method is used to draw circle and is called from CBConnectionHandler.
 * @param [number] [NSInteger type]
 */
- (void)drawCircle: (NSInteger)number;

/*!
 * This method is used to initialize the view and returns its instance.
 * @param  [frame]      [CGRect type]
 * @param  [handler]    [CBConnectionHandler type]
 * @return [obj]        [CBBankPageLoading type]
 */
- (id)initWithFrame:(CGRect)frame andCBConnectionHandler:(CBConnectionHandler *)handler;

@end
