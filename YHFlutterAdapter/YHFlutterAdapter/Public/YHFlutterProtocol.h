//
//  YHFlutterProtocol.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flutter.h"
#import "YHFlutterDefine.h"

@protocol YHFlutterServiceProtocol;
@protocol YHFlutterRegistrantProtocol;
@protocol YHFlutterMethodChannelCall;
@protocol YHFlutterEventChannelCall;
@protocol YHFlutterBasicMessageChannelCall;

NS_ASSUME_NONNULL_BEGIN

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol YHFlutterServiceProtocol <NSObject, YHFlutterRegistrantProtocol>

/**
 *  @brief  加载指定的 Flutter 界面
 *
 *  @param  key         加载 Flutter 界面对应的标识
 *  @param  properties  加载 Flutter 界面需要的部分业务参数
 *
 *  @return  对应的 Flutter 控制器
 */
+ (UIViewController *)flutterViewControllerForKey:(NSString * _Nonnull)key
                                       properties:(NSDictionary * _Nullable)properties;

/**
 *  @brief  获取当前的 Flutter 控制器
 *
 *  @return  当前的 Flutter 控制器
 */
+ (UIViewController *)currentFlutterViewController;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol YHFlutterRegistrantProtocol <NSObject>

/**
 *  @brief  注册使用 FlutterMethodChannel 方式与 Flutter 通信的对应功能类
 *
 *  @param  handler  需要实现 YHFlutterMethodChannelCall 相关协议
 */
+ (void)registMethodChannelHandler:(Class<YHFlutterMethodChannelCall>)handler;

/**
 *  @brief  注册使用 FlutterEventChannel 方式与 Flutter 通信的对应功能类
 *
 *  @param  handler  需要实现 YHFlutterEventChannelCall 相关协议
 */
+ (void)registEventChannelHandler:(Class<YHFlutterEventChannelCall>)handler;

/**
 *  @brief  注册使用 FlutterBasicMessageChannel 方式与 Flutter 通信的对应功能类
 *
 *  @param  handler  需要实现 YHFlutterBasicMessageChannelCall 相关协议
 */
+ (void)registBasicMessageChannelHandler:(Class<YHFlutterBasicMessageChannelCall>)handler;

/**
 *  @brief  注册 Plugin
 *
 *  @param  plugin     需要实现 FlutterPlugin 相关协议
 *  @param  pluginKey  该 Plugin 对应的唯一标识
 */
+ (void)registPlugin:(Class<FlutterPlugin>)plugin
           pluginKey:(NSString *)pluginKey;

/**
 *  @brief  获取特定 channelName 对应的 FlutterMethodChannel 实例
 *
 *  @param  channelName  该 FlutterMethodChannel 实例对应的唯一标识
 *
 *  @return  FlutterMethodChannel 实例
 */
+ (FlutterMethodChannel *)methodChannelWithName:(NSString *)channelName;

/**
 *  @brief  获取特定 channelName 对应的 FlutterEventChannel 实例
 *
 *  @param  channelName  该 FlutterEventChannel 实例对应的唯一标识
 *
 *  @return  FlutterEventChannel 实例
 */
+ (FlutterEventChannel *)eventChannelWithName:(NSString *)channelName;

/**
 *  @brief  获取特定 channelName 对应的 FlutterBasicMessageChannel 实例
 *
 *  @param  channelName  该 FlutterBasicMessageChannel 实例对应的唯一标识
 *
 *  @return  FlutterBasicMessageChannel 实例
 */
+ (FlutterBasicMessageChannel *)basicMessageChannelWithName:(NSString *)channelName;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol YHFlutterMethodChannelCall <NSObject>

@required
/**
 *  @brief  该类可接收基于 FlutterMethodChannel 对应 channelName 的相关调用，支持与其它 Class 重复注册相同的 channelName
 *
 *  @return 与 Flutter 通信的 FlutterMethodChannel 对应的唯一标识
 */
+ (NSString *)methodChannelName;

@optional
/**
 *  @brief  选择只接收哪些 callMethod 对应的调用消息，
 *          如若该类中没有实现该方法，会将对应 channelName 的消息全部转发到此类中，
 *          可与其它 Class 已经注册的 callMethod 重复
 *
 *  @return 当前 Class 支持哪些 methodName
 */
+ (NSArray<NSString *> *)supportedMethodName;

/**
 *  @brief  当前类注册了对应的 channel 之后，若 Flutter 端触发相关方法，消息会被转发到此类并调用该方法
 *
 *  @param  call 携带 method 方法名与 arguments 参数的调用封装
 *  @param  result 该次调用对应的回调 Block
 */
+ (void)handleMethodCall:(FlutterMethodCall * _Nonnull)call
                  result:(FlutterResult _Nonnull)result;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol YHFlutterEventChannelCall <NSObject>

@required
/**
 *  @brief  该类可接收基于 FlutterEventChannel 对应 channelName 的相关调用，目前不支持与其它 Class 重复注册相同的 channelName
 *
 *  @return  与 Flutter 通信的 FlutterEventChannel 对应的唯一标识
 */
+ (NSString *)eventChannelName;

/**
 *  @brief channelName 中返回的标识被 Flutter 端注册订阅后，会触发此方法
 *
 *  @param  arguments  该次调用对应的参数
 *  @param  events     该次调用对应的回调 Block
 *
 *  @return  FlutterError 若当前调用不能被成功响应，返回相关错误信息对象
 */
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events;

/**
 *  @brief  channelName 中返回的标识被 Flutter 端反注册取消订阅后，会触发此方法
 *
 *  @param  arguments  该次调用对应的参数
 *
 *  @return  FlutterError 若当前调用不能被成功响应，返回相关错误信息对象
 */
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments;;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol YHFlutterBasicMessageChannelCall <NSObject>

@required
/**
 *  @brief  该类可接收基于 FlutterBasicMessageChannel 对应 channelName 的相关调用，支持与其它 Class 重复注册相同的 channelName
 *
 *  @return 与 Flutter 通信的 FlutterBasicMessageChannel 对应的唯一标识
 */
+ (NSString *)basicMessageChannelName;

@optional
/**
 *  @brief 当前类注册了对应的 channel 之后，若 Flutter 端触发相关方法，消息会被转发到此类并调用该方法
 *
 *  @param  message      该次调用对应的参数
 *  @param  callback     该次调用对应的回调 Block
 */
+ (void)handleBasicMessage:(id _Nullable)message
                  callback:(FlutterReply _Nonnull)callback;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////

NS_ASSUME_NONNULL_END
