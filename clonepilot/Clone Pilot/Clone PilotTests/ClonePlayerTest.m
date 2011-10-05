#import "Kiwi.h"
#import "ClonePlayer.h"
#import "VRGeometry.h"

SPEC_BEGIN(ClonePlayerTest)

describe(@"Clone Player", ^{
    __block ClonePlayer *p;
    
    beforeEach(^{
        p = [ClonePlayer samplePlayer];
    });
    
    it(@"should accept a target point and move towards the target point", ^{
        p.t = CGPointMake(300, 300);
        float distance = GetDistance(p.l, p.t);
        [p tick];
        [[theValue(GetDistance(p.l,p.t)) should] beLessThan:theValue(distance)];
    });
    
    it(@"should record movements", ^{
        p.t = CGPointMake(300, 300);
        CGPoint velAngle = GetAngle(p.l, p.t);
        [p tick];
        Turn *t = [[[Turn alloc] init] autorelease];
        t.vel = velAngle;
        NSArray *moveArray = [NSArray arrayWithObject:t];
        NSLog(@"moveArray: %@", moveArray);
        NSLog(@"p.currentMoves: %@",p.currentMoves);
        
        Turn *firstSavedTurn = [p.currentMoves objectAtIndex:0];
        [[theValue(t.vel) should] equal:theValue(firstSavedTurn.vel)];
    });
});

SPEC_END