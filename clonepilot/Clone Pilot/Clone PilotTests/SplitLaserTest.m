#import "Kiwi.h"
#import "SplitLaser.h"
#import "Bullet.h"
#import "VRGeometry.h"

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
    
    it(@"should fire in a split pattern", ^ {
        NSArray *bullets = [w newBulletsForLocation:sl direction:1];
        CGPoint t1 = CGPointMake(sl.x-w.speed, sl.y + (2.8*w.speed));
        CGPoint vel1 = GetAngle(sl, t1);
        vel1 = MultipliedPoint(vel1, w.speed);
        
        CGPoint t2 = CGPointMake(sl.x+w.speed, sl.y + (2.8*w.speed));
        CGPoint vel2 = GetAngle(sl, t2);
        vel2 = MultipliedPoint(vel2, w.speed);
        
        Bullet *b1 = [bullets objectAtIndex:0];
        Bullet *b2 = [bullets objectAtIndex:1];
        
        [[theValue(b1.vel.x) should] equal:theValue(vel1.x)];
        [[theValue(b1.vel.y) should] equal:theValue(vel1.y)];        

        [[theValue(b2.vel.x) should] equal:theValue(vel2.x)];
        [[theValue(b2.vel.y) should] equal:theValue(vel2.y)];   
    });
});

SPEC_END