//
//  DPHttpSessionManager.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPHttpSessionManager : NSObject

+ (instancetype)shareManager;


- (void)getRequestByUrl:(NSString *)url params:(NSDictionary *)params success:( void (^) (NSURLSessionDataTask *task, id data) )success
                failure:( void (^) (NSURLSessionDataTask *task, NSDictionary *error) )failure;
- (void)postRequestByUrl:(NSString *)url params:(NSDictionary *)params success:( void (^) (NSURLSessionDataTask *task, id data) )success
                 failure:( void (^) (NSURLSessionDataTask *task, NSDictionary *error) )failure;

@end
