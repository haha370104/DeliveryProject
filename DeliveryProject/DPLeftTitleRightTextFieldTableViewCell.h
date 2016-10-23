//
//  DPLeftTitleRightTextFieldTableViewCell.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/22.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DPLeftTitleRightTextFieldTableViewCell;
@protocol DPLeftTitleRightTextFieldCellDelegate <NSObject>

- (void)leftTitleRightTextFieldChanged:(DPLeftTitleRightTextFieldTableViewCell *)cell stringInCell:(NSString *)stringInCell;

@end

@interface DPLeftTitleRightTextFieldTableViewCellInnerView : UIView

@property (nonatomic, strong, readonly) UILabel *leftLabel;
@property (nonatomic, strong, readonly) UITextField *rightTextField;

@end

@interface DPLeftTitleRightTextFieldTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) DPLeftTitleRightTextFieldTableViewCellInnerView *innerView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<DPLeftTitleRightTextFieldCellDelegate> delegate;

@end
