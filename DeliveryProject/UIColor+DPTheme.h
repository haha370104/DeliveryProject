//
//  UIColor+DPTheme.h
//  Baixing
//
//  Created by hyice on 15/8/18.
//  Copyright (c) 2015年 Baixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DPConverter)

+ (UIColor *)dp_colorFromHexRGB:(NSInteger)rgbValue;

+ (UIColor *)dp_colorFromHexRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha;

+ (UIColor *)dp_colorFromRGBColor:(UIColor *)color alpha:(CGFloat)alpha;

+ (UIColor *)dp_colorFromHexString:(NSString *)hexString;

@end




@interface UIColor (DPQuickUsage)

+ (UIColor *)dp_themeColor;

+ (UIColor *)dp_separatorGray;
+ (UIColor *)dp_darkSeparatorGray;

+ (UIColor *)dp_backgroundGray;

+ (UIColor *)dp_separatorColor __attribute__((deprecated));


@end


@interface UIColor (DPTheme)

#pragma mark - black or white

+ (UIColor *)dp_blackColor;
+ (UIColor *)dp_darkGrayColor;
+ (UIColor *)dp_grayColor;
+ (UIColor *)dp_lightGrayColor;
+ (UIColor *)dp_aLittleGrayColor;
/*
 * Deprecated. Use dp_almostWhiteColor instead.
 */
+ (UIColor *)dp_lightLightGrayColor __attribute__((deprecated));
+ (UIColor *)dp_almostWhiteColor;
+ (UIColor *)dp_whiteColor;


#pragma mark - colorful world
+ (UIColor *)dp_radicalRedColor;
+ (UIColor *)dp_yellowColor;
+ (UIColor *)dp_greenColor;
+ (UIColor *)dp_blueColor;
+ (UIColor *)dp_orangeColor;


@end
