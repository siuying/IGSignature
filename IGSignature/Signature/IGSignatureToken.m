//
//  IGSignatureToken.m
//  IGSignature
//
//  Created by Chong Francis on 13年4月1日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGSignatureToken.h"
#import "IGSignatureRequest.h"

@implementation IGSignatureToken

-(id) initWithKey:(NSString*)key secret:(NSString*)secret {
    self = [super init];
    if (self) {
        self.key = key;
        self.secret = secret;
    }
    return self;
}

+(id) tokenWithKey:(NSString*)key secret:(NSString*)secret {
    return [[IGSignatureToken alloc] initWithKey:key secret:secret];
}

-(NSDictionary*) sign:(IGSignatureRequest*)request {
    return [request sign:self];
}

@end
