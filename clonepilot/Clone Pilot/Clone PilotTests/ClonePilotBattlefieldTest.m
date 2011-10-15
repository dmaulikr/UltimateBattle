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
    
    context(@"Leveling", ^{
        it(@"should increase in level when all clones are dead", ^{
            [f startup];
            [[f player] fire];
            for (int i = 0; i < 800; i++) {
//            while ([f livingClones] == 1) {
                [f tick];
            }
            
            [[theValue([f level]) should] equal:theValue(1)];
        });
        
        it(@"should increase number of clones when advancing level", ^{
            [f startup];
            
            [[f player] fire];
            while ([f livingClones] == 1) {
                [f tick];
            }
            [[theValue([f livingClones]) should] equal:theValue(2)];
        });
    });
    
    context(@"Copying player moves", ^{
        it(@"should copy player moves into a new clone", ^{
            [f startup];
            [f player].t = CGPointMake(250,630);
            [f tick];
            [f tick];
            NSMutableArray *turns = [[[f player] currentMoves] copy];
            [f advanceLevel];
            ClonePilot *nc = [f latestClone];
            NSString *newCloneMoves = [[nc moves] description];
            NSString *oldTurns      = [turns description];
            NSLog(@"old turns: %@",oldTurns);
            NSLog(@"new moves: %@",newCloneMoves);
            
            BOOL result = [oldTurns isEqualToString:newCloneMoves];
            
            [[theValue(result) should] beTrue];
            
            [[theValue([[[f player] currentMoves] count]) should] equal:theValue(0)];
            [turns release];
        });
        
        it(@"should reset clones position", ^ {
            [f startup];
            [f player].t = CGPointMake(250,630);
            [f tick];
            [f tick];
            [f advanceLevel];
            for (ClonePilot *p in [f clones]) {
                [[theValue(p.l) should] equal:theValue([ClonePilot defaultLocation])];
            }
        });
    });
    
});

SPEC_END