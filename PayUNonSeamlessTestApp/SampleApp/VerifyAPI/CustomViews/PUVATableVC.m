//
//  PUVATableVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 4/12/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUVATableVC.h"


static NSString * const cellIdentifier = @"PUVATableVCCellIdentifier";
@interface PUVATableVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PUVATableVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numberOfRows =0;
    NSLog(@"%ld",(long)numberOfRows);
    if (self.tableVCType) {
        if ([self.tableVCType isEqual:PAYMENT_PG_NET_BANKING] && self.paymentRelatedDetail.netBankingArray) {
            numberOfRows = [self.paymentRelatedDetail.netBankingArray count];
        }
        else if ([self.tableVCType isEqual:PAYMENT_PG_STOREDCARD] && self.paymentRelatedDetail.storedCardArray) {
            numberOfRows = [self.paymentRelatedDetail.storedCardArray count];
        }
        else if ([self.tableVCType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD] && self.paymentRelatedDetail.oneTapStoredCardArray) {
            numberOfRows = [self.paymentRelatedDetail.oneTapStoredCardArray count];
        }
    }
    else{
        if (self.arrTextLabel) {
            numberOfRows = [self.arrTextLabel count];
        }
    }
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSLog(@"%ld",(long)indexPath.row);
    if (self.tableVCType) {
        if ([self.tableVCType isEqual:PAYMENT_PG_NET_BANKING]) {
            PayUModelNetBanking *netBankingObj = [self.paymentRelatedDetail.netBankingArray objectAtIndex:indexPath.row];
            cell.textLabel.text = netBankingObj.netBankingTitle;
            cell.detailTextLabel.text = netBankingObj.bankCode;
        }
        else if ([self.tableVCType isEqual:PAYMENT_PG_STOREDCARD]) {
            PayUModelStoredCard *objStoredCard = [self.paymentRelatedDetail.storedCardArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@",objStoredCard.cardName,objStoredCard.cardNo];
            cell.detailTextLabel.text = objStoredCard.cardToken;
        }
        else if ([self.tableVCType isEqual:PAYMENT_PG_ONE_TAP_STOREDCARD]) {
            PayUModelStoredCard *objStoredCard = [self.paymentRelatedDetail.oneTapStoredCardArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@",objStoredCard.cardName,objStoredCard.cardNo];
            cell.detailTextLabel.text = objStoredCard.cardToken;
        }
    }
    else{
        cell.textLabel.text = [self.arrTextLabel objectAtIndex:indexPath.row];
        if ([self.arrDetailTextLabel count] > indexPath.row) {
            cell.detailTextLabel.text = [self.arrDetailTextLabel objectAtIndex:indexPath.row];
        }
        else{
            cell.detailTextLabel.text = @"";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        self.tappedOnUITableViewCell = TRUE;
        NSIndexPath *crtIndexPath = [self.tableView indexPathForCell:sender];
        self.selectedIndex = crtIndexPath.row;
    }
    else{
        self.tappedOnUITableViewCell = FALSE;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
