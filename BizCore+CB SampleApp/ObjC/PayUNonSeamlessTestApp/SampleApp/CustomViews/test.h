//
//  test.h
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 11/24/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface test : UIView <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
