//
//  YHFlutterModule.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHFlutterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHFlutterModule : NSObject

+ (void)setup;

+ (Class<YHFlutterServiceProtocol>)service;

@end

NS_ASSUME_NONNULL_END
