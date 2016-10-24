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

@property (nonatomic, copy, readonly) NSString *orderId;
@property (nonatomic, copy, readonly) NSString *startStation;
@property (nonatomic, copy, readonly) NSString *endStation;
@property (nonatomic, copy, readonly) NSString *packageWeight;
@property (nonatomic, copy, readonly) NSString *packageContent;
@property (nonatomic, copy, readonly) NSString *token;

@property (nonatomic, assign, readonly) DPOrderState state;

@property (nonatomic, strong, readonly) NSDate *createTime;
@property (nonatomic, strong, readonly) NSDate *updateTime;

- (instancetype)initWithId:(NSString *)orderId startStation:(NSString *)startStation endStation:(NSString *)endStation packageWeight:(NSString *)packageWeight packageContent:(NSString *)packageContent createTime:(NSString *)createTime updateTime:(NSString *)updateTime orderState:(DPOrderState)orderState token:(NSString *)token;

@end
