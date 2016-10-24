//
//  DPOrder.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DPOrderState) {
    DPOrderConfirm,
    DPOrderPassing,
    DPOrderFinished,
};

@interface DPOrder : NSObject

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *startStation;
@property (nonatomic, copy) NSString *endStation;
@property (nonatomic, copy) NSString *packageWeight;
@property (nonatomic, copy) NSString *packageContent;

@property (nonatomic, assign) DPOrderState state;

@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *updateTime;

- (instancetype)initWithId:(NSString *)orderId startStation:(NSString *)startStation endStation:(NSString *)endStation packageWeight:(NSString *)packageWeight packageContent:(NSString *)packageContent createTime:(NSString *)createTime updateTime:(NSString *)updateTime orderState:(DPOrderState)orderState;

@end
