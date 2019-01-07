//
//  YHFlutterManagerConfig.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHFlutterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

inline __attribute__((always_inline)) void yhfl_executeOnDispatcherQueueAsync(void(^block)(void));

inline __attribute__((always_inline)) void yhfl_executeOnMainThreadAsync(void (^block)(void));

@interface YHFlutterDispatcherConfig : NSObject

+ (dispatch_queue_t)queue;

+ (NSMutableDictionary<NSString *, NSMutableArray<Class<YHFlutterMethodChannelCall>> *> *)methodChannelClassDictM;

+ (NSMutableDictionary<NSString *, FlutterMethodChannel *> *)registeredMethodChannelDictM;

+ (NSMutableDictionary<NSString *, NSMutableArray<Class<YHFlutterEventChannelCall>> *> *)eventChannelClassDictM;

+ (NSMutableDictionary<NSString *, FlutterEventChannel *> *)registeredEventChannelDictM;

+ (NSMutableDictionary<NSString *, NSMutableArray<Class<YHFlutterBasicMessageChannelCall>> *> *)basicMessageChannelClassDictM;

+ (NSMutableDictionary<NSString *, FlutterBasicMessageChannel *> *)registeredBasicMessageChannelDictM;

+ (NSMutableDictionary<NSString *, Class<FlutterPlugin>> *)pluginDictM;

+ (NSMutableDictionary<NSString *, Class<FlutterPlugin>> *)registeredPluginDictM;

@end

inline __attribute__((always_inline)) void yhfl_executeOnDispatcherQueueAsync(void(^block)(void)) {
    dispatch_async([YHFlutterDispatcherConfig queue], ^{
        if (block) {
            block();
        }
    });
}

inline __attribute__((always_inline)) void yhfl_executeOnMainThreadAsync(void (^block)(void)) {
    if (block) {
        if ([NSThread isMainThread]) {
            block();
        } else {
            dispatch_async(dispatch_get_main_queue(), block);
        }
    }
}

NS_ASSUME_NONNULL_END
