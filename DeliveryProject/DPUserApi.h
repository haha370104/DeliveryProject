//
//  DPUserApi.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPUserApi : NSObject

+ (void)getSMSCode:(NSString *)phoneNum  complete:( void (^) (NSDictionary *response, BOOL success) )complete;

+ (void)registerWithPhoneNum:(NSString *)phoneNum smsCode:(NSString *)smsCode password:(NSString *)password name:(NSString *)name complete:( void (^) (NSDictionary *response, BOOL success) )complete;

+ (void)loginWithphoneNum:(NSString *)phoneNum password:(NSString *)password complete:( void (^) (NSDictionary *response) )complete;

+ (void)logoutWithComplete:( void (^) (NSDictionary *response) )complete;

+ (void)checkIfLoginWithLoginAction:( void (^) (NSDictionary *response) )loginAction notLoginAction:( void (^) (NSDictionary *response) )notLoginAction;

@end
