//
//  DPShowOrderController.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPOrder.h"

@interface DPShowOrderController : UIViewController

@property (nonatomic, strong, readonly) UITableView *tableView;

- (instancetype)initWithPackageArray:(NSArray<DPOrder *> *)packageArray;

@end
