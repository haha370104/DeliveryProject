//
//  FQTabBarController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/22.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPTabBarController.h"
#import "DPLoginController.h"

#import "DPUserApi.h"

@interface DPTabBarController ()

@end

@implementation DPTabBarController

#pragma mark - lifecycle -

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [DPUserApi checkIfLoginWithLoginAction:^(NSDictionary *response) {
        NSLog(@"已登录");
    } notLoginAction:^(NSDictionary *response) {
        DPLoginController *loginController = [[DPLoginController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginController];
        [self presentViewController:navi animated:YES completion:nil];
    }];
}

@end
