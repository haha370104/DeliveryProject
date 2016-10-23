//
//  NSObject+DPOperation.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DPOperation)

- (BOOL)boolValueForKey:(NSString *)key;

- (NSString *)stringValueForKey:(NSString *)key;

- (NSArray *)arrayValueForKey:(NSString *)key;

- (NSDictionary *)dictionaryValueForKey:(NSString *)key;

- (NSNumber *)numberValueForKey:(NSString *)key;

- (NSUInteger)integerValueForKey:(NSString *)key;

@end
