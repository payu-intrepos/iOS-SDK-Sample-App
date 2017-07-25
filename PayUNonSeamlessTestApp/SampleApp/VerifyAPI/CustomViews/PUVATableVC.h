//
//  PUVATableVC.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 4/12/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUUIBaseVC.h"

@interface PUVATableVC : PUUIBaseVC

@property (nonatomic, strong) NSArray *arrTextLabel;
@property (nonatomic, strong) NSArray *arrDetailTextLabel;

@property NSInteger selectedIndex;
@property BOOL tappedOnUITableViewCell;

@property NSString *tableVCType;

@property NSString *segueIdentifier;

@end
