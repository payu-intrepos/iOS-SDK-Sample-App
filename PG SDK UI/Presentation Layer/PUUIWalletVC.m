//
//  PUUIWalletVC.m
//  DoubleConversion
//
//  Created by Ashish Jain on 05/02/20.
//

#import "PUUIWalletVC.h"
#import "PUUICardOptionVC.h"

static NSString * const WalletSegueIdentifier = @"WalletSegue";

@interface PUUIWalletVC () <CardOptionDelegate>
{
    NSInteger indexCard;
}
@property (weak, nonatomic) IBOutlet UIButton *btnBankName;
@end

@implementation PUUIWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:true];
    [self enableDisablePayNowWithUserInfo:nil];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([[segue identifier] isEqualToString:WalletSegueIdentifier]) {
        UINavigationController *nav = [segue destinationViewController];
        PUUICardOptionVC *cardOptionVC = (PUUICardOptionVC *)[nav topViewController];
        cardOptionVC.paymentParam = self.paymentParam;
        cardOptionVC.arrStoredCards = (NSMutableArray *)self.paymentRelatedDetail.cashCardArray;
        cardOptionVC.delegate = self;
        cardOptionVC.isCashCard = true;
        if (!self.paymentParam.bankCode) {
            cardOptionVC.cardIndex = -1;
        }
        else{
            cardOptionVC.cardIndex = indexCard;
        }
        cardOptionVC.tableViewType = TableViewTypeNB;
    }
}

- (IBAction)unwindToStoredCardVC:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[PUUICardOptionVC class]]) {
    }
}

- (void) cardOptionSelectedWithIndex:(NSInteger)cardIndex
{
    if (cardIndex >=0) {
        indexCard = cardIndex;
        PayUModelCashCard *modelNetBanking = [self.paymentRelatedDetail.cashCardArray objectAtIndex:indexCard];
        [self.btnBankName setTitle:modelNetBanking.cashCardTitle forState:UIControlStateNormal];
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
