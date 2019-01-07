//
//  YHFlutterPageBridge.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterPageBridge.h"
#import "YHFlutterRegistrant.h"
#import "YHFlutterAdapter.h"
#import "YHFlutterChannelKey.h"

static NSString * const kCloseCurrentPageCallMethod = @"closeCurrentPage";
static NSString * const kGetPageParamsCallMethod    = @"getPageParams";

@implementation YHFlutterPageBridge

/**
 * 已经在 YHFlutterChannelRegistrant 内注册
 */
//+ (void)load {
//    [YHFlutterRegistrant registMethodChannelHandler:self.class];
//}

+ (NSString *)channelName {
    return kYahengBaseFlutterBridgeChannelName;
}

//+ (NSArray<NSString *> *)supportedMethodName {
//    return @[kCloseCurrentPageCallMethod,
//             kGetPageParamsCallMethod];
//}

+ (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([call.method isEqualToString:kCloseCurrentPageCallMethod]) {
        [self closeCurrentPageWithMethodCall:call result:result];
        return ;
    }
    
    if ([call.method isEqualToString:kGetPageParamsCallMethod]) {
        [self getPageParamsWithMethodCall:call result:result];
        return ;
    }
}

+ (void)closeCurrentPageWithMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *vc = [YHFlutterAdapter.currentFlutterViewController.navigationController popViewControllerAnimated:YES];
        if (!vc) {
            [YHFlutterAdapter.currentFlutterViewController dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

+ (void)getPageParamsWithMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *pageKey = [YHFlutterAdapter currentPageKey];
    if (result) {
        result(@{ @"page_key": pageKey});
    }
}

@end
