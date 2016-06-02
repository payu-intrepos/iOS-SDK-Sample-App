//
//  PUVAOptionsVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 4/11/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUVAOptionsVC.h"
#import "PUVAConfiguration.h"
#import "PUVABaseResponseVC.h"


static NSString * const cellVerifyAPIIdentifier = @"cellVerifyAPI";

@interface PUVAOptionsVC ()
{
    PUVAConfiguration *_verifyAPIConfig;
}
@end

@implementation PUVAOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _verifyAPIConfig = [[PUVAConfiguration alloc] init];
    self.navigationItem.title = @"Verify API";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_verifyAPIConfig.arrAPIName count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellVerifyAPIIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [_verifyAPIConfig.arrAPIName objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PUVABaseResponseVC *responseVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PUVABaseResponseVC class])];
    responseVC.paymentParam = [self.paymentParam copy];
    responseVC.paymentRelatedDetail = self.paymentRelatedDetail;
    switch (indexPath.row) {
        case 0:{
            responseVC.responseVCType = COMMAND_CHECK_OFFER_DETAILS;
            break;
        }            
        case 1:
        {
            responseVC.responseVCType = COMMAND_CHECK_OFFER_STATUS;
            responseVC.paymentParam.userCredentials = nil;
            break;
        }
        case 2:
        {
            responseVC.responseVCType = COMMAND_DELETE_USER_CARD;
            break;
        }
        case 3:
        {
            responseVC.responseVCType = COMMAND_GET_EMI_AMOUNT_ACCORDING_TO_INTEREST;
            responseVC.paymentParam.userCredentials = nil;
            break;
        }
            case 4:
        {
            responseVC.responseVCType = COMMAND_VAS_FOR_MOBILE_SDK;
            responseVC.paymentParam.userCredentials = nil;
            break;
        }
        case 5:
        {
            responseVC.responseVCType = COMMAND_GET_USER_CARDS;
            break;
        }
        case 6:
        {
            responseVC.responseVCType = COMMAND_VERIFY_PAYMENT;
            responseVC.paymentParam.userCredentials = nil;
            break;
        }
        case 7:
        {
            responseVC.responseVCType = COMMAND_EDIT_USER_CARD;
            break;
        }
        case 8:
        {
            responseVC.responseVCType = COMMAND_DELETE_ONE_TAP_TOKEN;
            break;
        }
        case 9:
        {
            responseVC.responseVCType = COMMAND_CHECK_IS_DOMESTIC;
            responseVC.paymentParam.userCredentials = nil;
            break;
        }
        case 10:
        {
            responseVC.responseVCType = COMMAND_GET_TRANSACTION_INFO;
            responseVC.paymentParam.userCredentials = nil;
            break;
        }
        case 11:
        {
            responseVC.responseVCType = COMMAND_SAVE_USER_CARD;
            break;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:responseVC animated:TRUE];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
