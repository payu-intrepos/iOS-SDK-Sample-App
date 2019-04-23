//
//  PUUICardOptionVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Arun Kumar on 05/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUUICardOptionVC.h"
#import "PUUIUtility.h"
#import "PUUIConstants.h"
#import "iOSDefaultActivityIndicator.h"

static NSString * const CardCellCellIdentifier = @"CardCell";
static NSString * const UnwindCardOptionSegueIdentifier = @"UnwindCardOptionSegue";


@interface PUUICardOptionVC ()
{
    iOSDefaultActivityIndicator *activityIndicatorObj;
    PayUModelNetBanking *modelNB;
}

- (void)removeStoredCard:(NSIndexPath *)indexPath;

@end

@implementation PUUICardOptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    if (self.tableViewType == TableViewTypeSC) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
    //    NSLog(@"cardIndex---------%ld", (long)self.cardIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeStoredCard:(NSIndexPath *)indexPath
{
    activityIndicatorObj = [iOSDefaultActivityIndicator new];
    [activityIndicatorObj startAnimatingActivityIndicatorWithSelfView:self.view];
    
    PayUModelStoredCard *modelStoredCard=[self.arrStoredCards objectAtIndex:indexPath.row];
    self.paymentParam.cardToken=modelStoredCard.cardToken;
    self.paymentParam.cardBin=modelStoredCard.cardBin;
    
    PayUWebServiceResponse *webServiceResponse = [PayUWebServiceResponse new];
    [webServiceResponse deleteStoredCard:self.paymentParam withCompletionBlock:^(NSString *deleteStoredCardStatus, NSString *deleteStoredCardMessage, NSString *errorMessage, id extraParam) {
        
        if (errorMessage) {
            [activityIndicatorObj stopAnimatingActivityIndicator];
            PAYU_ALERT(@"Error", errorMessage);
        } else {
            [activityIndicatorObj stopAnimatingActivityIndicator];
            [self.arrStoredCards removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self setEditing:NO animated:YES];
        }}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrStoredCards.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CardCellCellIdentifier forIndexPath:indexPath];
    
    if (self.tableViewType == TableViewTypeSC) {
        PayUModelStoredCard *modelStoredCard;
        modelStoredCard=[self.arrStoredCards objectAtIndex:indexPath.row];
        
        cell.textLabel.text = modelStoredCard.cardNo;
        cell.detailTextLabel.text = modelStoredCard.cardName;
        
    }
    else if ((self.tableViewType == TableViewTypeEMIBank)||(self.tableViewType == TableViewTypeEMIDuration)){
        cell.textLabel.text = [self.arrStoredCards objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = @"";
    }
    else{
        modelNB = [self.arrStoredCards objectAtIndex:indexPath.row];
        
        cell.textLabel.text = modelNB.netBankingTitle;
        cell.detailTextLabel.text = @"";
    }
    if(self.cardIndex == indexPath.row)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
    // Configure the cell...
    
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     if (self.tableViewType == TableViewTypeSC) {
         return YES;
     }
     else{
         return NO;
     }
 }


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableViewType == TableViewTypeSC) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            // Delete the row from the data source
            [self removeStoredCard:indexPath];
            //        [self setEditing:NO animated:YES];
            
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    else{
    }
}


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
 #pragma mark - Table view delegate
 
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 if(self.indexPathCrt)
 {
 [tableView cellForRowAtIndexPath:self.indexPathCrt].accessoryType = UITableViewCellAccessoryNone;
 }
 
 [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
 self.indexPathCrt = indexPath;
 
 [self performSegueWithIdentifier:UnwindCardOptionSegueIdentifier sender:self];
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cardIndex inSection:0]].accessoryType = UITableViewCellAccessoryNone;
    
    NSIndexPath *crtIndexPath = [self.tableView indexPathForCell:sender];
    
    [self.tableView cellForRowAtIndexPath:crtIndexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    //    [PUUIUtility setCardIndex:crtIndexPath.row];
    if([self.delegate respondsToSelector:@selector(cardOptionSelectedWithIndex:)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (crtIndexPath) {
                [self.delegate cardOptionSelectedWithIndex:crtIndexPath.row];
            }
            else{
                [self.delegate cardOptionSelectedWithIndex:self.cardIndex];
            }
        });
        
    }
}


@end
