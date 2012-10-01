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
    

    
});

SPEC_END