#import "Kiwi.h"
#import "ClonePlayer.h"

SPEC_BEGIN(ClonePlayerTest)

describe(@"Clone Player", ^{
    __block ClonePlayer *p;
    
    beforeEach(^{
        p = [ClonePlayer samplePlayer];
    });
    
    it(@"should be described", ^{
        [[theValue(NO) should] beTrue];
    });
});

SPEC_END