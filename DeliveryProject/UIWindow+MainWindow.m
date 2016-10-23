//
//  UIWindow+MainWindow.m
//  Baixing
//
//  Created by 邱峰 on 11/20/14.
//  Copyright (c) 2014 baixing. All rights reserved.
//

#import "UIWindow+MainWindow.h"


@implementation UIWindow (MainWindow)

+ (UIView *)mainWindow
{
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];

    for (UIWindow *window in frontToBackWindows)
        if (window.windowLevel == UIWindowLevelNormal) {
            return window;
        }
    return nil;
}

+ (UIView *)foreMostWindow
{
    return [[[UIApplication sharedApplication] windows] lastObject];
}

@end
