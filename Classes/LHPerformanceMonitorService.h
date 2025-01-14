//
//  QTFPSMonitor.h
//  
//
//  Created by Leo on 2016/12/26.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LHPerformanceTypes.h"
@class LHPerformanceConfig;

@protocol GSFPSChangeDelegate <NSObject>

- (void)changeWith:(CGFloat)FPS memory:(CGFloat)memory CPU:(CGFloat)cpu;

@end

/**
  Run this service will create a window above status to show FPS,CPU and Memory usage.
 */
@interface LHPerformanceMonitorService : NSObject

@property (nonatomic, weak) id <GSFPSChangeDelegate> delegate;

+ (void)run;

+ (void)runWithDelegate:(id <GSFPSChangeDelegate>)delegate;

+ (void)stop;

+ (void)setTextColor:(UIColor *)textColor forState:(LHPerformanceLabelState)state;

+ (void)setConfig:(LHPerformanceConfig *)config forAttribte:(LHPerformanceMonitorAttributes)attribtue;
@end
