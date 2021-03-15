//
//  UIViewController+GSPerformanceNotify.h
//  LHPerformanceStatusBar
//
//  Created by 李磊涛 on 2021/3/12.
//  Copyright © 2021 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHPerformanceMonitorService.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GSPerformanceNotify)<GSFPSChangeDelegate>

@property (nonatomic, strong) NSMutableArray *FPS;
@property (nonatomic, strong) NSMutableArray *Memory;
@property (nonatomic, strong) NSMutableArray *CPU;

@end

NS_ASSUME_NONNULL_END
