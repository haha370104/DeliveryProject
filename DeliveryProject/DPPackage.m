//
//  DPPackage.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPPackage.h"

@interface DPPackage ()

@property (nonatomic, copy) NSString *packageId;
@property (nonatomic, copy) NSString *startStation;
@property (nonatomic, copy) NSString *endStation;
@property (nonatomic, copy) NSString *packageWeight;
@property (nonatomic, copy) NSString *packageContent;

@property (nonatomic, strong) NSDate *createTime;

@end

@implementation DPPackage

- (instancetype)initWithId:(NSString *)packageId startStation:(NSString *)startStation endStation:(NSString *)endStation packageWeight:(NSString *)packageWeight packageContent:(NSString *)packageContent createTime:(NSString *)createTime
{
    self = [super init];
    if (self) {
        self.packageId = packageId;
        self.startStation = startStation;
        self.endStation = endStation;
        self.packageWeight = packageWeight;
        self.packageContent = packageContent;

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
        self.createTime = [formatter dateFromString:createTime];
    }
    return self;
}

@end
