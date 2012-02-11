#import "Kiwi.h"
#import "BulletHellBattlefield.h"
#import "SingleLaser.h"
#import "TriLaser.h"
#import "QPBulletCollisionModifier.h"
#import "VRGeometry.h"
#import "TriLaserBullet.h"

SPEC_BEGIN(QPBulletCollisionModifierTest)

describe(@"QPBulletCollisionModifierTest", ^{
    __block BulletHellBattlefield *f;
    __block SingleLaser *w1;
    __block TriLaser *w2;
    
    beforeEach(^{
        f = [[[BulletHellBattlefield alloc] init] autorelease];
        [f addBattlefieldModifier:[[[QPBulletCollisionModifier alloc] init] autorelease]];
        w1 = [[[SingleLaser alloc] init] autorelease];
        w2 = [[[TriLaser alloc] init] autorelease];
    });
    
    context(@"Colliding bullets in a battlefield",^{
        it(@"should not collide bullets of the same class",^{
            Bullet *b1 = [[w1 newBulletsForLocation:CGPointMake(384,800) direction:1] objectAtIndex:0];
            Bullet *b2 = [[w1 newBulletsForLocation:CGPointMake(384,1000) direction:-1] objectAtIndex:0];
            
            [f addBullet:b1];
            [f addBullet:b2];
            
            while (![b1 isColliding:b2]) {
                [f tick];
            }
            
            [[theValue([b1 finished]) should] beFalse];
            [[theValue([b2 finished]) should] beFalse];            
            
        });
        
        it(@"should collide and destroy bullets of different classes", ^{
            Bullet *b1 = [[w1 newBulletsForLocation:CGPointMake(384,800) direction:1] objectAtIndex:0];
            TriLaserBullet *b2 = [[w2 newBulletsForLocation:CGPointMake(384,1000) direction:-1] objectAtIndex:0];
            
            [f addBullet:b1];
            [f addBullet:b2];
            
            while(![b1 isColliding:b2]) {
                [f tick];
            }
            
            [f tick];

            [[theValue([b1 finished]) should] beTrue];
            [[theValue([b2 finished]) should] beTrue];  
            
        });
    });
});

SPEC_END