//
//  DPLoginController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/22.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPLoginController.h"
#import "DPLeftTitleRightTextFieldTableViewCell.h"

#import "UIColor+DPTheme.h"
#import "UIFont+DPTheme.h"

#import <Masonry/Masonry.h>

@interface DPLoginController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DPLoginController

#pragma mark - init -

- (instancetype)init
{
    if (self = [super init]) {
        [self.view addSubview:self.tableView];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - lifecycle -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

#pragma mark - private -

- (void)setupConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(self.view);
    }];
}

- (void)setupNavigationBar
{
    UIBarButtonItem *registerItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction:)];
    [registerItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor dp_blueColor] } forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = registerItem;

    if (self.presentingViewController) {
        UIBarButtonItem *dismissItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissButtonPressed:)];
        [dismissItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor dp_blueColor] } forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem = dismissItem;
    }
}

#pragma mark - action -

- (void)dismissButtonPressed:(UIButton *) sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerAction:(UIButton *) sender
{
    return;
}

- (void)loginButtonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)forgetPwdAction:(UIButton *)sender
{

}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor dp_radicalRedColor];
    [loginButton setTitle:@"登录蚂蚁相传" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont dp_systemFontOfSize:16];
    loginButton.layer.cornerRadius = 5;
    loginButton.clipsToBounds = YES;
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(footerView).with.offset(15);
        make.right.equalTo(footerView).with.offset(-15);
        make.height.equalTo(@44);
    }];

    UIButton *button = [[UIButton alloc] init];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"忘记密码？点击找回" attributes:@{
                                                                                                     NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                                                                                     NSForegroundColorAttributeName : [UIColor dp_darkGrayColor]
                                                                                                     }];
    [button setAttributedTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor dp_darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont dp_systemFontOfSize:14];
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(forgetPwdAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).with.offset(10);
        make.bottom.equalTo(footerView).with.offset(-10);
        make.centerX.equalTo(footerView);
        make.width.equalTo(@180);
    }];
    
    return footerView;
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPLeftTitleRightTextFieldTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DPLeftTitleRightTextFieldTableViewCell class])];
    cell.innerView.leftLabel.textColor = [UIColor grayColor];
    if (indexPath.row == 0) {
        cell.innerView.leftLabel.text = @"手机号";
        cell.innerView.rightTextField.placeholder = @"请输入用户手机号";
    } else {
        cell.innerView.leftLabel.text = @"密码";
        cell.innerView.rightTextField.placeholder = @"请输入密码";
        cell.innerView.rightTextField.secureTextEntry = YES;
    }
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - getter && setter -

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_tableView registerClass:[DPLeftTitleRightTextFieldTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DPLeftTitleRightTextFieldTableViewCell class])];
    }
    return _tableView;
}

@end
