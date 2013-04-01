//
//  IGSignatureRequest.m
//  IGSignature
//
//  Created by Chong Francis on 13年4月1日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGSignatureRequest.h"
#import "IGSignatureToken.h"
#import "IGQueryEncoder.h"
#import "NSString+SHA256HMAC.h"

@implementation IGSignatureRequest

-(id) initWithMethod:(NSString*)method path:(NSString*)path query:(NSDictionary*)theQuery {
    self = [super init];
    if (self) {
        self.path = path;
        NSMutableDictionary* auth = [NSMutableDictionary dictionary];
        NSMutableDictionary* query = [NSMutableDictionary dictionary];

        [theQuery enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop) {
            NSString* lowerKey = [key lowercaseString];
            if ([lowerKey hasPrefix:@"auth_"]) {
                [auth setObject:obj forKey:lowerKey];
            } else {
                [query setObject:obj forKey:lowerKey];
            }
        }];
        self.auth = [auth copy];
        self.query = [query copy];
        self.method = [method uppercaseString];

        _signed = NO;
    }
    return self;
}

-(NSDictionary*) sign:(IGSignatureToken*)token {
    return [self sign:token withTime:[NSDate date]];
}

-(NSDictionary*) sign:(IGSignatureToken*)token withTime:(NSDate*)time {
    NSAssert(token.key != nil, @"token key cannot be nil");
    NSAssert(time != nil, @"time cannot be nil");

    NSString* timestamp = [NSString stringWithFormat:@"%lld",
                           [[NSNumber numberWithDouble:[time timeIntervalSince1970]] longLongValue]];
    self.auth = @{
        @"auth_version": @"1.0",
        @"auth_key": token.key,
        @"auth_timestamp": timestamp
    };
    NSString* signature = [self signatureWithToken:token];
    self.auth = @{
        @"auth_version": @"1.0",
        @"auth_key": token.key,
        @"auth_timestamp": timestamp,
        @"auth_signature": signature
    };

    _signed = YES;
    return self.auth;
}

-(NSString*) signatureWithToken:(IGSignatureToken*)token {
    return [[self stringToSign] SHA256HMACWithKey:token.secret];
}

-(NSString*) stringToSign {
    NSArray* components = @[self.method, self.path, self.parameterString];
    return [components componentsJoinedByString:@"\n"];
}

#pragma mark - Private

-(NSString*) parameterString {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:self.query];
    if (self.auth) {
        [params addEntriesFromDictionary:self.auth];
    }

    // Convert keys to lowercase strings
    NSMutableDictionary* lowerCaseParams = [NSMutableDictionary dictionaryWithCapacity:[params count]];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop) {
        [lowerCaseParams setObject:obj forKey:[key lowercaseString]];
    }];

    // Exclude signature from signature generation!
    [lowerCaseParams removeObjectForKey:@"auth_signature"];

    NSArray* sortedKeys = [[lowerCaseParams allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray* encodedParamerers = [NSMutableArray array];
    [sortedKeys enumerateObjectsUsingBlock:^(NSString* key, NSUInteger idx, BOOL *stop) {
        [encodedParamerers addObject:[IGQueryEncoder encodeParamWithoutEscapingUsingKey:key
                                                                               andValue:[lowerCaseParams objectForKey:key]]];
    }];
    return [encodedParamerers componentsJoinedByString:@"&"];
}
@end
