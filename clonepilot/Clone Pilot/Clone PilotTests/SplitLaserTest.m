#import "Kiwi.h"
#import "SplitLaser.h"

SPEC_BEGIN(SplitLaserTest)

describe(@"Split Laser Test", ^{
    __block SplitLaser *w;
    __block CGPoint sl;
    
    beforeEach(^{
        w = [[[SplitLaser alloc] init] autorelease];
        sl = CGPointMake(384, 500);
    });

    
    it(@"should have 2 bullets", ^{
        NSArray *bullets = [w newBulletsForLocation:sl direction:1];
        [[theValue([bullets count]) should] equal:theValue(2)];
    });
    
    
});

SPEC_END