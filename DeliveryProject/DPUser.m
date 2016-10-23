//
//  DPUser.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/22.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPUser.h"

@interface DPUser ()

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPhoneNum;

@end

@implementation DPUser

#pragma mark - init -
- (instancetype)initWithUserName:(NSString *)userName userPhoneNum:(NSString *)userPhoneNum
{
    self = [super init];
    if (self) {
        self.userName = userName;
        self.userPhoneNum = userPhoneNum;
    }
    return self;
}

@end
