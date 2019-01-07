//
//  YHGeneratedPluginRegistrant.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHGeneratedPluginRegistrant.h"
#import "PathProviderPlugin.h"
#import "SharedPreferencesPlugin.h"
#import "YHFlutterRegistrant.h"
//#import <path_provider/PathProviderPlugin.h>
//#import <shared_preferences/SharedPreferencesPlugin.h>

@implementation YHGeneratedPluginRegistrant

+ (void)load {
    [YHFlutterRegistrant registPlugin:FLTPathProviderPlugin.class pluginKey:NSStringFromClass(FLTPathProviderPlugin.class)];
    [YHFlutterRegistrant registPlugin:FLTSharedPreferencesPlugin.class pluginKey:NSStringFromClass(FLTSharedPreferencesPlugin.class)];
}

+ (void)registPlugin {
//    [YHFlutterRegistrant registPlugin:FLTPathProviderPlugin.class pluginKey:NSStringFromClass(FLTPathProviderPlugin.class)];
//    [YHFlutterRegistrant registPlugin:FLTSharedPreferencesPlugin.class pluginKey:NSStringFromClass(FLTSharedPreferencesPlugin.class)];
}

@end
