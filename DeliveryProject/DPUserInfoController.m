//
//  DPUserInfoController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPUserInfoController.h"
#import "DPUserManager.h"
#import "DPUserApi.h"
#import "DPOrderApi.h"
#import "DPLoginController.h"

#import "UIColor+DPTheme.h"
#import "UIFont+DPTheme.h"
#import "MBProgressHUD+DPProgressHUD.h"
#import "NSObject+DPTypeCheck.h"

#import <Masonry/Masonry.h>

@interface DPUserInfoController ()

@property (nonatomic, strong) UIImageView *userAvatar;
@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UIButton *confirmPackage;
@property (nonatomic, strong) UIButton *passingPackage;
@property (nonatomic, strong) UIButton *historyPackage;
@property (nonatomic, strong) UIButton *logoutImageView;

@end

@implementation DPUserInfoController

#pragma mark - init -

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.userAvatar];
        [self.view addSubview:self.userNameLabel];

        [self.view addSubview:self.confirmPackage];
        [self.view addSubview:self.passingPackage];
        [self.view addSubview:self.historyPackage];
        [self.view addSubview:self.logoutImageView];

        [self setupConstraints];
    }
    return self;
}

#pragma mark - lifecycle -

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.userNameLabel.text = [DPUserManager shareManager].user.userName;
}

#pragma mark - action -

- (void)checkConfirmOrder:(UIButton *)sender
{

}

- (void)checkPassingOrder:(UIButton *)sender
{

}

- (void)checkFinishedOrder:(UIButton *)sender
{

}

- (void)logout:(UIButton *)sender
{
    [DPUserApi logoutWithComplete:^(NSDictionary *response, BOOL success) {
        if (success) {
            [MBProgressHUD showSuccessState:@"登出成功" inView:nil];
            DPLoginController *loginController = [[DPLoginController alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginController];
            [self presentViewController:navi animated:YES completion:nil];
        } else {
            [MBProgressHUD showErrorState:[response stringValueForKey:@"error"] inView:nil];
        }
    }];
}

#pragma mark - private -

- (void)setupConstraints
{
    [self.userAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(self.userAvatar.mas_width);
        make.width.equalTo(self.view).multipliedBy(0.3f);
        make.top.equalTo(self.view).with.offset(84);
    }];

    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userAvatar.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view);
    }];

    [self.confirmPackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(self.view.mas_width).multipliedBy(0.25f);
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.userAvatar.mas_bottom).with.offset(80);
    }];

    [self.passingPackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.confirmPackage);
        make.width.height.equalTo(self.confirmPackage);
        make.right.equalTo(self.view).with.offset(-50);
    }];

    [self.historyPackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.confirmPackage);
        make.width.height.equalTo(self.confirmPackage);
        make.top.equalTo(self.confirmPackage.mas_bottom).with.offset(80);
    }];

    [self.logoutImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.passingPackage);
        make.centerY.equalTo(self.historyPackage);
        make.width.height.equalTo(self.confirmPackage);
    }];
}

#pragma mark - getter && setter -

- (UIImageView *)userAvatar
{
    if (!_userAvatar) {
        _userAvatar = [[UIImageView alloc] init];
        _userAvatar.image = [UIImage imageNamed:@"man_avatar"];
    }
    return _userAvatar;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = [UIColor dp_grayColor];
        _userNameLabel.font = [UIFont dp_fontOfSize:14];
    }
    return _userNameLabel;
}

- (UIButton *)confirmPackage
{
    if (!_confirmPackage) {
        _confirmPackage = [[UIButton alloc] init];
        [_confirmPackage setBackgroundImage:[UIImage imageNamed:@"package"] forState:UIControlStateNormal];
        [_confirmPackage setTitle:@"已接单包裹" forState:UIControlStateNormal];
        [_confirmPackage setTitleColor:[UIColor dp_grayColor] forState:UIControlStateNormal];
        [_confirmPackage setTitleEdgeInsets:UIEdgeInsetsMake(130, 0, 0, 0)];
        _confirmPackage.titleLabel.font = [UIFont dp_fontOfSize:14];

        [_confirmPackage addTarget:self action:@selector(checkConfirmOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmPackage;
}

- (UIButton *)passingPackage
{
    if (!_passingPackage) {
        _passingPackage = [[UIButton alloc] init];
        [_passingPackage setBackgroundImage:[UIImage imageNamed:@"delivery"] forState:UIControlStateNormal];
        [_passingPackage setTitle:@"运送中包裹" forState:UIControlStateNormal];
        [_passingPackage setTitleColor:[UIColor dp_grayColor] forState:UIControlStateNormal];
        [_passingPackage setTitleEdgeInsets:UIEdgeInsetsMake(130, 0, 0, 0)];
        _passingPackage.titleLabel.font = [UIFont dp_fontOfSize:14];

        [_passingPackage addTarget:self action:@selector(checkPassingOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passingPackage;
}

- (UIButton *)historyPackage
{
    if (!_historyPackage) {
        _historyPackage = [[UIButton alloc] init];
        [_historyPackage setBackgroundImage:[UIImage imageNamed:@"history"] forState:UIControlStateNormal];
        [_historyPackage setTitle:@"历史运送" forState:UIControlStateNormal];
        [_historyPackage setTitleColor:[UIColor dp_grayColor] forState:UIControlStateNormal];
        [_historyPackage setTitleEdgeInsets:UIEdgeInsetsMake(130, 0, 0, 0)];
        _historyPackage.titleLabel.font = [UIFont dp_fontOfSize:14];

        [_historyPackage addTarget:self action:@selector(checkFinishedOrder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _historyPackage;
}

- (UIButton *)logoutImageView
{
    if (!_logoutImageView) {
        _logoutImageView = [[UIButton alloc] init];
        [_logoutImageView setBackgroundImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
        [_logoutImageView setTitle:@"登出" forState:UIControlStateNormal];
        [_logoutImageView setTitleColor:[UIColor dp_grayColor] forState:UIControlStateNormal];
        [_logoutImageView setTitleEdgeInsets:UIEdgeInsetsMake(130, 0, 0, 0)];
        _logoutImageView.titleLabel.font = [UIFont dp_fontOfSize:14];

        [_logoutImageView addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutImageView;
}

@end
