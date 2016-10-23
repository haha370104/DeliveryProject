//
//  NSObject+DPTypeCheck_h.h
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DPTypeCheck_h)

// NSDictionary
- (id)dp_safeObjectForKey:(id)key;

// NSMutableDictionary
- (void)dp_setSafeObject:(id)object forSafeKey:(id)key;
- (void)dp_setSafeValue:(id)value forSafeKey:(NSString *)key;

- (void)dp_removeSafeObjectForKey:(id)key;

// NSArray
- (id)dp_safeObjectAtIndex:(NSUInteger)index;
- (id)dp_arrayByAddingSafeObject:(id)object;
- (NSArray *)dp_subarrayWithSafeRange:(NSRange)range;

// NSMutableArray
- (void)dp_addSafeObject:(id)object;
- (void)dp_removeSafeObjectAtIndex:(NSUInteger)index;
- (void)dp_replaceSafeObjectAtIndex:(NSUInteger)index withSafeObject:(id)object;
- (void)dp_removeSafeObject:(id)object;
- (BOOL)dp_containsSafeObject:(id)object;
- (NSUInteger)dp_indexOfSafeObject:(id)object;

// NSString
- (NSString *)dp_safeString:(NSString *)string;
- (NSString *)dp_emptyString:(NSString *)string;
- (NSString *)dp_stringByAppendingSafeString:(NSString *)string;
- (NSString *)dp_stringByReplacingOccurrencesOfSafeString:(NSString *)target withSafeString:(NSString *)replacement;

// NSArray
- (NSArray *)dp_safeArray:(NSArray *)array;

@end
