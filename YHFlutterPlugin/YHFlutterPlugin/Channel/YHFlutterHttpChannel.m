//
//  YHFlutterHttpChannel.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterHttpChannel.h"
#import "YHFlutterRegistrant.h"

static NSString * const kYahengBaseFlutterBridgeChannelName = @"yaheng.base.flutter.bridge";
static NSString * const kYhHttpGetCallMethod                = @"yhHttpGet";

@implementation YHFlutterHttpChannel

+ (void)load {
    [YHFlutterRegistrant registMethodChannelHandler:self.class];
}

+ (NSString *)methodChannelName {
    return kYahengBaseFlutterBridgeChannelName;
}

+ (NSArray<NSString *> *)supportedMethodName {
    return @[kYhHttpGetCallMethod];
}

+ (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kYhHttpGetCallMethod]) {
        [self yhHttpGetWithMethodCall:call result:result];
        return ;
    }
}

+ (void)yhHttpGetWithMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    /**
     * 调用客户端内的一些请求加密逻辑，完成请求后将数据返回给 Flutter 端
     */
    NSString *urlString = yhfl_dictionary(call.arguments)[@"url"];
//    NSDictionary *params = yhfl_dictionary(call.arguments)[@"params"];
    
    NSURLSession* session = [NSURLSession sharedSession];
    NSURL* URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            // Success
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (result) {
                result(string);
            }
        } else {
            // Failure
            if (result) {
                result(@"{\"err_msg\":\"Request failure\"}");
            }
        }
    }];
    [task resume];
}

@end
