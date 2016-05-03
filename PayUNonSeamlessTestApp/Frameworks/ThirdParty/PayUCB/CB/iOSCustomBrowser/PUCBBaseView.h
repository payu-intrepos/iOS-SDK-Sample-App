//
//  PUCBBaseView.h
//  iOSCustomBrowser
//
//  Created by Sharad Goyal on 23/02/16.
//  Copyright © 2016 PayU, India. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBConnectionHandler.h"
#import "CBConstant.h"
#import "PUCBFileManager.h"

/*!
 * This is the Base class for all CB Views.
 */
@interface PUCBBaseView : UIView

@property (assign, nonatomic) BOOL isViewOnScreen;
@property (nonatomic,weak) CBConnectionHandler *handler;

/*!
 * This method is used to set shadow at top of the CB View.
 */
- (void)setShadowPath;

/*!
 * This method hanldes the SwipeUp and SwipeDown on CB.
 */
- (void)handleMinOrMaxCB;

/*!
 * This method adds the calling view to the view given in parameter and also add constraint.
 * @param [view]            [UIView type]
 * @see   [addConstraint]
 */
- (void)showSubViewOnView:(UIView *)view;

/*!
 * This methods set Header view to all CB views and also sets the Btn action to handle minimize and maximize of CB.
 * @param [view]                [UIView type]
 * @see   [showSubViewOnView]
 */
- (void)addHeaderToView:(UIView *)view;

/*!
 * This methods set Header view to all CB views and also sets the Bank image.
 * @param [view]                [UIView type]
 * @see   [showSubViewOnView]
 */
- (void)addFooterToView:(UIView *)footerView;
@end
