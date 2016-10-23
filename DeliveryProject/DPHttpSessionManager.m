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

#import "DPApiUrls.h"

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

#pragma mark - public -

- (void)getRequestByUrl:(NSString *)url params:(NSDictionary *)params success:( void (^) (NSURLSessionDataTask *task, id data) )success
                failure:( void (^) (NSURLSessionDataTask *task, NSString *errorReason) )failure
{
    MBProgressHUD *loadingView = [MBProgressHUD showLoadingState:@"加载中..." inView:nil inBackground:NO];
    __weak typeof(loadingView) weadHud = loadingView;
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",kDPAPI_HOST,url];
    [self.session GET:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weadHud hide:YES];
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weadHud hide:YES];
        if (failure) {
            NSData* responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
            if (dictionary && [dictionary objectForKey:@"error"]) {
                failure(task, [dictionary objectForKey:@"error"]);
            } else {
                [MBProgressHUD showErrorState:@"网络错误" inView:nil];
            }
        } else {
            [MBProgressHUD showErrorState:@"未知错误" inView:nil];
        }
    }];
}

- (void)postRequestByUrl:(NSString *)url params:(NSDictionary *)params success:( void (^) (NSURLSessionDataTask *task, id data) )success
                 failure:( void (^) (NSURLSessionDataTask *task, NSString *errorReason) )failure
{
    MBProgressHUD *loadingView = [MBProgressHUD showLoadingState:@"加载中..." inView:nil inBackground:NO];
    __weak typeof(loadingView) weadHud = loadingView;
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",kDPAPI_HOST,url];
    [self.session POST:requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weadHud hide:YES];
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weadHud hide:YES];
        if (failure) {
            NSData* responseData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
            if (dictionary && [dictionary objectForKey:@"error"]) {
                failure(task, [dictionary objectForKey:@"error"]);
            } else {
                [MBProgressHUD showErrorState:@"网络错误" inView:nil];
            }
        } else {
            [MBProgressHUD showErrorState:@"未知错误" inView:nil];
        }
    }];
}

#pragma mark - getter && setter -

- (AFHTTPSessionManager *)session
{
    if (!_session) {
        _session = [AFHTTPSessionManager manager];
        _session.responseSerializer = [AFJSONResponseSerializer serializer];
        [_session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return _session;
}

@end
