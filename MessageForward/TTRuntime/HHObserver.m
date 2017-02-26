//
//  HHObserver.m
//  THook
//
//  Created by HeiHuaBaiHua on 2016/12/29.
//  Copyright © 2016年 黑花白花. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>

#import "HHObserver.h"

@protocol HHObserver <NSObject>

+ (NSDictionary<NSString *,id> *)observeItems;
+ (void)object:(id)object didInvokeFunction:(NSString *)function withArguments:(NSArray *)arguments;
+ (void)object:(id)object willInvokeFunction:(NSString *)function withArguments:(NSArray *)arguments;

@end

@interface HHObserver()<HHObserver>
@end

@implementation HHObserver

static id _nilObject;

static SEL HHOriginSeletor(NSString *selecotrName) {
    return NSSelectorFromString([NSString stringWithFormat:@"HH_ORIGIN%@",selecotrName]);
}

static NSString *extractStructName(NSString *typeEncodeString) {
    NSArray *array = [typeEncodeString componentsSeparatedByString:@"="];
    NSString *typeString = array[0];
    int firstValidIndex = 0;
    for (int i = 0; i< typeString.length; i++) {
        char c = [typeString characterAtIndex:i];
        if (c == '{' || c=='_') {
            firstValidIndex++;
        }else {
            break;
        }
    }
    return [typeString substringFromIndex:firstValidIndex];
}

static void HHForwardInvocation(__unsafe_unretained id target, SEL selector, NSInvocation *invocation) {
    
    NSMutableArray *arguments = [NSMutableArray array];
    NSMethodSignature *methodSignature = [invocation methodSignature];
    for (NSUInteger i = 2; i < methodSignature.numberOfArguments; i++) {
        const char *argumentType = [methodSignature getArgumentTypeAtIndex:i];
        switch(argumentType[0] == 'r' ? argumentType[1] : argumentType[0]) {
                
                #define HH_FWD_ARG_CASE(_typeChar, _type) \
                case _typeChar: {   \
                _type argument;  \
                [invocation getArgument:&argument atIndex:i];    \
                [arguments addObject:@(argument)]; \
                break;  \
                }
                HH_FWD_ARG_CASE('c', char)
                HH_FWD_ARG_CASE('C', unsigned char)
                HH_FWD_ARG_CASE('s', short)
                HH_FWD_ARG_CASE('S', unsigned short)
                HH_FWD_ARG_CASE('i', int)
                HH_FWD_ARG_CASE('I', unsigned int)
                HH_FWD_ARG_CASE('l', long)
                HH_FWD_ARG_CASE('L', unsigned long)
                HH_FWD_ARG_CASE('q', long long)
                HH_FWD_ARG_CASE('Q', unsigned long long)
                HH_FWD_ARG_CASE('f', float)
                HH_FWD_ARG_CASE('d', double)
                HH_FWD_ARG_CASE('B', BOOL)
            case '@': {
                __unsafe_unretained id argument;
                [invocation getArgument:&argument atIndex:i];
                if ([argument isKindOfClass:NSClassFromString(@"NSBlock")]) {
                    [arguments addObject:(argument ? [argument copy] : _nilObject)];
                } else {
                    [arguments addObject:(argument ? argument : _nilObject)];
                }
            }   break;
            case '{': {
                #define HH_FWD_ARG_STRUCT(_type) \
                if (typeString.length > 0) { \
                _type argument; \
                [invocation getArgument:&argument atIndex:i]; \
                value = [NSValue valueWith##_type:argument]; \
                } \

                NSValue *value;
                NSString *typeString = extractStructName([NSString stringWithUTF8String:argumentType]);
                if ([typeString isEqualToString:@"CGRect"]) {
                    HH_FWD_ARG_STRUCT(CGRect)
                } else if ([typeString isEqualToString:@"CGSize"]) {
                    HH_FWD_ARG_STRUCT(CGSize)
                } else if ([typeString isEqualToString:@"CGPoint"]) {
                    HH_FWD_ARG_STRUCT(CGPoint)
                } else if ([typeString isEqualToString:@"NSRange"]) {
                    NSRange argument;
                    [invocation getArgument:&argument atIndex:i];
                    value = [NSValue valueWithRange:argument];
                }
                [arguments addObject:value ?: _nilObject];
            }   break;
            case ':': {
                SEL selector;
                [invocation getArgument:&selector atIndex:i];
                NSString *selectorName = NSStringFromSelector(selector);
                [arguments addObject:(selectorName ? selectorName: _nilObject)];
                break;
            }
            case '^':
            case '*': {
                void *argument;
                [invocation getArgument:&argument atIndex:i];
                [arguments addObject:(__bridge id)argument];
            }    break;
            case '#': {
                Class argument;
                [invocation getArgument:&argument atIndex:i];
                [arguments addObject:argument];
            }   break;
            default: {
                NSLog(@"error type %s", argumentType);
            }   break;
        }
    }
    
    NSString *selectorName = NSStringFromSelector(invocation.selector);
    if ([selectorName hasPrefix:@"ORIG"]) { selectorName = [selectorName substringFromIndex:4]; }
    [HHObserver object:target willInvokeFunction:selectorName withArguments:arguments];
    [invocation setSelector:HHOriginSeletor(selectorName)];
    [invocation invoke];
    [HHObserver object:target didInvokeFunction:selectorName withArguments:arguments];
    
}

#pragma mark - Load

+ (void)load {
    
    _nilObject = [NSObject new];
    [[self observeItems] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull className, id _Nonnull selectors, BOOL * _Nonnull stop) {
        
        Class cls = NSClassFromString(className);
        if ([selectors isKindOfClass:[NSString class]]) {
            [self replaceClass:cls function:selectors];
        } else if ([selectors isKindOfClass:[NSArray class]]) {
            
            for (NSString *selectorName in selectors) {
                [self replaceClass:cls function:selectorName];
            }
        }
    }];
}

