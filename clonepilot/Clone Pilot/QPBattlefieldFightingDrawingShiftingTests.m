#import "QuantumKiwi.h"

SPEC_BEGIN(QPBattlefieldFightingDrawingShiftingStateTests)

describe(@"Quantum Pilot Battlefield Fighting Drawing Shifting State Tests", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    });
    
    it(@"should re-enter drawing state when ship tapped while fighting", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 2, f.playerTouch.y + 8)];
        [f tick];
        [f endTouch:f.playerTouch];
        
        [f tick];
        [f tick];
        
        [f addTouch:f.player.l];
        [f tick];
        ve([f currentState], [f drawingState]);
    });
    
    it(@"should set offset when shifting back into drawing state", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 2, f.playerTouch.y + 8)];
        [f tick];
        [f endTouch:f.playerTouch];
        
        [f tick];
        [f tick];
        
        CGPoint offset = ccp(f.player.l.x + 10, f.player.l.y - 15);
        [f addTouch:offset];
        [f tick];
        
        ve([f touchPlayerOffset].x, 10);
        ve([f touchPlayerOffset].y, -15);
    });

    it(@"should reset drawing iteration when tapping on ship during fighting", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f tick];
        [f tick];
        [f tick];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 2, f.playerTouch.y + 8)];
        [f tick];
        [f endTouch:f.playerTouch];
       
        ve([f currentState], [f fightingState]);
        [f tick];
        [f tick];
        
        [f addTouch:f.player.l];
        [f tick];
        ve(f.drawingIteration, f.fightingIteration);
    });
    
    it(@"should recalculate expected location when tapping on ship during fighting", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f endTouch:f.playerTouch];
        
        [f tick];
        [f tick];
        [f addTouch:f.player.l];
        [f tick];
        
        ve(f.latestExpectedX, f.player.l.x);
        ve(f.latestExpectedY, f.player.l.y);
    });
    
});

SPEC_END