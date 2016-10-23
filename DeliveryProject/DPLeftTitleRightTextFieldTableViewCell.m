//
//  DPLeftTitleRightTextFieldTableViewCell.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/22.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPLeftTitleRightTextFieldTableViewCell.h"
#import <Masonry/Masonry.h>

@interface DPLeftTitleRightTextFieldTableViewCellInnerView()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UITextField *rightTextField;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation DPLeftTitleRightTextFieldTableViewCellInnerView

#pragma mark - init -
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightTextField];
        [self addSubview:self.bottomLine];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - private -
- (void)setupConstraints
{
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(10);
        make.width.equalTo(@(58));
    }];

    [self.rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.leftLabel.mas_right).with.offset(20);
        make.right.equalTo(self).with.offset(-20);
    }];

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.rightTextField).with.offset(1);
        make.height.equalTo(@(0.5));
    }];
}

#pragma mark - getter && setter -
- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.minimumScaleFactor = 0.7;
        _leftLabel.adjustsFontSizeToFitWidth = YES;
        _leftLabel.font = [UIFont systemFontOfSize:16];
    }
    return _leftLabel;
}

- (UITextField *)rightTextField
{
    if (!_rightTextField) {
        _rightTextField = [[UITextField alloc] init];
        _rightTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _rightTextField;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLine;
}

@end

@interface DPLeftTitleRightTextFieldTableViewCell () <UITextFieldDelegate>

@property (nonatomic, strong) DPLeftTitleRightTextFieldTableViewCellInnerView *innerView;

@end

@implementation DPLeftTitleRightTextFieldTableViewCell

#pragma mark - init -
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.innerView];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - lifecycle -

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)prepareForReuse
{
    self.innerView.leftLabel.text = @"";
    self.innerView.rightTextField.text = @"";
    self.innerView.rightTextField.placeholder = @"";
}

#pragma mark - UITextFieldDelegate -
- (void)textDidChange:(NSNotification *)notification
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftTitleRightTextFieldChanged:stringInCell:)]) {
        [self.delegate leftTitleRightTextFieldChanged:self stringInCell:self.innerView.rightTextField.text];
    }
}

#pragma mark - private -
- (void)setupConstraints
{
    [self.innerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - getter && setter -
- (DPLeftTitleRightTextFieldTableViewCellInnerView *)innerView
{
    if (!_innerView) {
        _innerView = [[DPLeftTitleRightTextFieldTableViewCellInnerView alloc] init];
        _innerView.rightTextField.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self.innerView.rightTextField];
    }
    return _innerView;
}

@end
