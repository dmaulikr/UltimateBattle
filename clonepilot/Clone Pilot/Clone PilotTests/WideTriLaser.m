#import "Kiwi.h"
#import "WideTriLaser.h"
#import "Bullet.h"

SPEC_BEGIN(WideTriLaserTest)

describe(@"WideTri Laser Test", ^ {
    __block WideTriLaser *w;
    beforeEach(^{
        w = [[[WideTriLaser alloc] init] autorelease];
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
        [[theValue(b2.vel.x) should] equal:theValue(-3)];
        [[theValue(b3.vel.x) should] equal:theValue(3)];
    });
    
});

SPEC_END
