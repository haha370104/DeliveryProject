//
//  UIWindow+MainWindow.h
//  Baixing
//
//  Created by 邱峰 on 11/20/14.
//  Copyright (c) 2014 baixing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIWindow (MainWindow)

/**
 *  正常情况下返回 屏幕的那个view 我也不知道什么情况下异常- -（异常返回nil）
 */
+ (UIView *)mainWindow;
+ (UIView *)foreMostWindow;

@end
