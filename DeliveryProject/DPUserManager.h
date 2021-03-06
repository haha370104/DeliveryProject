//
//  DPUserManager.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPUser.h"

@interface DPUserManager : NSObject

@property (nonatomic, strong, readonly) DPUser *user;

+ (instancetype)shareManager;

- (void)setupWithPhoneNum:(NSString *)phoneNum userName:(NSString *)userName;

@end
