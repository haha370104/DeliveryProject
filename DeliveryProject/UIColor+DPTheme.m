//
//  UIColor+DPTheme.m
//  Baixing
//
//  Created by hyice on 15/8/18.
//  Copyright (c) 2015年 Baixing. All rights reserved.
//

#import "UIColor+DPTheme.h"

@implementation UIColor (DPConverter)

+ (UIColor *)dp_colorFromHexRGB:(NSInteger)rgbValue
{
    return [self dp_colorFromHexRGB:rgbValue alpha:1.0];
}

+ (UIColor *)dp_colorFromHexRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha
{
    NSInteger mask = 0x000000FF;
    CGFloat red = ((rgbValue >> 16) & mask) / 255.0;
    CGFloat green = ((rgbValue >> 8) & mask) / 255.0;
    CGFloat blue = (rgbValue & mask) / 255.0;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)dp_colorFromRGBColor:(UIColor *)color alpha:(CGFloat)alpha
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    if (CGColorGetNumberOfComponents(color.CGColor) == 2) {
        return [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:alpha];
    } else {
        return [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:alpha];
    }
}

+ (UIColor *)dp_colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    if ([hexString hasPrefix:@"#"]) {
        [scanner setScanLocation:1];
    } else if ([hexString hasPrefix:@"0x"]) {
        [scanner setScanLocation:2];
    }
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0 green:((rgbValue & 0xFF00) >> 8) / 255.0 blue:(rgbValue & 0xFF) / 255.0 alpha:1.0];
}

@end




@implementation UIColor (DPQuickUsage)

+ (UIColor *)dp_themeColor
{
    return [self dp_radicalRedColor];
}

+ (UIColor *)dp_separatorGray
{
    return [self dp_aLittleGrayColor];
}

+ (UIColor *)dp_darkSeparatorGray
{
    return [self dp_lightGrayColor];
}

+ (UIColor *)dp_backgroundGray
{
    return [self dp_almostWhiteColor];
}

+ (UIColor *)dp_separatorColor
{
    return [self dp_separatorGray];
}

@end




@implementation UIColor (DPTheme)

#pragma mark - black or white

+ (UIColor *)dp_blackColor
{
    return [self dp_colorFromHexRGB:0x333333];
}

+ (UIColor *)dp_darkGrayColor
{
    return [self dp_colorFromHexRGB:0x666666];
}

+ (UIColor *)dp_grayColor
{
    return [self dp_colorFromHexRGB:0x999999];
}

+ (UIColor *)dp_lightGrayColor
{
    return [self dp_colorFromHexRGB:0xcccccc];
}

+ (UIColor *)dp_aLittleGrayColor
{
    return [self dp_colorFromHexRGB:0xe6e6e6];
}

+ (UIColor *)dp_lightLightGrayColor
{
    return [self dp_almostWhiteColor];
}

+ (UIColor *)dp_almostWhiteColor
{
    return [self dp_colorFromHexRGB:0xf2f2f2];
}

+ (UIColor *)dp_whiteColor
{
    return [self whiteColor];
}


#pragma mark - colorful world

+ (UIColor *)dp_radicalRedColor
{
    return [self dp_colorFromHexRGB:0xff4466];
}

+ (UIColor *)dp_yellowColor
{
    return [self dp_colorFromHexRGB:0xffc233];
}

+ (UIColor *)dp_greenColor
{
    return [self dp_colorFromHexRGB:0x00d0c0];
}

+ (UIColor *)dp_blueColor
{
    return [self dp_colorFromHexRGB:0x00aaf1];
}

+ (UIColor *)dp_orangeColor
{
    return [self dp_colorFromHexRGB:0xff9833];
}

@end
