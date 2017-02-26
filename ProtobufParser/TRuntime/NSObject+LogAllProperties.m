//
//  NSObject+LogAllProperties.m
//  TCoreData
//
//  Created by HeiHuaBaiHua on 16/6/17.
//  Copyright © 2016年 黑花白花. All rights reserved.
//

#import "NSObject+LogAllProperties.h"

#import <objc/runtime.h>
@implementation NSObject (LogAllProperties)

- (void)log {
    
    NSMutableString *description = [NSMutableString stringWithString:@"\n-------------------------------------\n"];
    [description appendString:[NSString stringWithFormat:@"%@ :\n",NSStringFromClass([self class])]];
    Class cls = [self class];
    while (cls != [NSObject class]) {
        [description appendString:[self classPropertiesDescriptionWithClass:cls]];
        cls = [cls superclass];
    }
    [description appendString:@"-------------------------------------"];
    NSLog(@"%@",description);
    
}

- (NSString *)classPropertiesDescriptionWithClass:(Class)cls {
    
    NSMutableString *description = [NSMutableString string];
    uint count;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        if ([propertyName isEqualToString:@"debugDescription"] ||
            [propertyName isEqualToString:@"description"] ||
            [propertyName isEqualToString:@"superclass"] ||
            [propertyName isEqualToString:@"hash"]) {
            continue;
        }
        
        id propertyValue = [self valueForKey:propertyName];
        [description appendString:[NSString stringWithFormat:@"  %@ : %@\n",propertyName,propertyValue]];
    }
    free(properties);
    return [description copy];
}

@end
