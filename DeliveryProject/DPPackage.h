//
//  DPPackage.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPPackage : NSObject

@property (nonatomic, copy, readonly) NSString *packageId;
@property (nonatomic, copy, readonly) NSString *startStation;
@property (nonatomic, copy, readonly) NSString *endStation;
@property (nonatomic, copy, readonly) NSString *packageWeight;
@property (nonatomic, copy, readonly) NSString *packageContent;

@property (nonatomic, strong, readonly) NSDate *createTime;

- (instancetype)initWithId:(NSString *)packageId startStation:(NSString *)startStation endStation:(NSString *)endStation packageWeight:(NSString *)packageWeight packageContent:(NSString *)packageContent createTime:(NSString *)createTime;

@end
