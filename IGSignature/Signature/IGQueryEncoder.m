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
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSArray class]]) {
        NSArray* array = (NSArray*) value;
        NSMutableArray* encodedArray = [NSMutableArray array];
        NSArray *sortedArray = [array sortedArrayUsingDescriptors:@[ sortDescriptor ]];
        [sortedArray enumerateObjectsUsingBlock:^(id<NSObject> obj, NSUInteger idx, BOOL *stop) {
            NSString *nestedKey = [NSString stringWithFormat:@"%@[]", key];
            [encodedArray addObject:[self encodeParamWithoutEscapingUsingKey:nestedKey andValue:obj]];
        }];
        return [encodedArray componentsJoinedByString:@"&"];
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = (NSSet *) value;
        NSMutableArray* encodedArray = [NSMutableArray array];
        NSString *nestedKey = [NSString stringWithFormat:@"%@[]", key];
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [encodedArray addObject:[self encodeParamWithoutEscapingUsingKey:nestedKey andValue:obj]];
        }
        return [encodedArray componentsJoinedByString:@"&"];
    } else if ([value isKindOfClass:[NSDictionary  class]]) {
        NSDictionary *dict = (NSDictionary *) value;
        NSMutableArray* encodedArray = [NSMutableArray array];
        for (id subkey in [dict.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id obj = [dict objectForKey:subkey];
            NSString *nestedKey = [NSString stringWithFormat:@"%@[%@]", key, subkey];
            [encodedArray addObject:[self encodeParamWithoutEscapingUsingKey:nestedKey andValue:obj]];
        }
        return [encodedArray componentsJoinedByString:@"&"];
    } else {
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
}

@end
