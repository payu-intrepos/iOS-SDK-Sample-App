//
//  PUUICardOptionVC.h
//  PayUNonSeamlessTestApp
//
//  Created by Arun Kumar on 05/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PUUIWrapperPayUSDK.h"

@protocol CardOptionDelegate <NSObject>

- (void) cardOptionSelectedWithIndex:(NSInteger)cardIndex;

@end

@interface PUUICardOptionVC : UITableViewController

@property (strong, nonatomic) PayUModelPaymentParams *paymentParam;
@property (strong, nonatomic) NSMutableArray *arrStoredCards;
@property (assign, nonatomic) NSInteger cardIndex;
//@property BOOL editCellFlag;
//@property (assign, nonatomic) NSString *paymentMode;
@property (assign, nonatomic) NSInteger tableViewType;
@property (assign, nonatomic) id <CardOptionDelegate> delegate;

@end
