//
//  DPLeftTextFieldRightCustomButtonTableViewCell.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPLeftTextFieldRightCustomButtonTableViewCell.h"
#import "UIColor+DPTheme.h"
#import <Masonry/Masonry.h>

@interface DPLeftTextFieldRightCustomButtonTableViewCell () <UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UITextField *leftTextField;
@property (nonatomic, strong, readwrite) UIView *rightView;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation DPLeftTextFieldRightCustomButtonTableViewCell

#pragma mark - life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;

        [self.contentView addSubview:self.leftTextField];
        [self.contentView addSubview:self.rightView];
        [self addSubview:self.bottomLine];
        [self setUpConstraints];
    }
    return self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(leftTextFieldRightCustomButtonCell:textFieldShouldBeginEditing:)]) {
        return [self.delegate leftTextFieldRightCustomButtonCell:self textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(leftTextFieldRightCustomButtonCell:textFieldDidBeginEditing:)]) {
        [self.delegate leftTextFieldRightCustomButtonCell:self textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(leftTextFieldRightCustomButtonCell:textFieldDidEndEditing:)]) {
        [self.delegate leftTextFieldRightCustomButtonCell:self textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(leftTextFieldRightCustomButtonCell:textFieldShouldReturn:)]) {
        return [self.delegate leftTextFieldRightCustomButtonCell:self textFieldShouldReturn:textField];
    }
    return YES;
}


#pragma mark - private methods

- (void)setUpConstraints
{
    [self.leftTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(18);
        make.right.equalTo(self.rightView.mas_left).offset(-10);
        make.top.equalTo(self.contentView.mas_top);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];

    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.lessThanOrEqualTo(@110);
        make.right.equalTo(self.contentView.mas_right).offset(-18);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@0.5);
    }];
}

- (void)setRightButtonView:(UIView *)buttonView
{
    if (!buttonView) {
        [self.leftTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(18);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.contentView.mas_top);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        return;
    }
    [[self.rightView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self.rightView addSubview:buttonView];
    CGFloat height = buttonView.frame.size.height;
    CGFloat width = buttonView.frame.size.width;
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.rightView.mas_centerY);
        make.centerX.equalTo(self.rightView.mas_centerX);
        make.width.equalTo([NSNumber numberWithFloat:width]);
        make.width.equalTo(self.rightView.mas_width);
        make.height.equalTo([NSNumber numberWithFloat:height]);
        make.height.lessThanOrEqualTo(self.rightView.mas_height);
    }];
}

- (void)rightButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(leftTextFieldRightCustomButtonCell:rightButtonClicked:)]) {
        [self.delegate leftTextFieldRightCustomButtonCell:self rightButtonClicked:sender];
    }
}

#pragma mark - getters & setters

- (UITextField *)leftTextField
{
    if (!_leftTextField) {
        _leftTextField = [[UITextField alloc] init];
        _leftTextField.placeholder = @"请输入";
        _leftTextField.textColor = [UIColor dp_blackColor];
        _leftTextField.font = [UIFont systemFontOfSize:16];
        _leftTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _leftTextField.delegate = self;
    }
    return _leftTextField;
}

- (UIView *)rightView
{
    if (!_rightView) {
        _rightView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonClicked:)];
        [_rightView addGestureRecognizer:tap];
    }
    return _rightView;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor dp_lightGrayColor];
    }

    return _bottomLine;
}

@end
