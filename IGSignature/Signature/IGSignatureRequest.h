//
//  IGSignatureRequest.h
//  IGSignature
//
//  Created by Chong Francis on 13年4月1日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IGSignatureToken;

@interface IGSignatureRequest : NSObject {
@private
    BOOL _signed;
}

@property (nonatomic, copy) NSString* method;
@property (nonatomic, copy) NSString* path;

@property (nonatomic, strong) NSDictionary* query;
@property (nonatomic, strong) NSDictionary* auth;

-(id) initWithMethod:(NSString*)method path:(NSString*)path query:(NSDictionary*)query;

-(NSDictionary*) sign:(IGSignatureToken*)token;

-(NSDictionary*) sign:(IGSignatureToken*)token withTime:(NSDate*)time;

-(NSString*) stringToSign;

@end
