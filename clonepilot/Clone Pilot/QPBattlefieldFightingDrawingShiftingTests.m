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
    
    it(@"should remove deltas fought through and shift remaining deltas", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 2, f.playerTouch.y + 8)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 13, f.playerTouch.y - 11)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 9, f.playerTouch.y - 6)];
        [f tick];
        [f endTouch:f.playerTouch];

        [f tick];
        [f tick];
        
        CGPoint zeroDelta   = ccp([f xDelta:0], [f yDelta:0]);
        CGPoint oneDelta    = ccp([f xDelta:1], [f yDelta:1]);
        CGPoint twoDelta    = ccp([f xDelta:2], [f yDelta:2]);
        CGPoint threeDelta  = ccp([f xDelta:3], [f yDelta:3]);
        
        [f addTouch:f.player.l];
        //tick into drawing state
        NSLog(@"FIGHTING ITERATION :%d", [f fightingIteration]);
        [f tick];
        NSLog(@"FIGHTING ITERATION :%d", [f fightingIteration]);
        ve([f currentState], [f drawingState]);
        
        CGPoint pausedZeroDelta     = ccp([f xDelta:0], [f yDelta:0]);
        CGPoint pausedOneDelta      = ccp([f xDelta:1], [f yDelta:1]);
        CGPoint pausedTwoDelta      = ccp([f xDelta:2], [f yDelta:2]);
        CGPoint pausedThreeDelta    = ccp([f xDelta:3], [f yDelta:3]);
        
        ve(pausedZeroDelta.x, twoDelta.x);
        ve(pausedZeroDelta.y, twoDelta.y);
        ve(pausedOneDelta.x, threeDelta.x);
        ve(pausedOneDelta.y, threeDelta.y);
        ve(pausedTwoDelta.x, 0);
        ve(pausedTwoDelta.y, 0);
        ve(pausedThreeDelta.x, 0);
        ve(pausedThreeDelta.y, 0);
        
        
        
        
        
    });

    
});

SPEC_END