//
//  DPUser.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/22.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPUser : NSObject

@property (nonatomic, strong, readonly) NSString *userName;
@property (nonatomic, strong, readonly) NSString *userPhoneNum;

- (instancetype)initWithUserName:(NSString *)userName userPhoneNum:(NSString *)userPhoneNum;

@end
