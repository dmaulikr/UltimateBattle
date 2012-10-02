#import "QuantumKiwi.h"
#import "QuantumPilot.h"

SPEC_BEGIN(QPBattlefieldBasicCombatTests)

describe(@"Quantum Pilot Battlefield Basic Combat Tests", ^{
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
    
    it(@"should add a bullet when firing", ^{
        fireFirstBullet();
        ve(f.bullets.count, 1);
    });
    
    it(@"should kill the enemy when bullet hits", ^{
        fireFirstBullet();
        waitForFirstCloneKill();
        ve([f livingClones], 0);
    });
    
    describe(@"Quantum Pilot Battlefield Cloning State", ^{
        it(@"should shift to scoring state after cloning", ^{
            fireFirstBullet();
            waitForFirstCloneKill();
            [f tick];
            ve([f currentState], [f scoringState]);
        });
        
        it(@"should clone deltas", ^{
            fireFirstBullet();
            waitForFirstCloneKill();
            [f tick];
            QuantumClone *c = [f newestClone];
            
            for (int i = 0; i < f.fightingIteration; i++) {
                ve([c xDelta:i], [f xDelta:i]);
                ve([c yDelta:i], [f yDelta:i]);
                ve([c fireDeltaAtIndex:i], [f fireDeltaAtIndex:i]);
            }
                ve([[c weapon] class], [[[f pilot] weapon] class]);
        });
        
        it(@"should have a new clone", ^{
            NSInteger clones = f.clones.count;
            fireFirstBullet();
            waitForFirstCloneKill();
            ve(f.clones.count, clones+1);
        });
        
    });
    
});

SPEC_END