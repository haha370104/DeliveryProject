//
//  DPPackageApi.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPPackageApi.h"
#import "DPApiUrls.h"
#import "DPHttpSessionManager.h"

#import "MBProgressHUD+DPProgressHUD.h"
#import "NSObject+DPTypeCheck.h"

@implementation DPPackageApi

+ (void)searchPackageWithStartStation:(NSString *)startStation endStation:(NSString *)endStation complete:( void (^) (NSDictionary *response, BOOL success) )complete
{
    [[DPHttpSessionManager shareManager] getRequestByUrl:kDPAPI_SEARCH_PACKAGE_URL params:@{@"start":startStation, @"end":endStation} success:^(NSURLSessionDataTask *task, id data) {
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
