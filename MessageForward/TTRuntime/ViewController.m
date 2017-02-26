//
//  ViewController.m
//  TTRuntime
//
//  Created by 黑花白花 on 2017/2/25.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "ViewController.h"

#import "HHArray.h"

#import "HHNotifier.h"
#import "SomeObject.h"

#import "SecondViewController.h"

@interface ViewControllerNotifier : HHNotifier<ViewController>
@end
@implementation ViewControllerNotifier
@end

@interface ViewController ()
@property (strong, nonatomic) ViewControllerNotifier *observers;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Action

- (IBAction)TNull:(UIButton *)sender {
    
    id null = [NSNull null];
    NSLog(@"%ld", [null count]);
    NSLog(@"%ld", [null length]);
    NSLog(@"%ld", [null integerValue]);
}

- (IBAction)THook:(UIButton *)sender {
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}

- (IBAction)TArray:(UIButton *)sender {
    
    NSMutableArray *array = [HHArray array];
    [array addObject:@1];
    [array addObject:@2];
    [array addObject:@4];
    [array addObjectsFromArray:@[@6, @8]];
    [array addObject:nil];
    NSLog(@"%@", array);
    NSLog(@"count: %ld", array.count);
    
    [array removeLastObject];
    NSLog(@"%@", array);
    
    [array removeObjectAtIndex:7];
    NSLog(@"%@", array);
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"e %@", obj);
    }];
    
    for (id x in array) {
        NSLog(@"- %@", x);
    }
    
    for (int i = 0; i < 10; i++) {
        NSLog(@"~ %@", [array objectAtIndex:i]);
    }
    
    for (int i = 0; i < 10; i++) {
        NSLog(@"_ %@", array[i]);
    }
}

- (IBAction)TNotifier:(UIButton *)sender {
    
    if (!self.observers) { self.observers = [ViewControllerNotifier notifier]; }
    NSMutableArray *holder = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        
        SomeObject *object = [SomeObject objectWithName:[NSString stringWithFormat:@"objcet%d", i]];
        [holder addObject:object];
        [self.observers addObserver:object];
    }
    
    [self.observers addObserver:self];
    HHNotifObservers(doAnything);
    HHNotifObservers(doSomething);
    [holder removeAllObjects];
}

@end
