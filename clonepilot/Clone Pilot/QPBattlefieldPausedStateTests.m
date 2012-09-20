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
        
    });
    
});

SPEC_END