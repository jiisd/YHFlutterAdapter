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
    
    // 在对应的项目内选择合适的时间点掉用该方法，可在方法内提前注册部分服务
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
    // 项目中若有组件化的方案，
    // 可在合适的时机内将 YHFlutterModule 注册进对应的组件服务内，来调用 YHFlutterServiceProtocol 对应的方法
    // 就不需要直接显示的调用 YHFlutterModule 来加载 Flutter 界面了
    UIViewController *flutterViewController = [[YHFlutterModule service] flutterViewControllerForKey:@"yh_demo_page" properties:nil];
    [self presentViewController:flutterViewController animated:YES completion:nil];
    
}

@end
