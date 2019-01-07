//
//  YHFlutterManagerConfig.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterDispatcherConfig.h"

#define INIT_MUTABLE_DICTIONARY \
static NSMutableDictionary *dictM = NULL; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
    dictM = [[NSMutableDictionary alloc] init]; \
}); \
return dictM;

@implementation YHFlutterDispatcherConfig

+ (dispatch_queue_t)queue {
    static dispatch_queue_t queue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.yaheng.flutter.dispatcher", NULL);
    });
    return queue;
}

+ (NSMutableDictionary<NSString *, NSMutableArray<Class<YHFlutterMethodChannelCall>> *> *)methodChannelClassDictM {
    INIT_MUTABLE_DICTIONARY
}

+ (NSMutableDictionary<NSString *, FlutterMethodChannel *> *)registeredMethodChannelDictM {
    INIT_MUTABLE_DICTIONARY
}

+ (NSMutableDictionary<NSString *, NSMutableArray<Class<YHFlutterEventChannelCall>> *> *)eventChannelClassDictM {
    INIT_MUTABLE_DICTIONARY
}

+ (NSMutableDictionary<NSString *, FlutterEventChannel *> *)registeredEventChannelDictM {
    INIT_MUTABLE_DICTIONARY
}

+ (NSMutableDictionary<NSString *, NSMutableArray<Class<YHFlutterBasicMessageChannelCall>> *> *)basicMessageChannelClassDictM {
    INIT_MUTABLE_DICTIONARY
}

+ (NSMutableDictionary<NSString *, FlutterBasicMessageChannel *> *)registeredBasicMessageChannelDictM {
    INIT_MUTABLE_DICTIONARY
}

+ (NSMutableDictionary<NSString *, Class<FlutterPlugin>> *)pluginDictM {
    INIT_MUTABLE_DICTIONARY
}

+ (NSMutableDictionary<NSString *, Class<FlutterPlugin>> *)registeredPluginDictM {
    INIT_MUTABLE_DICTIONARY
}

@end
