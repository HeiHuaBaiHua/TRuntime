//
//  SecondViewController.m
//  TTRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "Person.h"
#import "SecondViewController.h"

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    void (^addButton)(CGRect, NSString *, SEL) = ^(CGRect frame,NSString *title, SEL aFunction){
        
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor grayColor]];
        [button addTarget:self action:aFunction forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    };
    
    addButton(CGRectMake(100, 64, 100, 100), @"返回" ,@selector(back));
    addButton(CGRectMake(100, 200, 100, 100), @"点一下" ,@selector(doSomething));
}

#pragma mark - Action

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doSomething {
    
    [self aFunc];
    [self aFunc:1];
    [self aFunc1:@"xxx"];
    [self aFunc2:CGRectMake(0, 0, 123, 456)];
    [self aFunc3:CGSizeMake(123, 145)];
    [self aFunc4:CGPointMake(123, 87)];
    [self aFunc:2 objcet:CGRectMake(0, 0, 25, 25)];
    [self aFunc:123 frame:CGRectMake(16, 46, 789, 123) size:CGSizeMake(4645, 794) point:CGPointMake(456, 456) object:[[Person alloc] initWithName:@"xxx" age:123]];
}

#pragma mark - Utils

- (void)aFunc {
    NSLog(@"origin");
}

- (void)aFunc:(NSInteger)i {
    NSLog(@"origin: %ld",i);
}

- (void)aFunc1:(id)i {
    NSLog(@"origin: %@",i);
}

- (void)aFunc2:(CGRect)rect {
    NSLog(@"origin: %@",NSStringFromCGRect(rect));
}

- (void)aFunc3:(CGSize)size {
    NSLog(@"origin: %@",NSStringFromCGSize(size));
}

- (void)aFunc4:(CGPoint)point {
    NSLog(@"origin: %@",NSStringFromCGPoint(point));
}

- (void)aFunc:(NSInteger)i objcet:(CGRect)object {
    NSLog(@"origin: %ld-%@",i,NSStringFromCGRect(object));
}

- (void)aFunc:(NSInteger)i frame:(CGRect)frame size:(CGSize)size point:(CGPoint)point object:(id)object {
    NSLog(@"origin: %ld-%@-%@-%@-%@",i ,NSStringFromCGRect(frame), NSStringFromCGSize(size), NSStringFromCGPoint(point), object);
}

@end
