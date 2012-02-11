#import "Kiwi.h"
#import "QPBulletIdentifierModifier.h"
#import "QPShip.h"
#import "SingleLaser.h"

SPEC_BEGIN(QPBulletIdentifierModifierTest)

describe(@"QPBulletIdentifierModifier", ^{
    __block QPBulletIdentifierModifier *m;
    __block QPShip *s;

    beforeEach(^{
        m = [[[QPBulletIdentifierModifier alloc] init] autorelease]; 
        s = [[[QPShip alloc] init] autorelease];
        s.weapon = [[[SingleLaser alloc] init] autorelease];
        s.bulletDelegate = m;
    });
    
    context(@"firing bullets", ^{
        it(@"should set bullet identifier to ship identifier", ^{
            [s fire];
            Bullet *b = [s.lastBulletsFired objectAtIndex:0];
            [[theValue(b.identifier) should] equal:theValue([s identifier])];
        });
    });
});

SPEC_END