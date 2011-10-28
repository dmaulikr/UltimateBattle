#import "Kiwi.h"
#import "ClonePilotBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"

SPEC_BEGIN(ClonePilotBattlefieldTest)

describe(@"Clone Pilot Battlefield", ^{
    __block ClonePilotBattlefield *f;
    
    beforeEach(^{
        f = [[[ClonePilotBattlefield alloc] init] autorelease];
    });
    
    context(@"Initialization", ^{
        it(@"should have a player with a location", ^{
            [[theValue([[[f player ]class] isSubclassOfClass:[ClonePlayer class]]) should] beTrue];
        });
    });
    
    context(@"Player shooting bullets", ^ {
        it(@"should shoot get a bullet from the player", ^ {
            [[f player] fire];
            [[f player] tick];
            [[theValue([[f bullets] count]) should] equal:theValue(1)];
        });
        
        it(@"should move player fired bullets", ^ {
            [[f player] fire];
            CGPoint oldLocation = ((Bullet *)[[f bullets] lastObject]).l;
            [f tick];
            CGPoint newLocation = ((Bullet *)[[f bullets] lastObject]).l;
            [[theValue(oldLocation) shouldNot] equal:theValue(newLocation)];
        });
    });
    
    context(@"First phase", ^{ 
        it(@"should have one enemy ship", ^{
            [f startup];
            [[theValue([[f clones] count]) should] equal:theValue(1)];
        });
        
        it(@"should be positioned across from the player", ^{
            [f startup];
            ClonePilot *p = [[f clones] lastObject];
            [[theValue(p.l.x) should] equal:theValue([[f player] l].x)];
        });
        
        it(@"should have no moves in the first clone", ^{
            [f startup];
            ClonePilot *p = [[f clones] lastObject];
            [[theValue([[p moves] count]) should] equal:theValue(0)];
        });
    });
    
//    context(@"Basic combat", ^{
//        it(@"should collide a bullet with a clone pilot", ^{
//            [f startup];
//            [[f player] fire];
//            for (int i = 0; i < 424; i++) {
//                [f tick];
//            }
//        });
//    });
    
});

SPEC_END