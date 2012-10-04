#import "QuantumKiwi.h"

SPEC_BEGIN(QPBattlefieldScoringStateTests)

describe(@"Quantum Pilot Battlefield Scoring State Tests", ^{
    __block QPBattlefield *f;
    
    ActionBlock fireFirstBullet = ^{
        [f addTouch:ccp(f.player.l.x, f.player.l.y)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x - 5, f.playerTouch.y + 5)];
        [f tick];
        [f moveTouch:ccp(f.playerTouch.x + 2, f.playerTouch.y + 8)];
        [f tick];
        [f endTouch:f.playerTouch];
        [f tick];
        [f addTouch:ccp(500,500)];
        [f tick];
    };
    
    ActionBlock waitForFirstCloneKill = ^{
        Bullet *firstBullet = (Bullet *)[f.bullets objectAtIndex:0];
        float bulletSpeed = firstBullet.vel.y;
        float distance = fabsf([f firstClone].l.y -  firstBullet.l.y);
        
        int expectedTicks = ceil(distance / fabsf(bulletSpeed));
        
        [f addTouch:f.player.l];
        for (int i = 0; i < expectedTicks; i++) {
            [f tick];
        }
        [f endTouch:f.player.l];
        [f tick];
        
        for (int i = 0; i < expectedTicks; i++) {
            [f tick];
        }
    };
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    });

    it(@"should calculate time bonus", ^{
        fireFirstBullet();
        waitForFirstCloneKill();
        QPBFScoringState *scoringState = (QPBFScoringState *)[f currentState];
        NSInteger expectedTimeBonus = (QPBF_MAX_TIME - f.time) * QPBF_TIME_BONUS_MODIFIER;
        ve([scoringState timeBonus], expectedTimeBonus);
    });
    
    it(@"should calculate accuracy bonus from shots fired and hits with perfect accuracy", ^{
        fireFirstBullet();
        waitForFirstCloneKill();
        
        ve([f shotsFired], 1);
        ve([f hits], 1);
        
        float accuracy = [f hits] / [f shotsFired];
        NSInteger expectedAccuracyBonus = QPBF_ACCURACY_BONUS_MODIFIER * accuracy;
        expectedAccuracyBonus = ceilf(expectedAccuracyBonus) * QPBF_ACCURACY_PERFECT_BONUS_MULTIPLIER;
        
        QPBFScoringState *scoringState = (QPBFScoringState *)[f currentState];
        ve([scoringState accuracyBonus], expectedAccuracyBonus);
    });
    
    it(@"should calculate accuracy bonus from shots fired and hits with imperfect accuracy", ^{
        fireFirstBullet();
        [f addTouch:ccp(500,500)];
        [f tick];
        waitForFirstCloneKill();
        
        ve([f shotsFired], 2);
        ve([f hits], 1);
        
        float accuracy = [f hits] / [f shotsFired];
        NSInteger expectedAccuracyBonus = QPBF_ACCURACY_BONUS_MODIFIER * accuracy;
        
        QPBFScoringState *scoringState = (QPBFScoringState *)[f currentState];
        ve([scoringState accuracyBonus], expectedAccuracyBonus);
    });
    
    it(@"should track time spent in scoring state", ^{
        fireFirstBullet();
        waitForFirstCloneKill();
        QPBFScoringState *scoringState = (QPBFScoringState *)[f currentState];
        NSInteger scoringTime = scoringState.scoringStateTime;
        [f tick];
        ve(scoringState.scoringStateTime, scoringTime + 1);
    });
    
    it(@"should show scoring labels in the Quantum Pilot Battlefield Layer", ^{
        fireFirstBullet();
        waitForFirstCloneKill();
        QPBFScoringState *scoringState = (QPBFScoringState *)[f currentState];
        ve([[scoringState scoreDisplay] class], [QPScoreDisplay class]);
        ve(scoringState.scoreDisplay.parent == f.layer, TRUE);
    });

});

SPEC_END