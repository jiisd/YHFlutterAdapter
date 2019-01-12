//
//  YHFlutterModule.m
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import "YHFlutterModule.h"
#import "YHFlutterAdapter.h"
#import "YHGeneratedPluginRegistrant.h"

@implementation YHFlutterModule

+ (void)setup {
    /// regist something
    
    /// e.g.:
    //    [YHGeneratedPluginRegistrant registPlugin];
}

+ (Class<YHFlutterServiceProtocol>)service {
    return [YHFlutterAdapter class];
}

@end
