#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "IGSignatureToken.h"
#import "IGSignatureRequest.h"
#import "NSString+SHA256HMAC.h"

SpecBegin(IGSignatureRequest)

describe(@"IGSignatureRequest", ^{
    __block NSDate* time;
    __block IGSignatureToken* token;
    __block IGSignatureRequest* request;

    beforeEach(^{
        time    = [NSDate dateWithTimeIntervalSince1970:1234];
        token   = [[IGSignatureToken alloc] initWithKey:@"key" secret:@"secret"];
        request = [[IGSignatureRequest alloc] initWithMethod:@"POST"
                                                        path:@"/some/path"
                                                       query:@{@"query": @"params", @"go": @"here"}];
    });
    
    describe(@"generate signatures", ^{
        __block NSString* signature;

        before(^{
            signature = @"3b237953a5ba6619875cbb2a2d43e8da9ef5824e8a2c689f6284ac85bc1ea0db";
        });
        
        it(@"should generate signature correctly", ^{
            [request sign:token withTime:time];
            
            NSString* stringToSign = @"POST\n/some/path\nauth_key=key&auth_timestamp=1234&auth_version=1.0&go=here&query=params";
            expect([request stringToSign]).to.equal(stringToSign);
            
            NSMutableDictionary* queryParams = [NSMutableDictionary dictionaryWithDictionary:[request auth]];
            [queryParams addEntriesFromDictionary:[request query]];
            
            NSDictionary* authKeys = [request auth];
            expect(authKeys[@"auth_version"]).to.equal(@"1.0");
            expect(authKeys[@"auth_key"]).to.equal(@"key");
            expect(authKeys[@"auth_timestamp"]).to.equal(@"1234");
            expect(authKeys[@"auth_signature"]).to.equal(signature);
        });
        
        it(@"should convert keys are lowercased before signing", ^{
            NSDictionary* query = @{@"Query": @"params", @"Go": @"here"};
            request.query = query;
            [request sign:token withTime:time];
            
            NSString* stringToSign = @"POST\n/some/path\nauth_key=key&auth_timestamp=1234&auth_version=1.0&go=here&query=params";
            expect([request stringToSign]).to.equal(stringToSign);
            
            NSDictionary* authKeys = [request auth];
            expect(authKeys[@"auth_version"]).to.equal(@"1.0");
            expect(authKeys[@"auth_key"]).to.equal(@"key");
            expect(authKeys[@"auth_timestamp"]).to.equal(@"1234");
            expect(authKeys[@"auth_signature"]).to.equal(signature);
        });
        
        pending(@"should generate correct string when query hash contains array");
        pending(@"should not escape keys or values in the query string");
        pending(@"should use the path to generate signature");
        pending(@"should use the query string keys to generate signature");
        pending(@"should use the query string values to generate signature");
    });
});

SpecEnd