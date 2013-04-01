//
//  IGQueryEncoder.m
//  IGSignature
//
//  Created by Chong Francis on 13年4月1日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGQueryEncoder.h"

@implementation IGQueryEncoder

+(NSString*) encodeParamWithoutEscapingUsingKey:(NSString*)key andValue:(id<NSObject>)value {
    if ([value isKindOfClass:[NSArray class]]) {
        NSArray* array = (NSArray*) value;
        NSMutableArray* encodedArray = [NSMutableArray array];
        [array enumerateObjectsUsingBlock:^(id<NSObject> obj, NSUInteger idx, BOOL *stop) {
            [encodedArray addObject:[NSString stringWithFormat:@"%@[]=%@", key, obj]];
        }];
        return [encodedArray componentsJoinedByString:@"&"];
    } else {
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
}

@end
