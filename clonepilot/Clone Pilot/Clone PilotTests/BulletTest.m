#import "Kiwi.h"
#import "Bullet.h"
#import "VRGeometry.h"

SPEC_BEGIN(BulletTest)

describe(@"Bullet", ^{
    __block Bullet *b;
    
    beforeEach(^{
       CGPoint vel = CGPointMake(0, -3);
       b = [[[Bullet alloc] initWithVelocity:vel] autorelease];
    });
    
    it(@"should have a velocity when initialized", ^{
        [[theValue(b.vel.y) should] equal:theValue(-3)];
    });  
    
    
    it(@"should move on tick", ^{
        CGPoint oldLocation = b.l;
        [b tick]; 
        
         
    });
    
});


SPEC_END