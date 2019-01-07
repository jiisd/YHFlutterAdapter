//
//  YHFlutterChannelRegistrant.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterChannelRegistrant.h"
#import "YHFlutterRegistrant.h"
#import "YHFlutterPageBridge.h"

@implementation YHFlutterChannelRegistrant

/**
 *  @brief  可以在这里注册 channel 消息，也可以在具体的桥接类里各自使用 +load 方法自行注册
 */
+ (void)registChannel {
    // EXP:
    [YHFlutterRegistrant registMethodChannelHandler:[YHFlutterPageBridge class]];
}

@end
