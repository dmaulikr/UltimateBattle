#import "Kiwi.h"
#import "ClonePlayer.h"
#import "VRGeometry.h"
#import "SingleLaser.h"

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
        p.t = CGPointMake(0, 0);
        
        Turn *emptyTurn = [[[Turn alloc] init] autorelease];
        emptyTurn.vel = CGPointZero;
        
        Turn *turn1 = [[[Turn alloc] init] autorelease];
        turn1.vel = GetAngle(p.l, p.t);
        turn1.vel = MultipliedPoint(turn1.vel, p.speed);
        [p tick];        
        
        Turn *turn2 = [[[Turn alloc] init] autorelease];
        turn2.vel = GetAngle(p.l, p.t);
        turn2.vel = MultipliedPoint(turn2.vel, p.speed);
        [p tick];        
        
        NSArray *moveArray = [NSArray arrayWithObjects:emptyTurn, turn1, turn2, nil];
        
        BOOL result = YES;
        
        for (int i = 0; i < [moveArray count]; i++) {
            Turn *t1 = [moveArray objectAtIndex:i];
            Turn *t2 = [p.currentMoves objectAtIndex:i];
            
            if (![[t1 description] isEqualToString:[t2 description]]) {
                result = NO;
            }
        }
        
        [[theValue(result) should] beTrue];
    });
    
    it(@"should record stationary turns", ^{
        p.t = CGPointMake(300, 300);
        
        Turn *emptyTurn = [[[Turn alloc] init] autorelease];
        emptyTurn.vel = CGPointZero;
        
        Turn *turn1 = [[[Turn alloc] init] autorelease];
        turn1.vel = GetAngle(p.l, p.t);
        turn1.vel = MultipliedPoint(turn1.vel, p.speed);
        
        [p tick];
        
        p.t = p.l;
        Turn *turn2 = [[[Turn alloc] init] autorelease];
        turn2.vel = GetAngle(p.l, p.t);
        turn2.vel = MultipliedPoint(turn2.vel, p.speed);
        [p tick];
        
        NSArray *moveArray = [NSArray arrayWithObjects:emptyTurn, turn1, turn2, nil];
        
        BOOL result = YES;
        
        for (int i = 0; i < [moveArray count]; i++) {
            Turn *t1 = [moveArray objectAtIndex:i];
            Turn *t2 = [p.currentMoves objectAtIndex:i];
            
            if (![[t1 description] isEqualToString:[t2 description]]) {
                result = NO;
            }
        }
        
        [[theValue(result) should] beTrue];
    });
    
    it(@"should respond to fire command", ^{
        [p fire];
        [[theValue([p isFiring]) should] beTrue];
    });
    
    it(@"should reset firing state after tick",^ {
        [p fire];
        [p tick];
        [[theValue([p isFiring]) should] beFalse];  
    });
    
    it(@"should start with a default weapon", ^{
        BOOL result = [[[p weapon] description] isEqualToString:@"SingleLaser"];
        [[theValue(result) should] beTrue];
    });
    
    
});

SPEC_END