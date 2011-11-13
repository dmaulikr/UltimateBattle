#import "Kiwi.h"
#import "SideLaser.h"

SPEC_BEGIN(SideLaserTest)

describe(@"Side Laser Test", ^ {
    __block SideLaser *w; 
    
    beforeEach(^{
        w = [[[SideLaser alloc] init] autorelease]; 
    });
    
    it(@"should have one bullet", ^{
        NSArray *bullets = [w newBulletsForLocation:CGPointMake(384, 500) direction:-1];
        [[theValue([bullets count]) should] equal:theValue(1)];
    });
});

SPEC_END