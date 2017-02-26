//
//  Person.m
//  TTRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    if (self = [super init]) {
        self.age = age;
        self.name = name;
        
        [self personFunc:@"什么事没什么"];
    }
    return self;
}

- (void)personFunc:(NSString *)xxx {
    NSLog(@"personFunc--%@",xxx);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Person: name(%@) age(%ld)",self.name,self.age];
}

@end
