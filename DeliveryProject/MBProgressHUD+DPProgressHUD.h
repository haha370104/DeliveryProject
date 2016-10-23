//
//  MBProgressHUD+DPPorgressHUD.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (DPProgressHUD)

/**
 *  封装的MBProgressHUB  显示错误状态使用 默认时间1s
 *
 *  @param errorMessage 显示的title
 *  @param view         如果填nil 会以整个屏幕的window为superview
 */
+ (void)showErrorState:(NSString *)errorMessage inView:(UIView *)view;

/**
 *  封装的MBProgressHUB  显示成功状态使用 默认时间1s
 *
 *  @param successMessage 显示的title
 *  @param view         如果填nil 会以整个屏幕的window为superview
 */
+ (void)showSuccessState:(NSString *)successMessage inView:(UIView *)view;

/**
 *  loading 的不会自动删除 所以返回一个view
 *  创建失败会返回nil
 */
+ (MBProgressHUD *)showLoadingState:(NSString *)title inView:(UIView *)view inBackground:(BOOL)dimBackground;
/**
 *  封装的MBProgressHUB  显示一句话 默认时间1s
 *
 *  @param message 显示的title
 *  @param view         如果填nil 会以整个屏幕的window为superview
 */
+ (void)toast:(NSString *)message inView:(UIView *)view;

@end
