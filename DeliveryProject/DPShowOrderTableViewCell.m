//
//  DPShowOrderTableViewCell.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPShowOrderTableViewCell.h"

#import "UIFont+DPTheme.h"
#import "UIColor+DPTheme.h"

#import <Masonry/Masonry.h>

@interface DPShowOrderTableViewCell ()

@property (nonatomic, strong) UILabel *packageIdLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;
@property (nonatomic, strong) UILabel *updateTimeLabel;
@property (nonatomic, strong) UILabel *weightLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation DPShowOrderTableViewCell

#pragma mark - init -

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.packageIdLabel];
        [self.contentView addSubview:self.createTimeLabel];
        [self.contentView addSubview:self.updateTimeLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.weightLabel];

        [self.contentView addSubview:self.rightButton];

        [self setupConstraints];
    }
    return self;
}

#pragma mark - public -

- (void)setupButtonTextWithDPOrderState:(DPOrderState)state
{
    switch (state) {
        case DPOrderConfirm:
            [self.rightButton setTitle:@"开始运送" forState:UIControlStateNormal];
            break;
        case DPOrderPassing:
            [self.rightButton setTitle:@"确认送达" forState:UIControlStateNormal];
            break;
        case DPOrderFinished:
            [self.rightButton setTitle:@"已完成" forState:UIControlStateNormal];
            self.rightButton.enabled = NO;
            break;
        default:
            break;
    }
}

#pragma mark - private -

- (void)setupConstraints
{
    [self.packageIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(5);
        make.left.equalTo(self.contentView).with.offset(15);
    }];

    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(50);
    }];

    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentLabel.mas_right).with.offset(30);
    }];

    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-20);
        make.width.equalTo(@(64));
        make.height.equalTo(@(32));
    }];

    [self.updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).with.offset(-5);
        make.right.equalTo(self.contentView).with.offset(-40);
    }];

    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.updateTimeLabel);
        make.left.equalTo(self.contentView).with.offset(40);
    }];
}

#pragma mark - action -

- (void)rightButtonClick:(UIButton *)sender
{
    if (self.delegate) {
        [self.delegate DPShowOrderTableViewCell:self indexPath:self.indexPath];
    }
}

#pragma mark - getter && setter -

- (UILabel *)packageIdLabel
{
    if (!_packageIdLabel) {
        _packageIdLabel = [[UILabel alloc] init];
        _packageIdLabel.textColor = [UIColor dp_grayColor];
        _packageIdLabel.font = [UIFont dp_fontOfSize:12];
    }
    return _packageIdLabel;
}

- (UILabel *)createTimeLabel
{
    if (!_createTimeLabel) {
        _createTimeLabel = [[UILabel alloc] init];
        _createTimeLabel.font = [UIFont dp_fontOfSize:12];
        _createTimeLabel.textColor = [UIColor dp_blackColor];
    }
    return _createTimeLabel;
}

- (UILabel *)updateTimeLabel
{
    if (!_updateTimeLabel) {
        _updateTimeLabel = [[UILabel alloc] init];
        _updateTimeLabel.font = [UIFont dp_fontOfSize:12];
        _updateTimeLabel.textColor = [UIColor dp_blackColor];
    }
    return _updateTimeLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont dp_fontOfSize:14];
        _contentLabel.textColor = [UIColor dp_blackColor];
    }
    return _contentLabel;
}

- (UILabel *)weightLabel
{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc] init];
        _weightLabel.font = [UIFont dp_fontOfSize:12];
        _weightLabel.textColor = [UIColor dp_blackColor];
    }
    return _weightLabel;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.titleLabel.font = [UIFont dp_fontOfSize:13];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@end
