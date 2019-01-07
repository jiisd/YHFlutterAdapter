//
//  YHFlutterRegistrant.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterRegistrant.h"
#import "YHFlutterAdapter.h"

@implementation YHFlutterRegistrant

+ (void)registMethodChannelHandler:(Class<YHFlutterMethodChannelCall>)handler {
    [YHFlutterAdapter registMethodChannelHandler:handler];
}

+ (void)registEventChannelHandler:(Class<YHFlutterEventChannelCall>)handler {
    [YHFlutterAdapter registEventChannelHandler:handler];
}

+ (void)registBasicMessageChannelHandler:(Class<YHFlutterBasicMessageChannelCall>)handler {
    [YHFlutterAdapter registBasicMessageChannelHandler:handler];
}

+ (void)registPlugin:(Class<FlutterPlugin>)plugin pluginKey:(NSString *)pluginKey {
    [YHFlutterAdapter registPlugin:plugin pluginKey:pluginKey];
}

+ (FlutterMethodChannel *)methodChannelWithName:(NSString *)channelName {
    return [YHFlutterAdapter methodChannelWithName:channelName];
}

+ (FlutterEventChannel *)eventChannelWithName:(NSString *)channelName {
    return [YHFlutterAdapter eventChannelWithName:channelName];
}

+ (FlutterBasicMessageChannel *)basicMessageChannelWithName:(NSString *)channelName {
    return [YHFlutterAdapter basicMessageChannelWithName:channelName];
}

@end
