//
//  NSObject+DataMerge.h
//  OneToSay
//
//  Created by HeiHuaBaiHua on 16/7/6.
//  Copyright © 2016年 Excetop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DataMerge)

- (instancetype)deepCopy;

+ (instancetype)instanceWithObject:(id)object;
+ (instancetype)instanceWithObject:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties;
+ (instancetype)instanceWithObject:(id)object mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues;
+ (instancetype)instanceWithObject:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues;

- (void)setupWithObject:(id)object;
- (void)setupWithObject:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties;
- (void)setupWithObject:(id)object mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues;
- (void)setupWithObject:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues;
@end


