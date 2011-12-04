#import "Kiwi.h"
#import "TriLaser.h"
#import "Bullet.h"

SPEC_BEGIN(TriLaserTest)

describe(@"Tri Laser Test", ^ {
    __block TriLaser *w;
    beforeEach(^{
        w = [[[TriLaser alloc] init] autorelease];
    });
    
    it(@"should have three bullets", ^ {
        NSArray *newBullets = [w newBulletsForLocation:CGPointMake(384, 500) direction:-1];
        [[theValue([newBullets count]) should] equal:theValue(3)];
    });
    
    it(@"should have bullets moving in a triangle pattern", ^{
        NSArray *newBullets = [w newBulletsForLocation:CGPointMake(384, 500) direction:-1];
        Bullet *b = [newBullets objectAtIndex:0];
        Bullet *b2 = [newBullets objectAtIndex:1];
        Bullet *b3 = [newBullets objectAtIndex:2];
        
        [[theValue(b.vel.x) should] equal:theValue(0)];
        [[theValue(b2.vel.x) should] equal:theValue(-1)];
        [[theValue(b3.vel.x) should] equal:theValue(1)];
    });
    
});

SPEC_END
