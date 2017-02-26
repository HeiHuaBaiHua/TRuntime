//
//  NSObject+DataMerge.m
//  OneToSay
//
//  Created by HeiHuaBaiHua on 16/7/6.
//  Copyright © 2016年 Excetop. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>

#import "HHClassInfo.h"
#import "NSObject+DataMerge.h"

#define DefaultIgonreProperties @[@"debugDescription", @"description", @"superclass", @"hash"]

@implementation NSObject (DataMerge)

#pragma mark - Getter

static dispatch_semaphore_t lock;
+ (NSMutableDictionary<Class, NSMutableArray *> *)dataMergeProperties {
    
    static NSMutableDictionary *properties;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = dispatch_semaphore_create(1);
        properties = [NSMutableDictionary dictionary];
    });
    return properties;
}

#pragma mark - deepCopy

- (instancetype)deepCopy {
    
    if ([self isKindOfClass:[NSSet class]]) {
        return [NSSet setWithArray:[[(NSSet *)self allObjects] deepCopy]];;
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *copy = [NSMutableArray array];
        for (id item in (NSArray *)self) {
            [copy addObject:[item deepCopy]];
        }
        return copy;
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        
        NSMutableDictionary *copy = [NSMutableDictionary dictionary];
        [(NSDictionary *)self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [copy setObject:[obj deepCopy] forKey:key];
        }];
        return copy;
    }
    
    return [[self class] instanceWithObject:self];
}

#pragma mark - DataMerge

+ (instancetype)instanceWithObject:(id)object {
    return [self instanceWithObject:object igonreProperties:nil mapKeyValues:nil];
}

+ (instancetype)instanceWithObject:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties {
    return [self instanceWithObject:object igonreProperties:igonreProperties mapKeyValues:nil];
}

+ (instancetype)instanceWithObject:(id)object mapKeyValues:(NSDictionary<NSString *,NSString *> *)mapKeyValues {
    return [self instanceWithObject:object igonreProperties:nil mapKeyValues:mapKeyValues];
}

+ (instancetype)instanceWithObject:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties mapKeyValues:(NSDictionary<NSString *,NSString *> *)mapKeyValues {
    
    if (object == nil) { return nil; }
    
    id instance = [self new];
    [instance setupWithObject:object igonreProperties:igonreProperties mapKeyValues:mapKeyValues];
    return instance;
}

- (void)setupWithObject:(id)object {
    [self setupWithObject:object igonreProperties:nil mapKeyValues:nil];
}

- (void)setupWithObject:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties {
    [self setupWithObject:object igonreProperties:igonreProperties mapKeyValues:nil];
}

- (void)setupWithObject:(id)object mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues {
    [self setupWithObject:object igonreProperties:nil mapKeyValues:mapKeyValues];
}

- (void)setupWithObject:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues {
    if (object == nil) { return ; }
    
    Class cls = [self class];
    NSMutableArray *properties = NSObject.dataMergeProperties[cls];
    if (properties != nil) {
        
        for (HHPropertyInfo *property in properties) {
            [self setValueWithProperty:property object:object igonreProperties:igonreProperties mapKeyValues:mapKeyValues];
        }
    } else {
        
        properties = [NSMutableArray array];
        while (cls != [NSObject class] && cls != [NSProxy class]) {
            
            unsigned int propertyCount = 0;
            objc_property_t *classProperties = class_copyPropertyList(cls, &propertyCount);
            for (int i = 0; i < propertyCount; i++) {
                
                HHPropertyInfo *property = [HHPropertyInfo propertyWithProperty:(classProperties[i])];
                [properties addObject:property];
                [self setValueWithProperty:property object:object igonreProperties:igonreProperties mapKeyValues:mapKeyValues];
            }
            free(classProperties);
            
            cls = [cls superclass];
        }
        
        if (properties.count > 0) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            [NSObject.dataMergeProperties setObject:properties forKey:(id)[self class]];
            dispatch_semaphore_signal(lock);
        }
    }
}

#pragma mark - Utils

- (BOOL)isValidValue:(id)value {
    
    if (  value == nil ||
        ([value isKindOfClass:[NSSet class]] && [value count] == 0) ||
        ([value isKindOfClass:[NSArray class]] && [value count] == 0) ||
        ([value isKindOfClass:[NSString class]] && [value length] == 0) ||
        ([value isKindOfClass:[NSNumber class]] && [value integerValue] == 0) ||
        ([value isKindOfClass:[NSDictionary class]] && [value count] == 0) ) {
        return NO;
    }
    return YES;
}

- (void)setValueWithProperty:(HHPropertyInfo *)property object:(id)object igonreProperties:(NSArray<NSString *> *)igonreProperties mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues {
    
    if ([igonreProperties containsObject:property->_name]) { return; }
    
    NSString *getPath = mapKeyValues[property->_name] ?: property->_name;
    if ([object respondsToSelector:NSSelectorFromString(getPath)]) {
        
        id propertyValue = [object valueForKey:getPath];
        if ([self isValidValue:propertyValue]) {
            
            HHPropertyType type = property->_type;
            switch (type) {
                case HHPropertyTypeBool:
                case HHPropertyTypeInt8: {
                    
                    if ([propertyValue respondsToSelector:@selector(boolValue)]) {
                        ((void (*)(id, SEL, bool))(void *) objc_msgSend)(self, property->_setter, [propertyValue boolValue]);
                    }
                }   break;
                    
                case HHPropertyTypeInt32:
                case HHPropertyTypeUInt32: {
                    
                    if ([propertyValue respondsToSelector:@selector(intValue)]) {
                        ((void (*)(id, SEL, int))(void *) objc_msgSend)(self, property->_setter, [propertyValue intValue]);
                    }
                }   break;
                    
                case HHPropertyTypeInt64:
                case HHPropertyTypeUInt64: {
                    
                    if ([propertyValue respondsToSelector:@selector(longValue)]) {
                        ((void (*)(id, SEL, long))(void *) objc_msgSend)(self, property->_setter, [propertyValue longValue]);
                    }
                }   break;
                    
                case HHPropertyTypeFloat: {
                    
                    if ([propertyValue respondsToSelector:@selector(floatValue)]) {
                        ((void (*)(id, SEL, float))(void *) objc_msgSend)(self, property->_setter, [propertyValue floatValue]);
                    }
                }   break;
                    
                case HHPropertyTypeDouble: {
                    
                    if ([propertyValue respondsToSelector:@selector(doubleValue)]) {
                        ((void (*)(id, SEL, double))(void *) objc_msgSend)(self, property->_setter, [propertyValue doubleValue]);
                    }
                }   break;
                    
                case HHPropertyTypeCustomObject: {
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)(self, property->_setter, [property->_cls instanceWithObject:propertyValue]);
                }   break;
                    
                default: {
                    ((void (*)(id, SEL, id))(void *) objc_msgSend)(self, property->_setter, propertyValue);
                }   break;
            }
        }
    }
}

@end



