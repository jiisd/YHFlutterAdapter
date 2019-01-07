//
//  YHFlutterFeatureBridgeTest.m
//  YHFlutterDemo
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterFeatureBridgeTest.h"
#import "YHFlutterProtocol.h"
#import "YHFlutterRegistrant.h"

NSString * const kFeatureBridgeChannelName = @"yaheng.feature.flutter.bridge";
static NSString * const kFeatureInfoCallMethod = @"featureInfo";

@implementation YHFlutterFeatureBridgeTest

/**
 *  @brief  可通过 +load 自动注册，
 *          也可通过将 YHFlutterModule 注册进现有项目中的组件化服务之后，调用 YHFlutterServiceProtocol 相关方法来注册
 */
+ (void)load {
    [YHFlutterRegistrant registMethodChannelHandler:self.class];
}

/**
 *  @brief  该类可接收基于 FlutterMethodChannel 对应 channelName 的相关调用，支持与其它 Class 重复注册相同的 channelName
 *
 *  @return 与 Flutter 通信的 FlutterMethodChannel 对应的唯一标识
 */
+ (NSString *)channelName {
    return kFeatureBridgeChannelName;
}

/**
 *  @brief  选择只接收哪些 callMethod 对应的调用消息，
 *          如若该类中没有实现该方法，会将对应 channelName 的消息全部转发到此类中，
 *          可与其它 Class 已经注册的 callMethod 重复
 *
 *  @return 当前 Class 支持哪些 methodName
 */
+ (NSArray<NSString *> *)supportedCallMethod {
    return @[kFeatureInfoCallMethod];
}

/**
 *  @brief  当前类注册了对应的 channel 之后，若 Flutter 端触发相关方法，消息会被转发到此类并调用该方法
 *
 *  @param  call 携带 method 方法名与 arguments 参数的调用封装
 *  @param  result 该次调用对应的回调 Block
 */
+ (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kFeatureInfoCallMethod]) {
        [self featureInfoWithMethodCall:call result:result];
        return ;
    }
}

/**
 *  @brief  具体业务功能的对应实现
 */
+ (void)featureInfoWithMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if (result) {
        result(@{@"gid":@(13187098),
                 @"gnick":@"yahengzheng",
                 @"gdes":@"some description..."
                 });
    }
}

@end


