//
//  YHFlutterMessageDispatcher.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHFlutterProtocol.h"
#import "YHFlutterRegistrant.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHFlutterMessageDispatcher : NSObject <YHFlutterRegistrantProtocol>

+ (void)setChannelRegistry:(NSObject<FlutterBinaryMessenger>*)registry;

+ (void)setPluginRegistry:(NSObject<FlutterPluginRegistry>*)registry;

@end

NS_ASSUME_NONNULL_END
