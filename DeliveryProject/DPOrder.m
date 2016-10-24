//
//  DPOrder.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPOrder.h"

@interface DPOrder ()

@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *startStation;
@property (nonatomic, copy) NSString *endStation;
@property (nonatomic, copy) NSString *packageWeight;
@property (nonatomic, copy) NSString *packageContent;
@property (nonatomic, copy) NSString *token;

@property (nonatomic, assign) DPOrderState state;

@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *updateTime;
@end

@implementation DPOrder

- (instancetype)initWithId:(NSString *)orderId startStation:(NSString *)startStation endStation:(NSString *)endStation packageWeight:(NSString *)packageWeight packageContent:(NSString *)packageContent createTime:(NSString *)createTime updateTime:(NSString *)updateTime orderState:(DPOrderState)orderState token:(NSString *)token
{
    self = [super init];
    if (self) {
        self.orderId = orderId;
        self.startStation = startStation;
        self.endStation = endStation;
        self.packageWeight = packageWeight;
        self.packageContent = packageContent;

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
        self.createTime = [formatter dateFromString:createTime];
        self.updateTime = [formatter dateFromString:updateTime];

        self.state = orderState;

        self.token = token;
    }
    return self;
}

@end
