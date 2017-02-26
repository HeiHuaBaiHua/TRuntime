//
//  SomeObject.m
//  TTRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "SomeObject.h"

@interface SomeObject ()

@property (copy, nonatomic) NSString *name;

@end

@implementation SomeObject

- (void)dealloc {
    NSLog(@"dealloc: %@", self.name);
}

+ (instancetype)objectWithName:(NSString *)name {
    
    SomeObject *object = [SomeObject new];
    object.name = name;
    return object;
}

- (void)doAnything {
    NSLog(@"%@: doAnything", self.name);
}

- (void)doSomething {
    NSLog(@"%@: doSomething", self.name);
}

@end
