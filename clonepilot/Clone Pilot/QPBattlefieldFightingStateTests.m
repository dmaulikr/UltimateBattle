#import "QuantumKiwi.h"

SPEC_BEGIN(QPBattlefieldFightingStateTests)

describe(@"Quantum Pilot Battlefield Fighting State Tests", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    }); 

    it(@"should track fighting iterations", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)]; 
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f endTouch:f.playerTouch];
        [[theValue([f fightingIteration]) should] equal:theValue(0)];
        [f tick];
        [[theValue([f fightingIteration]) should] equal:theValue(1)];
    });
    
    it(@"should set velocity and move by delta x and delta y", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)]; 
        [f tick];
        CGPoint movePoint = ccp(f.playerTouch.x - 50, f.playerTouch.y + 53);
        [f moveTouch:movePoint];
        [f tick];
        [f endTouch:f.playerTouch];
        [f tick];
        [[theValue([[f player] vel].x) should] equal:theValue(0)];
        [f tick];
        CGPoint direction = GetAngle([f player].l, movePoint);
        [[theValue([[f player] vel].x) should] equal:theValue(direction.x * [f player].speed)];
    });
    
    it(@"should enter fighting state when drawing iterations exceeds max", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)]; 
        [f tick];
        while (f.drawingIteration < QPBF_MAX_DRAWING_FRAMES) {
            [f tick];
        }
        [f tick];
        [[theValue([f currentState]) should] equal:theValue([f fightingState])];
    });

    it(@"should enter paused state when current iteration reaches max deltas", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)]; 
        [f tick];
        [f tick];
        [f tick];
        [f endTouch:f.playerTouch];
        [f tick];
        [f tick];
        [f tick];
        ve([f currentState], [f pausedState])
    });

});

SPEC_END