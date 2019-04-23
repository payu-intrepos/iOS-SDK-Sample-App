//
//  PUUINBVC.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "PUUINBVC.h"
#import "PUUIConstants.h"
#import "PUUICardOptionVC.h"
#import "PUUINBTopView.h"

#define BUTTON_TAG_START_VALUE 300

static NSString * const NBSegueIdentifier = @"NBSegue";

@interface PUUINBVC () <CardOptionDelegate>
{
    NSDictionary * dictSupportedTop4Bank;
    NSMutableDictionary * dictActualTop4Bank;
    NSArray *arrActualTop4BankName;
    NSInteger indexCard;
}
@property (weak, nonatomic) IBOutlet UIView *vwBankCellContainer;
@property (weak, nonatomic) IBOutlet UIButton *btnBankName;

@end

@implementation PUUINBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    [self getTop4BankList];
    [self setTopView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:true];
    [self enableDisablePayNowWithUserInfo:nil];
}

#pragma mark - Initial Setup

-(void)initialSetup{
    dictSupportedTop4Bank = [NSDictionary dictionaryWithObjectsAndKeys:@"AXIS",@"AXIB",@"HDFC",@"HDFB",@"ICICI",@"ICIB",@"SBI",@"SBIB", nil];
    dictActualTop4Bank = [NSMutableDictionary new];
    
    [self.btnBankName.layer setBorderColor:[UIColor payUViewBorderColor].CGColor];
}

-(void)getTop4BankList{
    for (PayUModelNetBanking *NBList in self.paymentRelatedDetail.netBankingArray) {
        if ([dictSupportedTop4Bank.allKeys containsObject:NBList.bankCode]) {
            [dictActualTop4Bank setObject:[dictSupportedTop4Bank objectForKey:NBList.bankCode] forKey:NBList.bankCode];
        }
    }
    arrActualTop4BankName = [NSArray arrayWithArray:[dictActualTop4Bank allValues]];
}

-(void)setTopView{
    [self.vwBankCellContainer layoutIfNeeded];
    PUUINBTopView *topView = [[PUUINBTopView alloc] initWithFrame:self.vwBankCellContainer.bounds withBankDict:dictActualTop4Bank withBtnTagStartValue:BUTTON_TAG_START_VALUE withDelegate:self];
    [self.vwBankCellContainer addSubview:topView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action

- (IBAction)btnClickedTop4Bank:(id)sender{
    UIButton * button = (UIButton *)sender;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"1",kPUUIPayNow, nil];
    self.paymentParam.bankCode = [[dictActualTop4Bank allKeysForObject:[arrActualTop4BankName objectAtIndex:button.tag-BUTTON_TAG_START_VALUE]] objectAtIndex:0];
    [self enableDisablePayNowWithUserInfo:dict];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:NBSegueIdentifier]) {
        UINavigationController *nav = [segue destinationViewController];
        PUUICardOptionVC *cardOptionVC = (PUUICardOptionVC *)[nav topViewController];
        cardOptionVC.paymentParam = self.paymentParam;
        cardOptionVC.arrStoredCards = (NSMutableArray *)self.paymentRelatedDetail.netBankingArray;
        cardOptionVC.delegate = self;
        if (!self.paymentParam.bankCode) {
            cardOptionVC.cardIndex = -1;
        }
        else{
            cardOptionVC.cardIndex = indexCard;
        }
        cardOptionVC.tableViewType = TableViewTypeNB;
    }
}

#pragma mark - Unwind segue

- (IBAction)unwindToStoredCardVC:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[PUUICardOptionVC class]]) {
    }
}

#pragma mark - CardOptionDelegate method

- (void) cardOptionSelectedWithIndex:(NSInteger)cardIndex
{
    if (cardIndex >=0) {
        indexCard = cardIndex;
        PayUModelNetBanking *modelNetBanking = [self.paymentRelatedDetail.netBankingArray objectAtIndex:indexCard];
        [self.btnBankName setTitle:modelNetBanking.netBankingTitle forState:UIControlStateNormal];
        self.paymentParam.bankCode = modelNetBanking.bankCode;
    }
}

-(void)enableDisablePayNowWithUserInfo:(NSDictionary *) dict{
    if (self.paymentParam.bankCode) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:self.paymentParam userInfo:dict];

    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kPUUINotiEnablePayNow object:nil userInfo:dict];
    }
}


@end