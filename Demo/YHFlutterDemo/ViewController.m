//
//  ViewController.m
//  YHFlutterDemo
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "ViewController.h"
#import <YHFlutterAdapter/YHFlutterModule.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 在对应的项目内选择合适的时机调用该方法，可在方法内提前注册部分服务
    [YHFlutterModule setup];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    button.center = self.view.center;
    [button setTitle:@"Present Flutter page" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.titleLabel.font = [UIFont systemFontOfSize:25];
    [button addTarget:self
               action:@selector(openFlutterPage)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)openFlutterPage {
    // 加载 Flutter 界面的两种方式
 
    // 1. 直接显示的调用 YHFlutterModule 加载 Flutter 界面(如下)
    UIViewController *flutterViewController = [[YHFlutterModule service] flutterViewControllerForKey:@"yh_demo_page" properties:nil];
    [self presentViewController:flutterViewController animated:YES completion:nil];
    
    // 2. 项目中若已有组件化的方案在使用，可在合适的时机将 YHFlutterModule 注册进相关的组件服务内，通过调用 YHFlutterServiceProtocol 的相关方法加载 Flutter 界面
}

@end
