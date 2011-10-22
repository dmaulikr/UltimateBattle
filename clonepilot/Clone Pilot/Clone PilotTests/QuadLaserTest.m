#import "Kiwi.h"
#import "QuadLaser.h"

SPEC_BEGIN(QUAD_LASER_TEST)


describe(@"Quad Laser Test", ^ {
    __block QuadLaser *w;
    
    beforeEach(^{
        w = [[[QuadLaser alloc] init] autorelease];
    });
    
    it(@"should have 4 bullets",^ {
        NSArray *bullets = [w newBulletsForLocation:CGPointMake(384, 500) direction:1]; 
        [[theValue([bullets count]) should] equal:theValue(4)];
    });
    
});


SPEC_END