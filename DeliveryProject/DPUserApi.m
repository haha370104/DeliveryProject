//
//  DPUserApi.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPUserApi.h"
#import "DPHttpSessionManager.h"
#import "DPApiUrls.h"

#import "MBProgressHUD+DPProgressHUD.h"

@implementation DPUserApi

+ (void)getSMSCode:(NSString *)phoneNum  complete:( void (^) (NSDictionary *response) )complete
{
    [[DPHttpSessionManager shareManager] getRequestByUrl:kDPAPI_GET_SMS_CODE_URL params:@{@"mobile":phoneNum} success:^(NSURLSessionDataTask *task, id data) {
        complete(data);
    } failure:nil];
}

+ (void)registerWithPhoneNum:(NSString *)phoneNum smsCode:(NSString *)smsCode password:(NSString *)password name:(NSString *)name complete:( void (^) (NSDictionary *response) )complete
{
    
}

+ (void)loginWithphoneNum:(NSString *)phoneNum password:(NSString *)password complete:( void (^) (NSDictionary *response) )complete
{
    [[DPHttpSessionManager shareManager] postRequestByUrl:kDPAPI_LOGIN_URL params:@{@"mobile":phoneNum, @"password":password} success:^(NSURLSessionDataTask *task, id data) {
        NSAssert([data isKindOfClass:[NSDictionary class]],@"response is not kind of dictionary");
        complete(data);
    } failure:^(NSURLSessionDataTask *task, NSString *errorReason) {
        [MBProgressHUD showErrorState:errorReason inView:nil];
    }];
}

+ (void)logoutWithComplete:( void (^) (NSDictionary *response) )complete
{
    
}

+ (void)checkIfLoginWithComplete:( void (^) (NSDictionary *response) )complete
{

}

@end
