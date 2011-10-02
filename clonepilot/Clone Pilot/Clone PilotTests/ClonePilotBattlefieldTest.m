#import "Kiwi.h"
#import "ClonePilotBattlefield.h"

SPEC_BEGIN(ClonePilotBattlefieldTest)

describe(@"Clone Pilot Battlefield", ^{
    __block ClonePilotBattlefield *f;
    
    beforeEach(^{
        f = [[[ClonePilotBattlefield alloc] init] autorelease];
    });
    
    context(@"Initialization", ^{
        it(@"should have a player with a location", ^{
            [theObject([f player]) shouldNotBeNil];
        });
        
        
        
    });
    
});

SPEC_END