//
//  DPApiUrls.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDPAPI_HOST @"http://ant-express.picfood.cn"

#pragma mark - 用户相关 -

#define kDPAPI_GET_SMS_CODE_URL @"/api/user/getSMSCode"
#define kDPAPI_REGISTER_URL @"/api/user/signup"
#define kDPAPI_LOGIN_URL @"/api/user/login"
#define kDPAPI_LOGOUT_URL @"/api/user/logout"
#define kDPAPI_CHECK_LOGIN_URL @"/api/user/test"

#pragma mark - 包裹相关 -

#define kDPAPI_SEARCH_PACKAGE_URL @"/api/parcel/path/search"
#define kDPAPI_CONFIRM_PACKAGE_URL @"/api/parcel/path/confirm"
#define kDPAPI_GET_ORDER @"/api/order"