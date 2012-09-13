#import "Kiwi.h"
#import "QPBattlefield.h"
#import "QuantumPilotLayer.h"

SPEC_BEGIN(QPBattlefieldStartingTests)

describe(@"Quantum Pilot Battlefield Starting Tests", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    });
    
    it(@"should begin in title state", ^{
        [[theValue([[[f currentState] class] isSubclassOfClass:[QPBFTitleState class]]) should] beTrue];
    });
    
    it(@"should not change state with an empty press", ^{
        QPBFState *s = f.currentState;
        [f addTouch:ccp(500,500)]; 
        [[theValue([f currentState]) should] equal:theValue(s)];
    });
    
    it(@"should change into drawing state when tapping on ship", ^{
        [f addTouch:[f player].l];
        [[theValue([[[f currentState] class] isSubclassOfClass:[QPBFDrawingState class]]) should] beTrue];
    });
});

SPEC_END