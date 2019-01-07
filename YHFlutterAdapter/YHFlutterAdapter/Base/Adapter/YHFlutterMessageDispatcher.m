//
//  YHFlutterMessageDispatcher.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterMessageDispatcher.h"
#import "YHFlutterDefine.h"
#import "YHFlutterDispatcherConfig.h"

static __weak NSObject<FlutterBinaryMessenger>                          *_channelRegistry;
static __weak NSObject<FlutterPluginRegistry>                           *_pluginRegistry;

@implementation YHFlutterMessageDispatcher

#pragma mark - public method
+ (void)setChannelRegistry:(NSObject<FlutterBinaryMessenger>*)registry {
    yhfl_executeOnDispatcherQueueAsync(^{
        _channelRegistry = registry;
        
        // regist
        [[YHFlutterDispatcherConfig methodChannelClassDictM] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray<Class<YHFlutterMethodChannelCall>> * _Nonnull arrM, BOOL * _Nonnull stop) {
            [arrM enumerateObjectsUsingBlock:^(Class<YHFlutterMethodChannelCall>  _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
                [self registMethodChannelHandler:handler];
            }];
        }];
        
        [[YHFlutterDispatcherConfig eventChannelClassDictM].allValues enumerateObjectsUsingBlock:^(NSMutableArray<Class<YHFlutterEventChannelCall>> * _Nonnull arrM, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM enumerateObjectsUsingBlock:^(Class<YHFlutterEventChannelCall>  _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
                [self registEventChannelHandler:handler];
            }];
        }];
        
        [[YHFlutterDispatcherConfig basicMessageChannelClassDictM].allValues enumerateObjectsUsingBlock:^(NSMutableArray<Class<YHFlutterBasicMessageChannelCall>> * _Nonnull arrM, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM enumerateObjectsUsingBlock:^(Class<YHFlutterBasicMessageChannelCall>  _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
                [self registBasicMessageChannelHandler:handler];
            }];
        }];
    });
}

+ (void)setPluginRegistry:(NSObject<FlutterPluginRegistry>*)registry {
    yhfl_executeOnDispatcherQueueAsync(^{
        _pluginRegistry = registry;
        
        // regist
        [[YHFlutterDispatcherConfig pluginDictM] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull pluginKey, Class<FlutterPlugin>  _Nonnull pluginCalss, BOOL * _Nonnull stop) {
            [self registPlugin:pluginCalss pluginKey:pluginKey];
        }];
    });
}

#pragma mark - YHFlutterRegistrantProtocol
+ (void)registMethodChannelHandler:(Class<YHFlutterMethodChannelCall>)handler {
    NSString *channelName = [handler channelName];
    if (!channelName.length) {
        return;
    }
    
    yhfl_executeOnDispatcherQueueAsync(^{
        if (![YHFlutterDispatcherConfig methodChannelClassDictM][channelName]) {
            [YHFlutterDispatcherConfig methodChannelClassDictM][channelName] = (NSMutableArray<YHFlutterMethodChannelCall> *)[[NSMutableArray alloc] init];
        }
        
        if (![[YHFlutterDispatcherConfig methodChannelClassDictM][channelName] containsObject:handler]) {
            [[YHFlutterDispatcherConfig methodChannelClassDictM][channelName] addObject:handler];
        }
        
        if (_channelRegistry) {
            if ([YHFlutterDispatcherConfig registeredMethodChannelDictM][channelName]) {
                return;
            }
            
            // regist
            FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:_channelRegistry];
            [YHFlutterDispatcherConfig registeredMethodChannelDictM][channelName] = channel;
            [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
                yhfl_executeOnDispatcherQueueAsync(^{
                    [self handleMethodCall:call result:result channelName:channelName];
                });
            }];
        }
    });
}

+ (void)registEventChannelHandler:(Class<YHFlutterEventChannelCall>)handler {
    NSString *channelName = [handler channelName];
    if (!channelName.length) {
        return;
    }
    
    yhfl_executeOnDispatcherQueueAsync(^{
        if (![YHFlutterDispatcherConfig eventChannelClassDictM][channelName]) {
            [YHFlutterDispatcherConfig eventChannelClassDictM][channelName] = (NSMutableArray<YHFlutterEventChannelCall> *)[[NSMutableArray alloc] init];
        }
        
        if (![[YHFlutterDispatcherConfig eventChannelClassDictM][channelName] containsObject:handler]) {
            [[YHFlutterDispatcherConfig eventChannelClassDictM][channelName] addObject:handler];
        }
        
        if (_channelRegistry) {
            if ([YHFlutterDispatcherConfig registeredEventChannelDictM][channelName]) {
#ifdef DEBUG
                @throw [NSException exceptionWithName:@"#flutter#"
                                               reason:[NSString stringWithFormat:@"registEventChannelHandler duplicate regist：%@", channelName]
                                             userInfo:nil];
#endif
                return;
            }
            
            // regist
            FlutterEventChannel *channel = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:_channelRegistry];
            [YHFlutterDispatcherConfig registeredEventChannelDictM][channelName] = channel;
            [channel setStreamHandler:[[((Class)handler) alloc] init]];
        }
    });
}

