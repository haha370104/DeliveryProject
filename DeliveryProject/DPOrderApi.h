//
//  DPOrderApi.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/24.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPOrderApi : NSObject

+ (void)fetchConfirmOrderWithComplete:( void (^) (NSDictionary *response, BOOL success) )complete;

+ (void)fetchPassingOrderWithComplete:( void (^) (NSDictionary *response, BOOL success) )complete;

+ (void)fetchFinishedOrderWithComplete:( void (^) (NSDictionary *response, BOOL success) )complete;

@end
