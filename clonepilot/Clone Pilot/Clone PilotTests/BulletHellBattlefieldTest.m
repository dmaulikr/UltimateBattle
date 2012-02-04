#import "Kiwi.h"
#import "BulletHellBattlefield.h"
#import "Bullet.h"

SPEC_BEGIN(BulletHellBattleField)

describe(@"Bullet Hell Battlefield", ^{
    __block BulletHellBattlefield *f;
    
    beforeEach(^{
        f = [[[BulletHellBattlefield alloc] init] autorelease];        
    });
    
    context(@"Bullets", ^{
        it(@"should move bullets", ^{
            Bullet *b = [Bullet sampleBullet];
            [f addBullet:b];
            CGPoint oldLocation = b.l;
            [f tick];
            [[theValue(b.l) shouldNot] equal:theValue(oldLocation)];
        });
        
        it(@"should remove finished bullets", ^{
            Bullet *b = [Bullet sampleBullet];
            [f addBullet:b];
            for (int i = 0; i < 102; i++) {
                [f tick];
            }
            [[theValue([[f bullets] containsObject:b]) should] beFalse];
        });
    });
    
});

SPEC_END