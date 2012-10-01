#import "QuantumKiwi.h"
#import "QuantumPilot.h"

SPEC_BEGIN(QPBattlefieldBasicCombatTests)

describe(@"Quantum Pilot Battlefield Basic Combat Tests", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    });

    it(@"should have a quantum pilot as its player", ^{
        [[theValue([[[f player] class] isSubclassOfClass:[QuantumPilot class]]) should] beTrue];
    });
    
    it(@"should add a bullet when firing", ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 2, f.playerTouch.y + 8)];
        [f endTouch:f.playerTouch];
        [f tick];
        ve([f currentState], [f fightingState]);
        ve(f.bullets.count, 0);
        [f addTouch:ccp(500,500)];
        [f tick];
        ve(f.bullets.count, 1);
    });

    //bullets fired
    //kill enemy
    //cloning
    //score
    
});

SPEC_END