//
//  test.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 11/24/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "test.h"

@implementation test 

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    
    self = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]firstObject];
    if (self) {
        self.table.delegate = self;
        self.table.dataSource = self;
    }
    return self;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:@"tt"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tt"];
    }
    cell.textLabel.text = @"34567 d";
    cell.detailTextLabel.text = @"detail";
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
@end
