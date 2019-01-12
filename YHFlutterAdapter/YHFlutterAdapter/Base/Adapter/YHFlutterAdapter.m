//
//  YHFlutterAdapter.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterAdapter.h"
#import "YHFlutterViewController.h"
#import "YHFlutterDefine.h"
#import "YHFlutterMessageDispatcher.h"

/// 当前 FlutterViewController 被设计的目的主要是为了实现一个全局完整的 APP，多次实例化，目前会存在一定的内存问题；
/// 在该问题解决之前我们先只使用同一个 ViewController 来承载不同的业务界面；
/// 在 Flutter 界面不再显示的时候需要考虑是否需要卸载掉当前界面的 Widget，进一步降低其内存占用；
static YHFlutterViewController                  *_flutterViewController;

@implementation YHFlutterAdapter

#pragma mark - public method
+ (NSString *)currentPageKey {
    return _flutterViewController.pageName ? _flutterViewController.pageName : @"";
}

+ (NSDictionary *)currentProperties {
    return _flutterViewController.properties ? _flutterViewController.properties : @{};
}

#pragma mark - YHFlutterServiceProtocol
+ (UIViewController *)flutterViewControllerForKey:(NSString *)key properties:(NSDictionary *)properties {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _flutterViewController = [[YHFlutterViewController alloc] init];
        [YHFlutterMessageDispatcher setChannelRegistry:_flutterViewController];
        [YHFlutterMessageDispatcher setPluginRegistry:_flutterViewController];
    });
    
    _flutterViewController.pageName = key;
    _flutterViewController.properties = properties;
    [_flutterViewController syncPageArgumentToFlutter];
    
    return _flutterViewController;
}

+ (UIViewController *)currentFlutterViewController {
    return _flutterViewController;
}

#pragma mark - YHFlutterRegistrantProtocol
+ (void)registMethodChannelHandler:(Class<YHFlutterMethodChannelCall>)handler {
    [YHFlutterMessageDispatcher registMethodChannelHandler:handler];
}

+ (void)registEventChannelHandler:(Class<YHFlutterEventChannelCall>)handler {
    [YHFlutterMessageDispatcher registEventChannelHandler:handler];
}

+ (void)registBasicMessageChannelHandler:(Class<YHFlutterBasicMessageChannelCall>)handler {
    [YHFlutterMessageDispatcher registBasicMessageChannelHandler:handler];
}

+ (void)registPlugin:(Class<FlutterPlugin>)plugin pluginKey:(NSString *)pluginKey {
    [YHFlutterMessageDispatcher registPlugin:plugin pluginKey:pluginKey];
}

+ (FlutterMethodChannel *)methodChannelWithName:(NSString *)channelName {
    return [YHFlutterMessageDispatcher methodChannelWithName:channelName];
}

+ (FlutterEventChannel *)eventChannelWithName:(NSString *)channelName {
    return [YHFlutterMessageDispatcher eventChannelWithName:channelName];
}

+ (FlutterBasicMessageChannel *)basicMessageChannelWithName:(NSString *)channelName {
    return [YHFlutterMessageDispatcher basicMessageChannelWithName:channelName];
}

@end
