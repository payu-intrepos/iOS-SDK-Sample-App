//
//  PUUINBTopView.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 14/01/16.
//  Copyright © 2016 PayU. All rights reserved.
//

#import "PUUINBTopView.h"

#define BUTTON_HEIGHT_WIDTH 45
#define BUTTON_BOTTOM_PADDING 10
#define BUTTON_TOP_PADDING 0

@interface PUUINBTopView()

{
    NSArray *arrBankName;
    id delegateCallBack;
    NSInteger btnTagStartValue;
}
@property (nonatomic,strong) NSDictionary *dictBankName;

@end

@implementation PUUINBTopView

-(instancetype)initWithFrame:(CGRect)frame withBankDict:(NSDictionary *) dictBankName withBtnTagStartValue:(NSInteger) btnTagStart withDelegate:(id) delegate{
    self = [super initWithFrame:frame];
    if (self) {
        self.dictBankName = dictBankName;
        arrBankName = [NSArray arrayWithArray:[dictBankName allValues]];
        delegateCallBack = delegate;
        btnTagStartValue = btnTagStart;
        [self initializeBtnAndLbl];
        
    }
    return self;
}

-(void)initializeBtnAndLbl{
    CGFloat height = self.frame.size.height ,width = self.frame.size.width/[[self.dictBankName allKeys] count] ,xCord = 0,yCord = 0;
    for (int counter = 0; counter < [[self.dictBankName allKeys] count]; counter++) {
        UIView *bankView = [[UIView alloc]initWithFrame:CGRectMake(xCord, yCord, width, height)];
        [self addSubview:bankView];
        NSLog(@"%@",self);
        NSLog(@"%@",bankView);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((width-BUTTON_HEIGHT_WIDTH)/2, BUTTON_TOP_PADDING, BUTTON_HEIGHT_WIDTH, BUTTON_HEIGHT_WIDTH);
        btn.layer.cornerRadius = BUTTON_HEIGHT_WIDTH/2;
        btn.layer.borderWidth = 0;
        [btn setBackgroundImage:[UIImage imageNamed:[arrBankName objectAtIndex:counter]] forState:UIControlStateNormal];
        [btn addTarget:delegateCallBack action:@selector(btnClickedTop4Bank:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = btnTagStartValue+counter;
        [bankView addSubview:btn];
        NSLog(@"%@",btn);
        
        UILabel *label = [UILabel new];
        label.text = [arrBankName objectAtIndex:counter];
        [label sizeToFit];
        label.frame = CGRectMake((width-CGRectGetWidth(label.frame))/2,CGRectGetMaxY(btn.frame) + BUTTON_BOTTOM_PADDING, CGRectGetWidth(label.frame), CGRectGetHeight(label.frame));
        NSLog(@"%@",label);
        [bankView addSubview:label];
        xCord += width;
    }
    
}
-(void)btnClickedTop4Bank:(id) sender{
    /*
     Implemented in calling class
     */
}

@end
