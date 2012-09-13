#import "Kiwi.h"
#import "QPBattlefield.h"
#import "QuantumPilotLayer.h"
#import "ActionBlock.h"

SPEC_BEGIN(QPBattlefieldDrawingStateTests)

describe(@"Quantum Pilot Battlefield Drawing State Tests", ^{
    __block QPBattlefield *f;
    
    ActionBlock tapCloseToPlayer = ^{
        [f addTouch:ccp(f.player.l.x + 15, f.player.l.y - 13)];
    };
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
    }); 
    
    it(@"should set offset from a ship on press", ^{
        float xOffset = 15;
        float yOffset = -13;
        CGPoint closeToPlayer = ccp(f.player.l.x + xOffset, f.player.l.y + yOffset);
        [f addTouch:closeToPlayer];
        [[theValue([f touchPlayerOffset].x) should] equal:theValue(xOffset)];
        [[theValue([f touchPlayerOffset].y) should] equal:theValue(yOffset)];  
    });
    
    it(@"should maintain in drawing state on tick forward with no let up", ^{
       
        QPBFState *s = f.currentState;
        [f tick];
        [[theValue([f currentState]) should] equal:theValue(s)];
    });
    
    it(@"should revert to paused state on tick forward with let up", ^{
        tapCloseToPlayer();
        [f tick];
        [f endTouch:f.player.l];
        [[theValue([f currentState]) should] equal:theValue([f pausedState])];
    });
    
});

SPEC_END