//
//  IGSignatureToken.h
//  IGSignature
//
//  Created by Chong Francis on 13年4月1日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IGSignatureRequest;

@interface IGSignatureToken : NSObject

@property (nonatomic, copy) NSString* key;
@property (nonatomic, copy) NSString* secret;

-(id) initWithKey:(NSString*)key secret:(NSString*)secret;

+(id) tokenWithKey:(NSString*)key secret:(NSString*)secret;

-(NSDictionary*) sign:(IGSignatureRequest*)request;

@end
