//
//  MBProgressHUD+DPPorgressHUD.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "MBProgressHUD+DPProgressHUD.h"
#import "UIWindow+mainWindow.h"
#import "DPActivityIndicatorView.h"

static CGFloat indicatorRadius = 20;

@implementation MBProgressHUD (DPProgressHUD)

+ (MBProgressHUD *)errorTypeInstanceWithView:(UIView *)view andTitle:(NSString *)title
{
    MBProgressHUD *progress = [[MBProgressHUD alloc] initWithView:view];

    if (title == nil) {
        title = @"";
    }

    progress.labelText = title;
    progress.dimBackground = YES;
    progress.mode = MBProgressHUDModeCustomView;
    progress.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"progress_error"]];
    progress.removeFromSuperViewOnHide = YES;
    return progress;
}

+ (MBProgressHUD *)successTypeInstanceWithView:(UIView *)view andTitle:(NSString *)title
{
    MBProgressHUD *progress = [[MBProgressHUD alloc] initWithView:view];

    if (title == nil) {
        title = @"";
    }

    progress.labelText = title;
    progress.dimBackground = YES;
    progress.mode = MBProgressHUDModeCustomView;
    progress.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"progress_confirm"]];
    progress.removeFromSuperViewOnHide = YES;
    return progress;
}

+ (void)showErrorState:(NSString *)errorMessage inView:(UIView *)view
{
    if (errorMessage.length == 0) {
        return;
    }

    if (view == nil) {
        view = [UIWindow foreMostWindow];
    }
    if (view) {
        MBProgressHUD *progress = [self errorTypeInstanceWithView:view andTitle:errorMessage];
        [view addSubview:progress];
        [progress show:YES];
        [progress hideView:YES];
    }
}

- (void)hideView:(BOOL)animated
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 1.0);
    ;
    dispatch_after(when, dispatch_get_main_queue(), ^{
        [self hide:animated];
    });
}

+ (void)showSuccessState:(NSString *)successMessage inView:(UIView *)view
{
    if (view == nil) {
        view = [UIWindow mainWindow];
    }
    if (view) {
        MBProgressHUD *progress = [self successTypeInstanceWithView:view andTitle:successMessage];
        [view addSubview:progress];
        [progress show:YES];
        [progress hideView:YES];
    }
}

+ (MBProgressHUD *)showLoadingState:(NSString *)title inView:(UIView *)view inBackground:(BOOL)dimBackground
{
    if (view == nil) {
        view = [UIWindow mainWindow];
    }
    if (view) {
        MBProgressHUD *progress = [[MBProgressHUD alloc] initWithView:view];
        progress.mode = MBProgressHUDModeCustomView;
        progress.customView = [[DPActivityIndicatorView alloc] initWithFrame:CGRectMake(view.center.x - indicatorRadius, view.center.y - indicatorRadius, indicatorRadius * 2, indicatorRadius * 2)];
        progress.removeFromSuperViewOnHide = YES;
        progress.dimBackground = dimBackground;

        if (title == nil) {
            title = @"";
        }

        progress.labelText = title;
        [view addSubview:progress];
        [progress show:YES];
        return progress;
    }
    return nil;
}

+ (void)toast:(NSString *)message inView:(UIView *)view
{
    if (view == nil) {
        view = [UIWindow mainWindow];
    }
    if (view) {
        MBProgressHUD *progress = [[MBProgressHUD alloc] init];
        progress.labelText = message;
        progress.mode = MBProgressHUDModeText;
        [view addSubview:progress];
        [progress show:YES];
        [progress hideView:YES];
    }
}


@end
