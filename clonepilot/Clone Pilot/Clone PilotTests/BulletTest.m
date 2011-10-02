#import "Kiwi.h"
#import "Bullet.h"
#import "VRGeometry.h"

SPEC_BEGIN(BulletTest)

describe(@"Bullet", ^{
    __block Bullet *b;
    
    beforeEach(^{
        CGPoint start = CGPointMake(100, 100);
        CGPoint vel = CGPointMake(0, -3);
        b = [[[Bullet alloc] initWithLocation:start velocity:vel] autorelease];
    });
    
    it(@"should have a location when initialized", ^{
        [[theValue(b.l) shouldNot] equal:theValue(CGPointZero)];
    });
    
    it(@"should have a vertical velocity when initialized", ^{
        [[theValue(b.vel.y) shouldNot] equal:theValue(0)];
    });  
    
    
    it(@"should move on tick", ^{
        CGPoint oldLocation = b.l;
        [b tick]; 
        [[theValue(b.l) shouldNot] equal:theValue(oldLocation)];
    });
    
    it(@"should mark itself as deallocatable when out of bounds", ^{
        for (int i = 0; i < 102; i++) {
            [b tick];
        }
        [[theValue(b.finished) should] equal:theValue(YES)];
    });
    
});


SPEC_END