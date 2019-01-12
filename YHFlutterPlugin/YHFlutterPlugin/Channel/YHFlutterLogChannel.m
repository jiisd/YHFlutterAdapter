//
//  YHFlutterLogChannel.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterLogChannel.h"
#import "YHFlutterRegistrant.h"
//#import <YHLog.h>

typedef NS_ENUM(NSInteger, YHFlutterLogLevel) {
    YHFlutterLogLevel_Debug      = 0,
    YHFlutterLogLevel_Info       = 1,
    YHFlutterLogLevel_Warn       = 2,
    YHFlutterLogLevel_Error      = 3,
};

static NSString * const kYahengBaseFlutterBridgeChannelName = @"yaheng.base.flutter.bridge";
static NSString * const kLogCallMethod = @"log";

@implementation YHFlutterLogChannel

+ (void)load {
    [YHFlutterRegistrant registMethodChannelHandler:self.class];
}

+ (NSString *)methodChannelName {
    return kYahengBaseFlutterBridgeChannelName;
}

+ (NSArray<NSString *> *)supportedMethodName {
    return @[kLogCallMethod];
}

+ (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kLogCallMethod]) {
        [self logWithMethodCall:call result:result];
        return ;
    }
}

+ (void)logWithMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSInteger level = [yhfl_dictionary(call.arguments)[@"level"] integerValue];
    NSString *tag = yhfl_dictionary(call.arguments)[@"tag"];
    NSString *log = yhfl_dictionary(call.arguments)[@"log"];

    NSString *str = [NSString stringWithFormat:@"#%@# %@", tag, log];
    NSLog(@"Received Log %d %@", (int)level, str);
    
    // 写入日志
    switch (level) {
        case YHFlutterLogLevel_Debug:
//            YHLogD(str);
            break;
        case YHFlutterLogLevel_Info:
//            YHLogI(str);
            break;
        case YHFlutterLogLevel_Warn:
//            YHLogW(str);
            break;
        case YHFlutterLogLevel_Error:
//            YHLogE(str);
            break;
        default:
            break;
    }
}

@end
