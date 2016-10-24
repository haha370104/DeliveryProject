//
//  DPShowOrderController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPShowOrderController.h"
#import "DPShowOrderTableViewCell.h"
#import "DPPackageApi.h"
#import "DPShowOrderQRImageController.h"

#import "MBProgressHUD+DPProgressHUD.h"
#import "NSObject+DPTypeCheck.h"
#import "NSObject+DPOperation.h"

#import <Masonry/Masonry.h>

@interface DPShowOrderController ()<UITableViewDelegate, UITableViewDataSource, DPShowOrderTableViewCellDelegate>

@property (nonatomic, copy) NSArray<DPOrder *> *packageArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DPShowOrderController

#pragma mark - init -

- (instancetype)initWithPackageArray:(NSArray<DPOrder *> *)packageArray
{
    self = [super init];
    if (self) {
        _packageArray = packageArray;
        [self.view addSubview:self.tableView];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - private -

- (void)setupConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.centerY.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.packageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPShowOrderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DPShowOrderTableViewCell class])];
    DPOrder *order = [self.packageArray dp_safeObjectAtIndex:indexPath.row];
    cell.packageIdLabel.text = order.orderId;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd HH:mm";
    cell.createTimeLabel.text = [NSString stringWithFormat:@"创建时间:%@",[dateFormatter stringFromDate:order.createTime]];
    cell.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间:%@",[dateFormatter stringFromDate:order.updateTime]];
    cell.contentLabel.text = order.packageContent;
    cell.weightLabel.text = order.packageWeight;
    cell.indexPath = indexPath;
    [cell setupButtonTextWithDPOrderState:order.state];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - DPShowOrderTableViewCellDelegate -

- (void)DPShowOrderTableViewCell:(DPShowOrderTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    DPOrder *order = [self.packageArray dp_safeObjectAtIndex:indexPath.row];
    NSDictionary *qrCodeJson = @{@"id":order.orderId, @"token":order.token};
    [self.navigationController pushViewController:[[DPShowOrderQRImageController alloc] initWithCodeJsonNSDictionary:qrCodeJson] animated:YES];
}

#pragma mark - getter && setter -

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[DPShowOrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DPShowOrderTableViewCell class])];
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

@end
