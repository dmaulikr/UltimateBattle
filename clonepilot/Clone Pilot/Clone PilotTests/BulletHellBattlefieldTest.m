#import "Kiwi.h"
#import "BulletHellBattlefield.h"
#import "Bullet.h"

SPEC_BEGIN(BulletHellBattleField)

describe(@"Foobar", ^{
    __block BulletHellBattleField *f;
    
    beforeEach(^{
        f = [[[BulletHellBattlefield alloc] init] autorelease];        
    });
    
    it(@"should initialize a bullet hell battlefield", ^{
        [theObject([f bullets]) shouldNotBeNil];
    });
    
    it(@"should move bullets within itself", ^{
        Bullet *b = [Bullet sampleBullet];
        [f addBullet:b];
        CGPoint oldLocation = b.l;
        [f tick];
        [[theValue(b.l) shouldNot] equal:theValue(oldLocation)];
    });
    
    it(@"should remove finished bullets from itself", ^{
        Bullet *b = [Bullet sampleBullet];
        [f addBullet:b];
        for (int i = 0; i < 102; i++) {
            [f tick];
        }
        [[theValue([[f bullets] containsObject:b]) shouldNot] beTrue];
    });
    
});

SPEC_END