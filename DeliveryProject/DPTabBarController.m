//
//  FQTabBarController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/22.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPTabBarController.h"
#import "DPLoginController.h"

#import "DPUserInfoController.h"
#import "DPSearchPackageController.h"

#import "DPUserApi.h"

@interface DPTabBarController ()

@end

@implementation DPTabBarController

#pragma mark - lifecycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBarItem];
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

- (void)setupTabBarItem
{
    DPSearchPackageController *searchPackageController = [[DPSearchPackageController alloc] init];
    searchPackageController.tabBarItem.title = @"运包裹";
    searchPackageController.tabBarItem.image = [UIImage imageNamed:@"search"];
    UINavigationController *searchPackageNavigationController = [[UINavigationController alloc] initWithRootViewController:searchPackageController];
    searchPackageController.navigationItem.title = @"包裹查询";

    DPUserInfoController *userInfoController = [[DPUserInfoController alloc] init];
    userInfoController.tabBarItem.title = @"个人中心";
    userInfoController.tabBarItem.image = [UIImage imageNamed:@"person"];
    UINavigationController *userInfoNavigationController = [[UINavigationController alloc] initWithRootViewController:userInfoController];
    userInfoController.navigationItem.title = @"个人中心";

    self.viewControllers = @[searchPackageNavigationController, userInfoNavigationController];
}

@end
