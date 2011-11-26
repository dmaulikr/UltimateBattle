#import "Kiwi.h"
#import "SingleLaser.h"
#import "Bullet.h"

SPEC_BEGIN(SingleLaserTest)

describe(@"Single Laser Test", ^ {
    __block SingleLaser *w;
    beforeEach(^{
        w = [[[SingleLaser alloc] init] autorelease];
    });

    it(@"should return one bullet", ^{
        NSArray *bullets = [w newBulletsForLocation:CGPointMake(384,300) direction:-1];
        NSLog(@"one bullet");
        [[theValue([bullets count]) should] equal:theValue(1)];
    });
    
    it(@"should have no x velocity", ^{
        NSArray *bullets = [w newBulletsForLocation:CGPointMake(384,300) direction:-1];
        Bullet *b = [bullets lastObject];
        [[theValue(b.vel.x) should] equal:theValue(0)];
    });
    
    it(@"should have y velocity equivilant to weapon speed", ^{
        NSArray *bullets = [w newBulletsForLocation:CGPointMake(384,300) direction:-1];
        Bullet *b = [bullets lastObject];
        [[theValue(b.vel.y) should] equal:theValue([w speed] * -1)]; 
    });
        
});

SPEC_END