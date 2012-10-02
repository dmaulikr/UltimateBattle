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
        [f endTouch:f.playerTouch];
        [f tick];
        ve([f currentState], [f fightingState]);
        ve(f.bullets.count, 0);
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
    
    it(@"should shift to scoring state when bullet hits", ^{
        fireFirstBullet();
        waitForFirstCloneKill();
        ve([f currentState], [f scoringState]);
    });
    
    
    //bullets fired
    //kill enemy
    //cloning
    //score
    
});

SPEC_END