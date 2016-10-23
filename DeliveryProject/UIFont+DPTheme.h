//
//  UIFont+DPTheme.h
//  Baixing
//
//  Created by hyice on 15/8/19.
//  Copyright (c) 2015年 Baixing. All rights reserved.
//

@import UIKit;


@interface UIFont (DPTheme)

+ (UIFont *)dp_systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)dp_boldSystemFontOfSize:(CGFloat)fontSize;
// Returns an instance of the font associated with the text style and scaled appropriately for the user's selected content size category. See UIFontDescriptor.h for the complete list.

+ (UIFont *)dp_fontOfSize:(CGFloat)fontSize;
+ (UIFont *)dp_preferredFontForTextStyle:(NSString *)textStyle;
+ (UIFont *)dp_fontForTitle1;
+ (UIFont *)dp_fontForTitle2;
+ (UIFont *)dp_fontForTitle3;
+ (UIFont *)dp_fontForHeadline;
+ (UIFont *)dp_fontForSubheadline;
+ (UIFont *)dp_fontForBody;
+ (UIFont *)dp_fontForCallout;
+ (UIFont *)dp_fontForFootnote;
+ (UIFont *)dp_fontForCaption1;
+ (UIFont *)dp_fontForCaption2;

@end
