//
//  PUSAStoredCardCarouselVC.h
//  PayUNonSeamlessTestApp
//
//  Created by Vipin Aggarwal on 20/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PUUIBaseVC.h"

@interface PUUIStoredCardCarouselVC : PUUIBaseVC

@property (strong, nonatomic) NSMutableArray *arrStoredCards;
@property (strong, nonatomic) NSIndexPath *indexPathCard;

@end
