//
//  YHFlutterAdapter.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHFlutterProtocol.h"
#import "YHFlutterRegistrant.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHFlutterAdapter : NSObject <YHFlutterServiceProtocol>

+ (NSString *)currentPageKey;

+ (NSDictionary *)currentProperties;

@end

NS_ASSUME_NONNULL_END
