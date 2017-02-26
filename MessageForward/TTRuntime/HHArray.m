//
//  HHArray.m
//  TTRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "HHArray.h"

typedef id ObjectType;

#define IfValidIndexReturn(action) return index < self.store.count ? [self.store action] : nil;

#define IfValidIndexPerform(action) if (index < self.store.count) {\
                                        [self.store action];\
                                    }

#define IfValidObjectAndIndexPerform(action) if (anObject != nil && index < self.store.count) { \
                            [self.store action]; \
                        }

@interface HHArray ()

@property (strong, nonatomic) NSMutableArray *store;

@end

@implementation HHArray

+ (NSMutableArray *)array {
    return [HHArray arrayWithArray:nil];
}

+ (NSMutableArray *)arrayWithArray:(NSArray *)arr {
    
    HHArray *array = (id)[super allocWithZone:NULL];
    return (id)[array initWithArray:arr] ;
}

- (instancetype)init {
    return [self initWithArray:nil];
}

- (instancetype)initWithArray:(NSArray *)array {
    
    self.store = [NSMutableArray array];
    [self.store addObjectsFromArray:array];
    return self;
}

#pragma mark - Override

- (ObjectType)objectAtIndex:(NSUInteger)index {
    IfValidIndexReturn(objectAtIndex:index);
}

- (ObjectType)objectAtIndexedSubscript:(NSUInteger)index {
    IfValidIndexReturn(objectAtIndexedSubscript:index);
}

- (void)addObject:(ObjectType)anObject {
    anObject == nil ?: [self.store addObject:anObject];
}

- (void)insertObject:(ObjectType)anObject atIndex:(NSUInteger)index {
    IfValidObjectAndIndexPerform(insertObject:anObject atIndex:index);
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    IfValidIndexPerform(removeObjectAtIndex:index);
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject {
    IfValidObjectAndIndexPerform(replaceObjectAtIndex:index withObject:anObject);
}

- (NSString *)description {
    
    NSMutableString *description = [NSMutableString string];
    [description appendString:@"( "];
    for (id object in self.store) {
        if (![object isMemberOfClass:[HHArray class]]) {
            [description appendString:[object description]];
            [description appendString:@" "];
        }
    }
    [description appendString:@")"];
    return description;
}

#pragma mark - Forward

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.store;
}

@end

