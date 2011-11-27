#import "Kiwi.h"
#import "QuadLaser.h"
#import "Bullet.h"
#import "VRGeometry.h"

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
    
    it(@"should shoot in a 4 way pattern", ^{
        CGPoint sl = CGPointMake(384, 500);
        NSArray *bullets = [w newBulletsForLocation:sl direction:1];
        Bullet *b = [bullets objectAtIndex:0];        
        Bullet *b2 = [bullets objectAtIndex:1];
        Bullet *b3 = [bullets objectAtIndex:2];
        Bullet *b4 = [bullets objectAtIndex:3];
        
        CGPoint target = CGPointMake(sl.x-1,sl.y+4);
        CGPoint bAngle = GetAngle(sl, target);
        CGPoint vector = MultipliedPoint(bAngle, w.speed);
        [[theValue(b.vel.x) should] equal:theValue(vector.x)];
        [[theValue(b.vel.y) should] equal:theValue(vector.y)];
        
        CGPoint target2 = CGPointMake(sl.x - 3,sl.y+4);
        CGPoint b2Angle = GetAngle(sl, target2);
        CGPoint vector2 = MultipliedPoint(b2Angle, w.speed);
        
        [[theValue(b2.vel.x) should] equal:theValue(vector2.x)];
        [[theValue(b2.vel.y) should] equal:theValue(vector2.y)];        
        
        CGPoint target3 = CGPointMake(sl.x+1,sl.y+4);
        CGPoint b3Angle = GetAngle(sl, target3);
        CGPoint vector3 = MultipliedPoint(b3Angle, w.speed);
        [[theValue(b3.vel.x) should] equal:theValue(vector3.x)];
        [[theValue(b3.vel.y) should] equal:theValue(vector3.y)];        
       
        CGPoint target4 = CGPointMake(sl.x+3,sl.y+4);
        CGPoint b4Angle = GetAngle(sl, target4);
        CGPoint vector4 = MultipliedPoint(b4Angle, w.speed);
        [[theValue(b4.vel.x) should] equal:theValue(vector4.x)];
        [[theValue(b4.vel.y) should] equal:theValue(vector4.y)];    
    });
    
});


SPEC_END