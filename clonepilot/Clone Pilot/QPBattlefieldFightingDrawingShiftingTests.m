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

    it(@"should remove deltas fought through, shift remaining deltas and not fire when tapping on latest expected path", ^{
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
        
        CGPoint twoDelta    = ccp([f xDelta:2], [f yDelta:2]);
        CGPoint threeDelta  = ccp([f xDelta:3], [f yDelta:3]);
        CGPoint fourDelta   = ccp([f xDelta:4], [f yDelta:4]);
        CGPoint fiveDelta   = ccp([f xDelta:5], [f yDelta:5]);
        [f addTouch:[f latestExpectedPathPoint]];
        
        //tick into drawing state from touch
        [f tick];
        ve([f currentState], [f drawingState]);
        
        CGPoint pausedZeroDelta     = ccp([f xDelta:0], [f yDelta:0]);
        CGPoint pausedOneDelta      = ccp([f xDelta:1], [f yDelta:1]);
        CGPoint pausedTwoDelta      = ccp([f xDelta:2], [f yDelta:2]);
        CGPoint pausedThreeDelta    = ccp([f xDelta:3], [f yDelta:3]);
        
        ve(pausedZeroDelta.x, twoDelta.x);
        ve(pausedZeroDelta.y, twoDelta.y);
        ve(pausedOneDelta.x, threeDelta.x);
        ve(pausedOneDelta.y, threeDelta.y);
        ve(pausedTwoDelta.x, fourDelta.x);
        ve(pausedTwoDelta.y, fourDelta.y);
        ve(pausedThreeDelta.x, fiveDelta.x);
        ve(pausedThreeDelta.y, fiveDelta.y);
        
        ve([f playerIsFiring], NO);
    });
    
    it(@"should clear delta stack when tapping on ship and not fire", ^{
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
        
        [f addTouch:f.player.l];
        [f tick];

        CGPoint zeroDelta   = ccp([f xDelta:0], [f yDelta:0]);
        CGPoint oneDelta   = ccp([f xDelta:1], [f yDelta:1]);
        CGPoint twoDelta    = ccp([f xDelta:2], [f yDelta:2]);
        CGPoint threeDelta  = ccp([f xDelta:3], [f yDelta:3]);
        CGPoint fourDelta   = ccp([f xDelta:4], [f yDelta:4]);
        CGPoint fiveDelta   = ccp([f xDelta:5], [f yDelta:5]);
        
        ve(zeroDelta.x, 0);
        ve(zeroDelta.y, 0);
        ve(oneDelta.x, 0);
        ve(oneDelta.y, 0);
        ve(twoDelta.x, 0);
        ve(twoDelta.y, 0);
        ve(threeDelta.x, 0);
        ve(threeDelta.y, 0);
        ve(fourDelta.x, 0);
        ve(fourDelta.y, 0);
        ve(fiveDelta.x, 0);
        ve(fiveDelta.y, 0);
        
        ve([f playerIsFiring], NO);
        
    });
    
});

SPEC_END