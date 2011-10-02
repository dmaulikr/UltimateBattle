#import "Kiwi.h"
#import "BulletHellBattlefield.h"

SPEC_BEGIN(BulletHellBattleField)

describe(@"Foobar", ^{
    __block BulletHellBattleField *f;
    
    beforeEach(^{
        f = [[[BulletHellBattlefield alloc] init] autorelease];        
    });
    
    it(@"should initialize a bullet hell battlefield", ^{
        [[f bullets] shouldNotBeNil];
    });
    
});

SPEC_END