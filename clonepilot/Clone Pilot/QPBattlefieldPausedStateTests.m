#import "QuantumKiwi.h"

SPEC_BEGIN(QPBattlefieldPausedStateTests)

describe(@"Quantum Pilot Battlefield Paused State Tests", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    }); 
    
    it(@"should shift delta stores down towards zero with difference equal to iteration difference", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f endTouch:f.playerTouch];
        ve([f drawingIteration], 2);
        [f tick];
        [f tick];        
        ve([f currentState], [f pausedState]);
        CGPoint oneIndex = ccp([f xDelta:1], [f yDelta:1]);
        NSLog(@"Paused");
        NSLog(@"fighting iteration: %d", [f fightingIteration]);
        for (int i = 0; i < 3; i++) {
            NSLog(@"%d: xDelta: %f", i, [f xDelta:i]);
            NSLog(@"%d: yDelta: %f", i, [f yDelta:i]);
        }
        NSLog(@"First pause state tick");
        [f tick];
        NSLog(@"fighting iteration: %d", [f fightingIteration]);
        for (int i = 0; i < 3; i++) {
            NSLog(@"%d: xDelta: %f", i, [f xDelta:i]);
            NSLog(@"%d: yDelta: %f", i, [f yDelta:i]);
        }
        NSLog(@"Second pause state tick");
        [f tick];
        NSLog(@"fighting iteration: %d", [f fightingIteration]);
        for (int i = 0; i < 3; i++) {
            NSLog(@"%d: xDelta: %f", i, [f xDelta:i]);
            NSLog(@"%d: yDelta: %f", i, [f yDelta:i]);
        }
        CGPoint pausedZeroIndex = ccp([f xDelta:0], [f yDelta:0]);
        CGPoint pausedOneIndex = ccp([f xDelta:1], [f yDelta:1]);
        ve(pausedZeroIndex.x, oneIndex.x);
        ve(pausedZeroIndex.y, oneIndex.y);
        ve(pausedOneIndex.x, 0);
        ve(pausedOneIndex.y, 0);
        
    });
    
});

SPEC_END