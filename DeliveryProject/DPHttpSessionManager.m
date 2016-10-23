//
//  DPHttpSessionManager.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPHttpSessionManager.h"
#import "AFNetworking.h"
#import "MBProgressHUD+DPProgressHUD.h"

@interface DPHttpSessionManager ()

@property (nonatomic, strong) AFHTTPSessionManager *session;

@end

@implementation DPHttpSessionManager

#pragma mark - public -

+ (instancetype)shareManager
{
    static DPHttpSessionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[DPHttpSessionManager alloc] init];
    });

    return _sharedManager;
}

#pragma mark - private -

- (void)getRequestByUrl:(NSString *)url params:(NSDictionary *)params success:( void (^) (NSURLSessionDataTask *task, id data) )success
                failure:( void (^) (NSURLSessionDataTask *task, NSError *error) )failure
{
    __block MBProgressHUD *loadingView;
    [self.session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        loadingView = [MBProgressHUD showLoadingState:@"加载中" inView:nil inBackground:NO];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [loadingView removeFromSuperview];
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [loadingView removeFromSuperview];
        if (failure) {
            failure(task, error);
        }
    }];
}

- (void)postRequestByUrl:(NSString *)url params:(NSDictionary *)params success:( void (^) (NSURLSessionDataTask *task, id data) )success
                 failure:( void (^) (NSURLSessionDataTask *task, NSError *error) )failure
{
    __block MBProgressHUD *loadingView;
    [self.session POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        loadingView = [MBProgressHUD showLoadingState:@"加载中" inView:nil inBackground:NO];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [loadingView removeFromSuperview];
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [loadingView removeFromSuperview];
        if (failure) {
            failure(task, error);
        }
    }];
}

#pragma mark - getter && setter -

- (AFHTTPSessionManager *)session
{
    if (!_session) {
        _session = [AFHTTPSessionManager manager];
        _session.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _session;
}

@end
