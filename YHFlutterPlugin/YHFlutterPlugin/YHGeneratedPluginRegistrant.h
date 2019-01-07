//
//  YHGeneratedPluginRegistrant.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

/**
 * 暂时只用于注册在 https://pub.dartlang.org/flutter 中对应开源的 Plugin，完全自己编写的在建议直接在自身内部注册
 * pubspec.yaml 内添加的 Plugin 在编译之后，会自动添加对应的原生端的相关桥接代码到 Flutter 工程目录下 ./.ios/ 内对应工程中
 * 由于我们目前采用 pod 只集成其最终产物的形式来使用，故需要手动将对应文件移植进来
 * 移植进来之后建议不要更改 Plugin 对应类的代码，建议不要更改其源码，建议不要更改其源码，直接在当前类的 +registPlugin 或者 +load 内引用注册即可
 */

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHGeneratedPluginRegistrant : NSObject

+ (void)registPlugin;

@end

NS_ASSUME_NONNULL_END

/** 目前支持的插件注册形式
 * 插件的注册形式一，YHGeneratedPluginRegistrant类中的 +load 或者 +registPlugin 方法
 * + (void)load {
 *     [YHFlutterRegistrant registPlugin:FLTPathProviderPlugin.class channelName:NSStringFromClass(FLTPathProviderPlugin.class)];
 *     [YHFlutterRegistrant registPlugin:FLTSharedPreferencesPlugin.class channelName:NSStringFromClass(FLTSharedPreferencesPlugin.class)];
 * }
 *
 * 插件的注册形式二，使用自身项目内已经有的组件化方案，例如：YHServiceManager
 * 项目内若有相关组件化的方案，采用注册后的组件来调用 YHFlutterRegistrantProtocol 内对应方法
 * id<YHFlutterRegistrantProtocol> flutterRegistrant = [[YHServiceManager sharedInstance] service:@protocol(IKFlutterRegistrantProtocol)];
 * [flutterRegistrant registPlugin:FLTPathProviderPlugin.class channelName:NSStringFromClass(FLTSharedPreferencesPlugin.class)]];
 *
 * 插件的注册形式三
 * [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
 * [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
 *
 * 插件的注册形式四
 * id<FlutterPlugin> plugin = [[FLTPathProviderPlugin alloc] init];
 * [_plugins addObject:plugin];
 * id<FlutterPluginRegistrar> registrar = [registry registrarForPlugin:@"FLTPathProviderPlugin"];
 * FlutterMethodChannel* methodChannel = [FlutterMethodChannel methodChannelWithName:@"plugins.flutter.io/path_provider" binaryMessenger:[registrar messenger]];
 * [registrar addMethodCallDelegate:plugin channel:methodChannel];
 */

