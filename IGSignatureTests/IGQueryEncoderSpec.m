#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"

#import "IGQueryEncoder.h"

SpecBegin(IGQueryEncoder)

describe(@"IGQueryEncoder", ^{
    describe(@"encodeParamWithoutEscapingUsingKey:andValue:", ^{
        expect([IGQueryEncoder encodeParamWithoutEscapingUsingKey:@"query"
                                                         andValue:@"params"]).to.equal(@"query=params");

        expect([IGQueryEncoder encodeParamWithoutEscapingUsingKey:@"query"
                                                         andValue:(@[@"1", @"2"])]).to.equal(@"query[]=1&query[]=2");
    });
});

SpecEnd
