//
//  UIFont+DPTheme.m
//  Baixing
//
//  Created by hyice on 15/8/19.
//  Copyright (c) 2015年 Baixing. All rights reserved.
//

#import "UIFont+DPTheme.h"


@implementation UIFont (DPTheme)

#pragma mark - Public

+ (UIFont *)dp_fontOfSize:(CGFloat)fontSize
{
    CGFloat offset = fontSize - 14.0f;
    return [self dp_fontWithSizeOffset:offset];
}

+ (UIFont *)dp_systemFontOfSize:(CGFloat)fontSize
{
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)dp_boldSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont boldSystemFontOfSize:fontSize];
}

+ (UIFont *)dp_preferredFontForTextStyle:(NSString *)textStyle
{
    if ([textStyle isEqualToString:UIFontTextStyleTitle1]) {
        return [self dp_fontForTitle1];
    } else if ([textStyle isEqualToString:UIFontTextStyleTitle2]) {
        return [self dp_fontForTitle2];
    } else if ([textStyle isEqualToString:UIFontTextStyleTitle3]) {
        return [self dp_fontForTitle3];
    } else if ([textStyle isEqualToString:UIFontTextStyleHeadline]) {
        return [self dp_fontForHeadline];
    } else if ([textStyle isEqualToString:UIFontTextStyleSubheadline]) {
        return [self dp_fontForSubheadline];
    } else if ([textStyle isEqualToString:UIFontTextStyleCallout]) {
        return [self dp_fontForCallout];
    } else if ([textStyle isEqualToString:UIFontTextStyleFootnote]) {
        return [self dp_fontForFootnote];
    } else if ([textStyle isEqualToString:UIFontTextStyleCaption1]) {
        return [self dp_fontForCaption1];
    } else if ([textStyle isEqualToString:UIFontTextStyleCaption2]) {
        return [self dp_fontForCaption2];
    } else if ([textStyle isEqualToString:UIFontTextStyleBody]) {
        return [self dp_fontForBody];
    } else {
        return [self dp_fontForBody];
    }
}

+ (UIFont *)dp_fontForTitle1
{
    return [self dp_fontWithSizeOffset:4.0f];
}

+ (UIFont *)dp_fontForTitle2
{
    return [self dp_fontWithSizeOffset:2.0f];
}

+ (UIFont *)dp_fontForTitle3
{
    return [self dp_fontWithSizeOffset:1.0f];
}

+ (UIFont *)dp_fontForHeadline
{
    return [self dp_fontForTitle2];
}

+ (UIFont *)dp_fontForSubheadline
{
    return [self dp_fontForTitle3];
}

+ (UIFont *)dp_fontForBody
{
    return [self dp_fontWithSizeOffset:0];
}

+ (UIFont *)dp_fontForCallout
{
    return [self dp_fontWithSizeOffset:-2.0f];
}

+ (UIFont *)dp_fontForFootnote
{
    return [self dp_fontWithSizeOffset:-3.0f];
}

+ (UIFont *)dp_fontForCaption1
{
    return [self dp_fontWithSizeOffset:-1.0f];
}

+ (UIFont *)dp_fontForCaption2
{
    return [self dp_fontWithSizeOffset:-2.0f];
}

#pragma mark - Private

+ (CGFloat)dp_baseFontSize
{
    static CGFloat baseFontSize = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        if (screenWidth > 375.0f) {
            baseFontSize = 14.0f;
        } else if (screenWidth > 320.0f) {
            baseFontSize = 14.0f;
        } else {
            baseFontSize = 12.0f;
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            baseFontSize = 20.0f;
        }
    });
    return baseFontSize;
}

+ (CGFloat)dp_fontSizeOffsetRatio
{
    static CGFloat offsetRatio = 1.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            offsetRatio = 2.0f;
        } else {
            offsetRatio = 1.0f;
        }
    });
    return offsetRatio;
}

+ (UIFont *)dp_fontWithSizeOffset:(CGFloat)offset
{
    CGFloat fontSize = [self dp_baseFontSize] + [self dp_fontSizeOffsetRatio] * offset;
    return [self systemFontOfSize:fontSize];
}

@end
