#import "Kiwi.h"
#import "QPBattlefield.h"
#import "QuantumPilotLayer.h"

SPEC_BEGIN(QPBattlefieldDrawingStateTests)

describe(@"Quantum Pilot Battlefield Drawing State Tests", ^{
    __block QPBattlefield *f;
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
    }); 
    
    it(@"should set offset from a ship on press", ^{
        float xOffset = 15;
        float yOffset = 13;
        CGPoint closeToPlayer = ccp(f.player.l.x + xOffset, f.player.l.y - yOffset);
        [f addTouch:closeToPlayer];
        [[theValue([f touchPlayerOffset].x) should] equal:theValue(xOffset)];
        [[theValue([f touchPlayerOffset].y) should] equal:theValue(-yOffset)];  
    });
});

SPEC_END