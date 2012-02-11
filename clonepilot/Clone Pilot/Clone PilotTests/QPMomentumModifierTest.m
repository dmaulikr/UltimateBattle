#import "Kiwi.h"
#import "QPMomentumModifier.h"
#import "QPShip.h"
#import "SingleLaser.h"

SPEC_BEGIN(QPMomentumModifierTest)

describe(@"QPMomentumModifier", ^{
    __block QPMomentumModifier *m;
    __block QPShip *s;
    beforeEach(^{
        m = [[[QPMomentumModifier alloc] init] autorelease]; 
        s = [[[QPShip alloc] init] autorelease];
        s.weapon = [[[SingleLaser alloc] init] autorelease];
        s.bulletDelegate = m;
    });
    
    context(@"modifying a fired bullet", ^{
        it(@"should not adjust momentum for a stationary ship", ^{
            s.vel = CGPointZero;
            [s fire];
            Bullet *b = [s.lastBulletsFired objectAtIndex:0];
            [[theValue(b.vel.x) should] equal:theValue(0)];
        });
        
        it(@"should adjust horizontal momentum based on firing ship's velocity", ^{
            s.vel = CGPointMake(-2, -2);
            [s fire];
            Bullet *b = [s.lastBulletsFired objectAtIndex:0];
            [[theValue(b.vel.x) should] beLessThan:theValue(0)];
        });
        
    });
    
});

SPEC_END