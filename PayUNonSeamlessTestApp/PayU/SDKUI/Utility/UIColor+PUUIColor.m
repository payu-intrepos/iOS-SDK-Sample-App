//
//  UIColor+PUUIColor.m
//  PayUNonSeamlessTestApp
//
//  Created by Umang Arya on 30/12/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#import "UIColor+PUUIColor.h"

@implementation UIColor (PUUIColor)

//PayU Tab Indicator Color
+(UIColor *)payUTabIndicatorColor
{
    return [UIColor colorWithRed:52.0f/255.0f green:136.0f/255.0f blue:197.0f/255.0f alpha:1];
}

//PayU TabBar Background color
+(UIColor *)payUTabBarBackgroundColor
{
    return [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:251.0f/255.0f alpha:1.0];
}


//PayNow Enable color
+(UIColor *)payNowEnableColor
{
    return [UIColor colorWithRed:52.0f/255.0f green:136.0f/255.0f blue:197.0f/255.0f alpha:1];
}

//PayNow Disable color
+(UIColor *)payNowDisableColor
{
    return [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:231.0f/255.0f alpha:1];
}

//PayU viewBorderColor and seperator line color
+(UIColor *)payUViewBorderColor
{
    return [UIColor colorWithRed:156.0f/255.0f green:156.0f/255.0f blue:157.0f/255.0f alpha:1];
}
@end
