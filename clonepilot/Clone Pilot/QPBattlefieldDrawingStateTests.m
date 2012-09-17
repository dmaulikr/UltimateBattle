#import "Kiwi.h"
#import "QPBattlefield.h"
#import "QuantumPilotLayer.h"
#import "ActionBlock.h"

SPEC_BEGIN(QPBattlefieldDrawingStateTests)

describe(@"Quantum Pilot Battlefield Drawing State Tests", ^{
    __block QPBattlefield *f;

    float xTouchOffset = 15;
    float yTouchOffset = -13;
    
    ActionBlock tapCloseToPlayer = ^{
        [f addTouch:ccp(f.player.l.x + xTouchOffset, f.player.l.y + yTouchOffset)];
    };
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    }); 
    
    it(@"should set offset from a ship on press", ^{
        tapCloseToPlayer();
        [[theValue([f touchPlayerOffset].x) should] equal:theValue(xTouchOffset)];
        [[theValue([f touchPlayerOffset].y) should] equal:theValue(yTouchOffset)];  
    });
    
    it(@"should maintain in drawing state on tick forward with no let up", ^{       
        QPBFState *s = f.currentState;
        [f tick];
        [[theValue([f currentState]) should] equal:theValue(s)];
    });
    
  
    it(@"should store a delta of movement zero when touch does not move on tick", ^{
        tapCloseToPlayer();
        [f tick];
        [[theValue([f xDelta:0]) should] equal:theValue(0)];
        [[theValue([f yDelta:0]) should] equal:theValue(0)];        
        [f tick];
        [[theValue([f xDelta:1]) should] equal:theValue(0)];
        [[theValue([f yDelta:1]) should] equal:theValue(0)];        
    });
    
    it(@"should track current player touch", ^{
        tapCloseToPlayer();
        [[theValue([f playerTouch].x) should] equal:theValue([f player].l.x + xTouchOffset)];
        [[theValue([f playerTouch].y) should] equal:theValue([f player].l.y + yTouchOffset)];        
    });
    
    it(@"should increase drawing iteration on tick", ^{
        tapCloseToPlayer();
        NSInteger i = f.drawingIteration; 
        [f tick];
        [[theValue(f.drawingIteration) should] equal:theValue(i+1)];
    });
    
    it(@"should store delta x/y when touch changes location on tick", ^{
        tapCloseToPlayer();
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 5, f.playerTouch.y - 6)];
        [f tick];
        [[theValue([f xDelta:1]) should] equal:theValue(5)];
        [[theValue([f yDelta:1]) should] equal:theValue(-6)];        
    });
    
    it(@"should enter fighting state on let up", ^{
        tapCloseToPlayer();
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 5, f.playerTouch.y - 6)];
        [f tick];
        [f endTouch:f.playerTouch];
        [[theValue([f currentState]) should] equal:theValue([f fightingState])];
    });
    
    
    
    
    
    
    
    
    
    
});

SPEC_END