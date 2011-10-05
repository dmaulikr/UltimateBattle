#import "Kiwi.h"
#import "ClonePlayer.h"
#import "VRGeometry.h"

SPEC_BEGIN(ClonePlayerTest)

describe(@"Clone Player", ^{
    __block ClonePlayer *p;
    
    beforeEach(^{
        p = [ClonePlayer samplePlayer];
    });
    
    it(@"should accept a target point and move towards the target point", ^{
        p.t = CGPointMake(300, 300);
        float distance = GetDistance(p.l, p.t);
        [p tick];
        [[theValue(GetDistance(p.l,p.t)) should] beLessThan:theValue(distance)];
        
    });
});

SPEC_END