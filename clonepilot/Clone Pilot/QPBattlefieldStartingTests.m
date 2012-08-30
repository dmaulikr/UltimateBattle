#import "Kiwi.h"
#import "QPBattlefield.h"
#import "QuantumPilotLayer.h"

SPEC_BEGIN(QPBattlefieldStartingTests)

describe(@"Quantum Pilot Battlefield", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
    });
    
    it(@"should begin in title state", ^{
        [[theValue([[[f currentState] class] isSubclassOfClass:[QPBFTitleState class]]) should] beTrue];
    });
});

SPEC_END