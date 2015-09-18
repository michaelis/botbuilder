//
//  UIColor+CB_Color.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 18/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "UIColor+CB_Color.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation UIColor (UIColor_VVPontos)

#pragma mark - Greens

+ (UIColor *)CBlightGreenColor
{
    return UIColorFromRGB(0x009b3a);
}

@end
