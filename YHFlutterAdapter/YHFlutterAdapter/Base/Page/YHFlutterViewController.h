//
//  YHFlutterViewController.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flutter.h"
#import "YHFlutterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHFlutterViewController : FlutterViewController

@property (nonatomic, strong) NSString      *pageName;
@property (nonatomic, strong) NSDictionary  *properties;

/**
 *  @brief  及时更新当前要加载的页面信息参数到 Flutter 端，可用于预加载部分数据
 */
- (void)syncPageArgumentToFlutter;

@end

NS_ASSUME_NONNULL_END
