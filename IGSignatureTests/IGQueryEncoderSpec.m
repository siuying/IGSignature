#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "IGQueryEncoder.h"

SpecBegin(IGQueryEncoder)

describe(@"IGQueryEncoder", ^{
    describe(@"encodeParamWithoutEscapingUsingKey:andValue:", ^{
        it(@"encode array", ^{
            expect([IGQueryEncoder encodeParamWithoutEscapingUsingKey:@"query"
                                                             andValue:@"params"]).to.equal(@"query=params");
            
            expect([IGQueryEncoder encodeParamWithoutEscapingUsingKey:@"query"
                                                             andValue:(@[@"1", @"2"])]).to.equal(@"query[]=1&query[]=2");
            
            expect([IGQueryEncoder encodeParamWithoutEscapingUsingKey:@"query"
                                                             andValue:(@[@"2", @"1"])]).to.equal(@"query[]=2&query[]=1");
        });
    });
});

SpecEnd