+ (void)replaceClass:(Class)cls function:(NSString *)selectorName {
    
    SEL selector = NSSelectorFromString(selectorName);
    SEL forwardSelector = HHOriginSeletor(selectorName);
    Method method = class_getInstanceMethod(cls, selector);
    if (method != nil) {
        
        IMP msgForwardIMP = _objc_msgForward;
#if !defined(__arm64__)
        if (typeDescription[0] == '{') {
            NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:typeDescription];
            if ([methodSignature.debugDescription rangeOfString:@"is special struct return? YES"].location != NSNotFound) {
                msgForwardIMP = (IMP)_objc_msgForward_stret;
            }
        }
#endif
        IMP originIMP = class_replaceMethod(cls, selector , msgForwardIMP, method_getTypeEncoding(method));
        class_addMethod(cls, forwardSelector, originIMP, method_getTypeEncoding(method));
        class_replaceMethod(cls, @selector(forwardInvocation:), (IMP)HHForwardInvocation, "v@:@");
    }
}

#pragma mark - HHObserver

+ (NSDictionary<NSString *,id > *)observeItems {
    return @{@"UIControl" : @"sendAction:to:forEvent:",
             
             @"Person" : @"personFunc:",
             
             @"SecondViewController" : @[@"aFunc",
                                         @"aFunc:",
                                         @"aFunc1:",
                                         @"aFunc2:",
                                         @"aFunc3:",
                                         @"aFunc4:",
                                         @"aFunc:objcet:",
                                         @"aFunc:frame:size:point:object:",
                                         @"dasidsadbisaidsabidsbaibdsai"]};
}

+ (void)object:(id)object willInvokeFunction:(NSString *)function withArguments:(NSArray *)arguments {
    NSLog(@"\n--------------------\nobject: %@\nwillInvokeFunction: %@\nwithArguments: %@\n--------------------",object, function, arguments);
}

+ (void)object:(id)object didInvokeFunction:(NSString *)function withArguments:(NSArray *)arguments {
    NSLog(@"\n--------------------\nobject: %@\ndidInvokeFunction: %@\nwithArguments: %@\n--------------------",object, function, arguments);
}

@end
