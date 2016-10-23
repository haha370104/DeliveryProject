//
//  DPLeftTextFieldRightCustomButtonTableViewCell.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPLeftTextFieldRightCustomButtonTableViewCell;
@protocol DPLeftTextFieldRightCustomButtonCellDelegate <NSObject>

@optional
- (void)leftTextFieldRightCustomButtonCell:(DPLeftTextFieldRightCustomButtonTableViewCell *)cell rightButtonClicked:(id)sender;
- (BOOL)leftTextFieldRightCustomButtonCell:(DPLeftTextFieldRightCustomButtonTableViewCell *)cell textFieldShouldBeginEditing:(UITextField *)textField;
- (void)leftTextFieldRightCustomButtonCell:(DPLeftTextFieldRightCustomButtonTableViewCell *)cell textFieldDidBeginEditing:(UITextField *)textField;
- (void)leftTextFieldRightCustomButtonCell:(DPLeftTextFieldRightCustomButtonTableViewCell *)cell textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)leftTextFieldRightCustomButtonCell:(DPLeftTextFieldRightCustomButtonTableViewCell *)cell textFieldShouldReturn:(UITextField *)textField;

@end

@interface DPLeftTextFieldRightCustomButtonTableViewCell : UITableViewCell

@property (nonatomic, weak) id<DPLeftTextFieldRightCustomButtonCellDelegate> delegate;

@property (nonatomic, strong, readonly) UITextField *leftTextField;
@property (nonatomic, strong, readonly) UIView *rightView;
@property (nonatomic, strong) NSIndexPath *indexPath;

// 需要指定传入的buttonView的frame
- (void)setRightButtonView:(UIView *)buttonView;

@end
