//
//  DPSearchPackageController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPSearchPackageController.h"
#import "DPSubwayPickerController.h"

#import "DPPackageApi.h"

#import "UIColor+DPTheme.h"
#import "UIFont+DPTheme.h"
#import "NSObject+DPOperation.h"
#import "NSObject+DPTypeCheck.h"
#import "MBProgressHUD+DPProgressHUD.h"

#import <Masonry/Masonry.h>

@interface DPSearchPackageController ()<UITableViewDelegate, UITableViewDataSource, DPSubwayPickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *startStation;
@property (nonatomic, strong) NSString *endStation;

@property (nonatomic, assign) NSInteger selectedCellIndex;

@end

@implementation DPSearchPackageController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.tableView];
        [self setupConstraints];
        _selectedCellIndex = -1;
    }
    return self;
}

#pragma mark - private -

- (void)setupConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)searchButtonClick:(UIButton *) sender
{
    if (!self.startStation.length) {
        [MBProgressHUD showErrorState:@"请选择起始站点！" inView:nil];
        return;
    }

    if (!self.endStation.length) {
        [MBProgressHUD showErrorState:@"请选择终点站点！" inView:nil];
        return;
    }

    [DPPackageApi searchPackageWithStartStation:self.startStation endStation:self.endStation complete:^(NSDictionary *response, BOOL success) {
        if (success) {
            NSArray *resultArray = [response arrayValueForKey:@"result"];
            if (!resultArray.count) {
                [MBProgressHUD showErrorState:@"此线路无可用订单" inView:nil];
            } else {
                
            }
        } else {
            [MBProgressHUD showErrorState:[response stringValueForKey:@"error"] inView:nil];
        }
    }];
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"请选择起始站";
    } else {
        cell.textLabel.text = @"请选择终点站";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor dp_radicalRedColor];
    [loginButton setTitle:@"搜索包裹" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont dp_systemFontOfSize:16];
    loginButton.layer.cornerRadius = 5;
    loginButton.clipsToBounds = YES;
    [loginButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(footerView).with.offset(15);
        make.right.equalTo(footerView).with.offset(-15);
        make.height.equalTo(@44);
    }];

    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedCellIndex = indexPath.row;
    DPSubwayPickerController *pickerController = [[DPSubwayPickerController alloc] init];
    pickerController.delegate = self;
    [self.navigationController pushViewController:pickerController animated:YES];
}

#pragma mark - DPSubwayPickerControllerDelegate -

- (void)DPSubwayPickerController:(DPSubwayPickerController *)controller didSelectedSubwayStation:(NSString *)subwayStation
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedCellIndex inSection:0]];
    if (self.selectedCellIndex == 0) {
        self.startStation = subwayStation;
        cell.textLabel.text = [NSString stringWithFormat:@"起始站:    %@",subwayStation];
    } else {
        self.endStation = subwayStation;
        cell.textLabel.text = [NSString stringWithFormat:@"终点站:    %@",subwayStation];
    }
}

#pragma mark - getter && setter -

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

@end