+ (void)registBasicMessageChannelHandler:(Class<YHFlutterBasicMessageChannelCall>)handler {
    NSString *channelName = [handler channelName];
    if (!channelName.length) {
        return;
    }
    
    yhfl_executeOnDispatcherQueueAsync(^{
        if (![YHFlutterDispatcherConfig basicMessageChannelClassDictM][channelName]) {
            [YHFlutterDispatcherConfig basicMessageChannelClassDictM][channelName] = (NSMutableArray<YHFlutterBasicMessageChannelCall> *)[[NSMutableArray alloc] init];
        }
        
        if (![[YHFlutterDispatcherConfig basicMessageChannelClassDictM][channelName] containsObject:handler]) {
            [[YHFlutterDispatcherConfig basicMessageChannelClassDictM][channelName] addObject:handler];
        }
        
        if (_channelRegistry) {
            if ([YHFlutterDispatcherConfig registeredBasicMessageChannelDictM][channelName]) {
                return;
            }
            
            // regist
            FlutterBasicMessageChannel *channel = [FlutterBasicMessageChannel messageChannelWithName:channelName binaryMessenger:_channelRegistry];
            [YHFlutterDispatcherConfig registeredBasicMessageChannelDictM][channelName] = channel;
            [channel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
                yhfl_executeOnDispatcherQueueAsync(^{
                    [self handleBasicMessage:message callback:callback channelName:channelName];
                });
            }];
        }
    });
}

+ (void)registPlugin:(Class<FlutterPlugin>)plugin pluginKey:(NSString *)pluginKey {
    if (!pluginKey.length) {
        return;
    }
    
    yhfl_executeOnDispatcherQueueAsync(^{
        if ([YHFlutterDispatcherConfig registeredPluginDictM][pluginKey]) {
            return;
        }
        
        [YHFlutterDispatcherConfig pluginDictM][pluginKey] = plugin;
        if (_pluginRegistry) {
            // regist
            yhfl_executeOnMainThreadAsync(^{
                [plugin registerWithRegistrar:[_pluginRegistry registrarForPlugin:pluginKey]];
            });
            [YHFlutterDispatcherConfig registeredPluginDictM][pluginKey] = plugin;
        }
    });
}

+ (FlutterMethodChannel *)methodChannelWithName:(NSString *)channelName {
    return [YHFlutterDispatcherConfig registeredMethodChannelDictM][channelName];
}

+ (FlutterEventChannel *)eventChannelWithName:(NSString *)channelName {
    return [YHFlutterDispatcherConfig registeredEventChannelDictM][channelName];
}

+ (FlutterBasicMessageChannel *)basicMessageChannelWithName:(NSString *)channelName {
    return [YHFlutterDispatcherConfig registeredBasicMessageChannelDictM][channelName];
}

#pragma mark - privite method
+ (void)handleMethodCall:(FlutterMethodCall * _Nonnull)call result:(FlutterResult _Nonnull)result channelName:(NSString *)channelName {
    NSMutableArray<Class<YHFlutterMethodChannelCall>> *arrM = [YHFlutterDispatcherConfig methodChannelClassDictM][channelName];
    [arrM enumerateObjectsUsingBlock:^(Class<YHFlutterMethodChannelCall>  _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
        // supportedMethodName
        if ([handler respondsToSelector:@selector(supportedMethodName)]) {
            if ([[handler supportedMethodName] containsObject:call.method]) {
                if ([handler respondsToSelector:@selector(handleMethodCall:result:)]) {
                    yhfl_executeOnMainThreadAsync(^{
                        [handler handleMethodCall:call result:result];
                    });
                }
            }
            
        } else {
            // all
            if ([handler respondsToSelector:@selector(handleMethodCall:result:)]) {
                yhfl_executeOnMainThreadAsync(^{
                    [handler handleMethodCall:call result:result];
                });
            }
        }
    }];
}

+ (void)handleBasicMessage:(id  _Nullable)message callback:(FlutterReply  _Nonnull)callback channelName:(NSString *)channelName {
    NSMutableArray<Class<YHFlutterBasicMessageChannelCall>> *arrM = [YHFlutterDispatcherConfig basicMessageChannelClassDictM][channelName];
    [arrM enumerateObjectsUsingBlock:^(Class<YHFlutterBasicMessageChannelCall>  _Nonnull handler, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([handler respondsToSelector:@selector(handleBasicMessage:callback:)]) {
            yhfl_executeOnMainThreadAsync(^{
                [handler handleBasicMessage:message callback:callback];
            });
        }
    }];
}

@end
