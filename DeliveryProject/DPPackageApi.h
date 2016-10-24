//
//  DPPackageApi.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPPackageApi : NSObject

+ (void)searchPackageWithStartStation:(NSString *)startStation endStation:(NSString *)endStation complete:( void (^) (NSDictionary *response, BOOL success) )complete;

+ (void)confirmPackage:(NSString *)packageId complete:( void (^) (NSDictionary *response, BOOL success) )complete;

@end
