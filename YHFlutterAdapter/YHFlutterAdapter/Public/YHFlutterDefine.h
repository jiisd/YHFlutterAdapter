//
//  YHFlutterDefine.h
//  YHFlutterAdapter
//
//  Created by yahengzheng on 2019/1/6.
//  Copyright © 2019 yahengzheng. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

inline __attribute__((always_inline)) NSDictionary *    yhfl_dictionary(id object);
inline __attribute__((always_inline)) NSString *        yhfl_string(id object);

inline __attribute__((always_inline)) NSString *        yhfl_dict2JsonStr(NSDictionary *dict);
inline __attribute__((always_inline)) NSString *        yhfl_array2JsonStr(NSArray *array);
inline __attribute__((always_inline)) NSString *        yhfl_obj2jsonStr(id obj);

inline __attribute__((always_inline)) NSDictionary *    yhfl_jsonStr2Dict(NSString *jsonStr);
inline __attribute__((always_inline)) NSArray *         yhfl_jsonStr2Array(NSString *jsonStr);
inline __attribute__((always_inline)) id                yhfl_jsonStr2Obj(Class objClass , NSString *jsonStr);

#pragma mark -
inline __attribute__((always_inline)) NSDictionary * yhfl_dictionary(id object) {
    return [object isKindOfClass:[NSDictionary class]] ? (NSDictionary *)object : nil;
}

inline __attribute__((always_inline)) NSString * yhfl_string(id object) {
    return [object isKindOfClass:[NSString class]] ? (NSString *)object : nil;
}

inline __attribute__((always_inline)) NSString * yhfl_dict2JsonStr(NSDictionary *dict) {
    return yhfl_obj2jsonStr(dict);
}

inline __attribute__((always_inline)) NSString * yhfl_array2JsonStr(NSArray *array) {
    return yhfl_obj2jsonStr(array);
}

inline __attribute__((always_inline)) NSDictionary * yhfl_jsonStr2Dict(NSString *jsonStr) {
    return yhfl_jsonStr2Obj(NSDictionary.class, jsonStr);
}

inline __attribute__((always_inline)) NSArray * yhfl_jsonStr2Array(NSString *jsonStr) {
    return yhfl_jsonStr2Obj(NSArray.class, jsonStr);
}

inline __attribute__((always_inline)) NSString * yhfl_obj2jsonStr(id obj) {
    if (!obj) {
        return nil;
    }
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&err];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return err ? nil : jsonString;
}

inline __attribute__((always_inline)) id yhfl_jsonStr2Obj(Class objClass , NSString *jsonStr) {
    if (!jsonStr) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                             options:NSJSONReadingMutableContainers
                                               error:&err];
    if (err || ![obj isKindOfClass:objClass]) {
        return nil;
    } else {
        return obj;
    }
}

NS_ASSUME_NONNULL_END
