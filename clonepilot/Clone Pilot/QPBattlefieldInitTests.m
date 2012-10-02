#import "QuantumKiwi.h"

SPEC_BEGIN(QPBattlefieldInitTests)

describe(@"Quantum Pilot Battlefield Init Tests", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    });

    it(@"should have a quantum pilot as its player", ^{
        ve([[[f player] class] isSubclassOfClass:[QuantumPilot class]], TRUE);
    });
    
    it(@"should have one clone", ^{
        ve(f.clones.count, 1);
    });
    
    it(@"should have zero iteration and events", ^{
        ve(f.drawingIteration, 0)
        ve(f.fightingIteration, 0);
        ve(f.time, 0);
        ve(f.pauses, 0);
        ve(f.shotsFired, 0);
        ve(f.hits, 0);
        
    });
    
});

SPEC_END