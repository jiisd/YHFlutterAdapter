//
//  YHFlutterDefine.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

inline __attribute__((always_inline)) NSDictionary * yhfl_dictionary(id object) {
    return [object isKindOfClass:[NSDictionary class]] ? (NSDictionary *)object : nil;
}

inline __attribute__((always_inline)) NSString * yhfl_string(id object) {
    return [object isKindOfClass:[NSString class]] ? (NSString *)object : nil;
}

inline __attribute__((always_inline)) NSString * yhfl_dict2JsonStr(NSDictionary *dict) {
    if (!dict) {
        return nil;
    }
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&err];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return err ? nil : jsonString;
}

inline __attribute__((always_inline)) NSDictionary * yhfl_jsonStr2Dict(NSString *jsonStr) {
    if (!jsonStr) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    return err ? nil : dict;
}

NS_ASSUME_NONNULL_END
