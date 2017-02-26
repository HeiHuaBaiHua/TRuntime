//
//  NSArray+SafeArray.m
//  TTRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import <objc/runtime.h>
#import "NSArray+SafeArray.h"

@implementation NSArray (SafeArray)

+ (void)load {
    
    Method originMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method swizzleMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(swizzleObjectAtIndex:));
    method_exchangeImplementations(originMethod, swizzleMethod);
}

- (id)swizzleObjectAtIndex:(NSUInteger)index {
//    NSLog(@"1");
    return index < self.count ? [self swizzleObjectAtIndex:index] : nil;
}

@end
