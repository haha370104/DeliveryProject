//
//  DPOrderApi.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPOrderApi.h"
#import "DPApiUrls.h"
#import "DPHttpSessionManager.h"

#import "MBProgressHUD+DPProgressHUD.h"
#import "NSObject+DPTypeCheck.h"

@implementation DPOrderApi

+ (void)fetchConfirmOrderWithComplete:( void (^) (NSDictionary *response, BOOL success) )complete
{
    [[DPHttpSessionManager shareManager] getRequestByUrl:kDPAPI_GET_CONFIRM_ORDER_URL params:nil success:^(NSURLSessionDataTask *task, id data) {
        if (complete) {
            complete(data, YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSDictionary *error) {
        if (complete) {
            complete(error, NO);
        }
    }];
}

+ (void)fetchPassingOrderWithComplete:( void (^) (NSDictionary *response, BOOL success) )complete
{
    [[DPHttpSessionManager shareManager] getRequestByUrl:kDPAPI_GET_PASSING_ORDER_URL params:nil success:^(NSURLSessionDataTask *task, id data) {
        if (complete) {
            complete(data, YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSDictionary *error) {
        if (complete) {
            complete(error, NO);
        }
    }];
}

+ (void)fetchFinishedOrderWithComplete:( void (^) (NSDictionary *response, BOOL success) )complete
{
    [[DPHttpSessionManager shareManager] getRequestByUrl:kDPAPI_GET_FINISHED_ORDER_URL params:nil success:^(NSURLSessionDataTask *task, id data) {
        if (complete) {
            complete(data, YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSDictionary *error) {
        if (complete) {
            complete(error, NO);
        }
    }];
}

@end
