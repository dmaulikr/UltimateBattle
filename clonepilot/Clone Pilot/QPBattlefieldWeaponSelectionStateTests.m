#import "QuantumKiwi.h"
#import "QPBFDisplayConstants.h"
#import "SplitLaser.h"

SPEC_BEGIN(QPBattlefieldWeaponSelectionStateTests)

describe(@"Quantum Pilot Battlefield Weapon Selection State Tests", ^{
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
    
    ActionBlock waitForContinueLabel = ^{
        QPBFScoringState *scoringState = (QPBFScoringState *)[f currentState];
        while (scoringState.scoringStateTime < QPBF_SCORING_CONTINUE_DELAY-1) {
            [f tick];
        }
    };

    ActionBlock enterWeaponSelectionState = ^{
        fireFirstBullet();
        waitForFirstCloneKill();
        waitForContinueLabel();
        [f tick];
        [f addTouch:f.player.l];
        [f tick];
    };
    
    beforeEach(^{
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[QPBattlefield alloc] initWithLayer:quantumLayer] autorelease];
        [f startup];
    });
    
    it(@"should have a split laser available for basic weapon", ^{
        enterWeaponSelectionState();
        QPBFWeaponSelectionState *s = (QPBFWeaponSelectionState *)[f currentState];
        ve([s.basicWeapon class], [SplitLaser class]);
    });
    
    it(@"should show weapon selection display in Quantum Pilot layer", ^{
        enterWeaponSelectionState();
        QPBFWeaponSelectionState *s = (QPBFWeaponSelectionState *)[f currentState];
        ve([s.display class] == [QPWeaponSelectionDisplay class], TRUE);
        ve(s.display.parent == f.layer, TRUE);
    });
    
});

SPEC_END