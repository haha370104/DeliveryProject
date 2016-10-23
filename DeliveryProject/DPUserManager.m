//
//  DPUserManager.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPUserManager.h"

@interface DPUserManager ()

@property (nonatomic, strong) DPUser *user;

@end

@implementation DPUserManager

+ (instancetype)shareManager
{
    static DPUserManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[DPUserManager alloc] init];
    });

    return _sharedManager;
}

- (void)setupWithPhoneNum:(NSString *)phoneNum userName:(NSString *)userName
{
    self.user = [[DPUser alloc] initWithUserName:userName userPhoneNum:phoneNum];
}

@end
