//
//  DPShowOrderTableViewCell.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPOrder.h"

@class DPShowOrderTableViewCell;
@protocol DPShowOrderTableViewCellDelegate <NSObject>

- (void)DPShowOrderTableViewCell:(DPShowOrderTableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end

@interface DPShowOrderTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *packageIdLabel;
@property (nonatomic, strong, readonly) UILabel *createTimeLabel;
@property (nonatomic, strong, readonly) UILabel *updateTimeLabel;
@property (nonatomic, strong, readonly) UILabel *weightLabel;
@property (nonatomic, strong, readonly) UILabel *contentLabel;

@property (nonatomic, strong, readonly) UIButton *rightButton;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<DPShowOrderTableViewCellDelegate> delegate;

//讲道理这应该写成Category
- (void)setupButtonTextWithDPOrderState:(DPOrderState)state;

@end
