//
//  ViewController.m
//  LHPerformanceStatusBar
//
//  Created by huangwenchen on 2016/12/26.
//  Copyright © 2016年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "LHPerformanceMonitorService.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentViewController:[TestViewController new] animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"走了主类的viewWillDisappear");
}
#pragma mark - notify
- (void)dealloc
{
    NSLog(@"走了 - %@", NSStringFromClass([self class]));
}

@end
