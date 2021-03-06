#import "QuantumKiwi.h"

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
        tapCloseToPlayer();
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
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 10, f.playerTouch.y + 5)];
        [f tick];
        [[theValue([f playerTouch].x) should] equal:theValue([f player].l.x + xTouchOffset + 10)];
        [[theValue([f playerTouch].y) should] equal:theValue([f player].l.y + yTouchOffset + 5)];
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
        ve([f xDelta:0], 0);
        ve([f yDelta:0], 0);
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
    
    it(@"should know latest expected path point", ^{
        [f addTouch:f.player.l];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 5, f.playerTouch.y + 6)];
        [f tick];
        ve(f.latestExpectedX, f.player.l.x + 5);
        ve(f.latestExpectedY, f.player.l.y + 6);
        [f moveTouch:ccp(f.playerTouch.x + 7, f.playerTouch.y - 3)];
        [f tick];
        ve(f.latestExpectedX, f.player.l.x + 12);
        ve(f.latestExpectedY, f.player.l.y + 3);
    });
    
    it(@"should reset last player touch when touch moves", ^{
        [f addTouch:f.player.l];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 5, f.playerTouch.y + 6)];
        [f tick];
        CGPoint newTouch = ccp(f.playerTouch.x + 7, f.playerTouch.y + 7);
        [f moveTouch:newTouch];
        [f tick];
        ve(f.lastPlayerTouch, newTouch);
    });
});

SPEC_END