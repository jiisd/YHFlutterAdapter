//
//  YHFlutterViewController.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterViewController.h"
#import "YHFlutterAdapter.h"
#import "YHFlutterChannelKey.h"

@interface YHFlutterViewController ()

@property (nonatomic, copy) NSString *pageIdentifier;

@end

@implementation YHFlutterViewController

#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        _pageIdentifier = [NSString stringWithFormat:@"%lu",(unsigned long)self.hash];
        
        UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        view.backgroundColor = [UIColor whiteColor];
        self.splashScreenView = view;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES];
    }
    
    [self sendPageState:kFlutterPageWillAppear];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self sendPageState:kFlutterPageDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self sendPageState:kFlutterPageWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self sendPageState:kFlutterPageDidDisappear];
}

#pragma mark - public method
- (void)syncPageArgumentToFlutter {
    [[YHFlutterAdapter methodChannelWithName:kYahengBaseFlutterBridgeChannelName] invokeMethod:kSyncPageArgumentToFlutter arguments:[self pageArguments]];
}

#pragma mark - private method
- (void)sendPageState:(NSString *)pageState {
    [[YHFlutterAdapter methodChannelWithName:kYahengBaseFlutterBridgeChannelName] invokeMethod:pageState arguments:[self pageArguments]];
}

- (NSDictionary *)pageArguments {
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithCapacity:2];
    dictM[@"pageIdentifier"] = self.pageIdentifier;
    dictM[@"pageName"]       = self.pageName;
    return [dictM copy];
}

@end
