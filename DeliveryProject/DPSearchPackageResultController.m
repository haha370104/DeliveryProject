//
//  DPSearchPackageResultController.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPSearchPackageResultController.h"
#import "DPShowPackageTableViewCell.h"
#import "DPPackageApi.h"

#import "MBProgressHUD+DPProgressHUD.h"
#import "NSObject+DPTypeCheck.h"
#import "NSObject+DPOperation.h"

#import <Masonry/Masonry.h>

@interface DPSearchPackageResultController ()<UITableViewDelegate, UITableViewDataSource, DPShowPackageTableViewCellDelegate>

@property (nonatomic, copy) NSArray<DPPackage *> *packageArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DPSearchPackageResultController

#pragma mark - init -

- (instancetype)initWithPackageArray:(NSArray<DPPackage *> *)packageArray
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
    DPShowPackageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DPShowPackageTableViewCell class])];
    DPPackage *package = [self.packageArray dp_safeObjectAtIndex:indexPath.row];
    cell.packageIdLabel.text = package.packageId;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd HH:mm";
    cell.createTimeLabel.text = [NSString stringWithFormat:@"创建时间:%@",[dateFormatter stringFromDate:package.createTime]];
    cell.contentLabel.text = package.packageContent;
    cell.weightLabel.text = package.packageWeight;
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - DPShowPackageTableViewCellDelegate -

- (void)DPShowPackageTableViewCell:(DPShowPackageTableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    DPPackage *package = [self.packageArray dp_safeObjectAtIndex:indexPath.row];
    [DPPackageApi confirmPackage:package.packageId complete:^(NSDictionary *response, BOOL success) {
        if (success) {
            [MBProgressHUD showSuccessState:@"接单成功，请进入个人中心查看" inView:nil];
        } else {
            [MBProgressHUD showErrorState:[response stringValueForKey:@"error"] inView:nil];
        }
    }];
}

#pragma mark - getter && setter -

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[DPShowPackageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DPShowPackageTableViewCell class])];
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

@end
