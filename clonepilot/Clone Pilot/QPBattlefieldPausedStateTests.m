#import "QuantumKiwi.h"

SPEC_BEGIN(QPBattlefieldPausedStateTests)

describe(@"Quantum Pilot Battlefield Paused State Tests", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    }); 
    
    it(@"should have empty deltas after fighting as long as drawing", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 2, f.playerTouch.y + 8)];
        [f tick];
        [f endTouch:f.playerTouch];
        [f tick];
        [f tick];
        [f tick];
        
        [f tick];

        ve([f xDelta:0], 0);
        ve([f yDelta:0], 0);
        ve([f xDelta:1], 0);
        ve([f yDelta:1], 0);
        ve([f xDelta:2], 0);
        ve([f yDelta:2], 0);
    });
    
    it(@"should shift to drawing state and apply touch on touch ship", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 2, f.playerTouch.y + 8)];
        [f tick];
        [f endTouch:f.playerTouch];
        [f tick];
        [f tick];
        [f tick];
        
        [f tick];

        [f addTouch:ccp(f.player.l.x + 15, f.player.l.y - 11)];
        ve([f currentState], [f drawingState]);
        ve([f playerTouch].x, f.player.l.x + 15);
        ve([f playerTouch].y, f.player.l.y - 11);
        
    });
    
});

SPEC_END