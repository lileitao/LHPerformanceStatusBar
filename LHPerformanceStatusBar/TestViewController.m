//
//  TestViewController.m
//  LHPerformanceStatusBar
//
//  Created by 李磊涛 on 2021/3/12.
//  Copyright © 2021 Leo. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"走了 - %@", NSStringFromClass([self class]));
}

@end
