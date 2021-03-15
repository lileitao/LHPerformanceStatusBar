//
//  UIViewController+GSPerformanceNotify.m
//  LHPerformanceStatusBar
//
//  Created by 李磊涛 on 2021/3/12.
//  Copyright © 2021 Leo. All rights reserved.
//

#import "UIViewController+GSPerformanceNotify.h"
#import <objc/runtime.h>

static NSString *strKey = @"strKey";


@implementation UIViewController (GSPerformanceNotify)

#pragma mark - 交换方法
- (void)performanceViewDidAppear:(BOOL)animated {
    [self performanceViewDidAppear:animated];
    self.CPU = [NSMutableArray array];
    self.FPS = [NSMutableArray array];
    self.Memory = [NSMutableArray array];
    [LHPerformanceMonitorService runWithDelegate:self];
}

- (void)performanceViewWillDisappear:(BOOL)animated {
    [self performanceViewDidAppear:animated];
    NSString *fpsStr = [NSString stringWithFormat:@"%d", (int)[self averageFromArray:self.FPS]] ;
    NSString *memoryStr = [NSString stringWithFormat:@"%d", (int)[self averageFromArray:self.Memory]];
    NSString *cpuStr = [NSString stringWithFormat:@"%.2f%%", (float)[self averageFromArray:self.CPU]];
    NSDictionary *performanceDic = @{@"fpsStr":fpsStr, @"memoryStr":memoryStr, @"cpuStr":cpuStr};
        // 异步回调所有的性能，传输给大数据方面；
    NSLog(@"self.FPS = %@", self.FPS);
    if (self.FPS.count && self.Memory.count && self.CPU.count) {
        if ([self respondsToSelector:NSSelectorFromString(@"performanceNotifyWithDic:")]) {
            [self performSelector:NSSelectorFromString(@"performanceNotifyWithDic:") withObject:performanceDic];
        }
    }
}
// 求平均数
- (CGFloat)averageFromArray:(NSArray *)array {
    CGFloat sum = 0;
    for (NSNumber *tempNum in array) {
        sum += [tempNum floatValue];
    }
    return sum/array.count;
}

#pragma mark - 性能改变
- (void)changeWith:(CGFloat)FPS memory:(CGFloat)memory CPU:(CGFloat)cpu {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSNumber *fpsNum = @((int)FPS);
        NSNumber *memoryNum = @((int)memory);
        NSNumber *cpuNum = @(cpu);
        [self.FPS addObject:fpsNum];
        [self.Memory addObject:memoryNum];
        [self.CPU addObject:cpuNum];
    });
}



#pragma mark - load
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(performanceViewDidAppear:);
        [self exchangeInstanceMethod:[self class] method1Sel:originalSelector method2Sel:swizzledSelector];
        
        SEL originalSelector3 = @selector(viewWillDisappear:);
        SEL swizzledSelector3 = @selector(performanceViewWillDisappear:);
        [self exchangeInstanceMethod:[self class] method1Sel:originalSelector3 method2Sel:swizzledSelector3];
    });
}
+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    
    Method originalMethod = class_getInstanceMethod(anClass, method1Sel);
    Method swizzledMethod = class_getInstanceMethod(anClass, method2Sel);
    
    BOOL didAddMethod =
    class_addMethod(anClass,
                    method1Sel,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(anClass,
                            method2Sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}


#pragma mark - setter && getter
- (void)setFPS:(NSMutableArray *)FPS {
    objc_setAssociatedObject(self, @selector(FPS), FPS, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)FPS {
    return objc_getAssociatedObject(self, @selector(FPS));
}
- (void)setCPU:(NSMutableArray *)CPU {
    objc_setAssociatedObject(self, @selector(CPU), CPU, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)CPU {
    return objc_getAssociatedObject(self, @selector(CPU));
}
- (void)setMemory:(NSMutableArray *)Memory {
    objc_setAssociatedObject(self, @selector(Memory), Memory, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray *)Memory {
    return objc_getAssociatedObject(self, @selector(Memory));
}

@end
