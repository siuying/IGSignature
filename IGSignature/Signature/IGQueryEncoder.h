//
//  IGQueryEncoder.h
//  IGSignature
//
//  Created by Chong Francis on 13年4月1日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

// QueryEncoder based on signature project
// https://github.com/mloughran/signature/blob/master/lib/signature/query_encoder.rb
//
@interface IGQueryEncoder : NSObject

+(NSString*) encodeParamWithoutEscapingUsingKey:(NSString*)key andValue:(id<NSObject>)value;

@end
