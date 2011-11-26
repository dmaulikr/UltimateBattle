#import "Kiwi.h"
#import "ClonePilotBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"
#import "ActionBlock.h"
#import "SideLaserBullet.h"
#import "Bullet.h"
#import "VRGeometry.h"
#import "VRTouch.h"

SPEC_BEGIN(ClonePilotBattlefieldTest)

describe(@"Clone Pilot Battlefield", ^{
    __block ClonePilotBattlefield *f;
    __block CGPoint startingTouch;
    
    ActionBlock kill = ^ {
        int livingClones = [f livingClones];
        
        while ([f livingClones] >= 1) {
            [f tick];
            if ([f livingClones] > livingClones) {
                break;
            }
        }
    };
    
    ActionBlock firstKill = ^{
        [f startup];
        [[f player] fire];
        kill();
    };
    
    ActionBlock oneCloneCycle = ^ {
        ClonePilot *p = [[f clones] objectAtIndex:0];
        NSInteger moveIndex = p.moveIndex;
        [f tick];
        while (moveIndex > 0) {
            [f tick];
        }
    };
    
    ActionBlock newBullet = ^{
        int bullets = [[f bullets] count];
        while ([[f bullets] count] == bullets) {
            [f tick];
        }
    };
    
    ActionBlock playerHit = ^{
        int playerHealth = [[f player] health];
        while ([[f player] health] == playerHealth) {
            [f tick];
        }
    };
    
    ActionBlock firstTouch = ^{
        [f startup];
        [f addTouch:startingTouch];
    };
    
    ActionBlock firstPilotDeath = ^{
        firstKill();
        [f chooseWeapon:0];
        playerHit();
        playerHit();
    };

    beforeEach(^{
        f = [[[ClonePilotBattlefield alloc] init] autorelease];
        startingTouch = CGPointMake(100, 100);
    });
    
    context(@"Initialization", ^{
        it(@"should have a player", ^{
            [[theValue([[[f player] class] isSubclassOfClass:[ClonePlayer class]]) should] beTrue];
        });
    });
    
    context(@"Player shooting bullets", ^ {
        it(@"should shoot get a bullet from the player", ^ {
            [[f player] fire];
            [[f player] tick];
            [[theValue([[f bullets] count]) should] equal:theValue(1)];
        });
        
        it(@"should move player fired bullets", ^ {
            [[f player] fire];
            CGPoint oldLocation = ((Bullet *)[[f bullets] lastObject]).l;
            [f tick];
            CGPoint newLocation = ((Bullet *)[[f bullets] lastObject]).l;
            [[theValue(oldLocation) shouldNot] equal:theValue(newLocation)];
        });
    });
    
    context(@"First phase", ^{ 
        it(@"should have one enemy ship", ^{
            [f startup];
            [[theValue([[f clones] count]) should] equal:theValue(1)];
        });
        
        it(@"should be positioned across from the player", ^{
            [f startup];
            ClonePilot *p = [[f clones] lastObject];
            [[theValue(p.l.x) should] equal:theValue([[f player] l].x)];
        });
        
        it(@"should have no moves in the first clone", ^{
            [f startup];
            ClonePilot *p = [[f clones] lastObject];
            [[theValue([[p moves] count]) should] equal:theValue(0)];
        });
    });
    
    context(@"Leveling", ^{        
        it(@"should increase number of clones when all clones are killed", ^{
            firstKill();
            [[theValue([f livingClones]) should] equal:theValue(2)];
        });
        
        it (@"should reset bullets between levels", ^ {
            [f startup];
            [f tick];
            [[f player] fire];
            kill();
            [f chooseWeapon:0];
            [[theValue([[f bullets] count]) should] equal:theValue(0)]; 
        });
        
    });
    
    context(@"Copying player moves", ^{
        it(@"should copy player moves into a new clone with y inverted", ^{
            [f startup];
            [f player].t = CGPointMake(250,630);
            [f tick];
            [f tick];
            NSMutableArray *turns = [[NSMutableArray alloc] initWithArray:[[f player] currentMoves] copyItems:YES];
            [f advanceLevel];
            ClonePilot *nc = [f firstClone];
            NSString *mirrorDescription = @"";
            for (Turn *t in turns) {
                mirrorDescription = [NSString stringWithFormat:@"%@%@",mirrorDescription,[t mirrorDescription]];
            }
            
            NSString *cloneDescription = @"";
            for (Turn *t in [nc moves]) {
                cloneDescription = [NSString stringWithFormat:@"%@%@",cloneDescription, [t description]];
            }
            
            NSLog(@"old turns: %@", [turns description]);
            NSLog(@"mirroDescription: %@", mirrorDescription);
            NSLog(@"new clone moves: %@", cloneDescription);
            
            BOOL result = [mirrorDescription isEqualToString:cloneDescription];
            
            [[theValue(result) should] beTrue];
            
            [[theValue([[[f player] currentMoves] count]) should] equal:theValue(0)];
            [turns release];
        });
        
        it(@"should reset clones position", ^ {
            [f startup];
            [f player].t = CGPointMake(250,630);
            [[f player] fire];
            kill();
            for (ClonePilot *p in [f clones]) {
                [[theValue(p.l) should] equal:theValue([ClonePilot defaultLocation])];
            }
        });
        
        it(@"should reset player position", ^ {
            [f startup];
            CGPoint startingPosition = [f player].l;
            [[f player] fire];
            [f player].t = CGPointMake(200, 400);
            kill();
            [f chooseWeapon:0];
            [[theValue([f player].l) should] equal:theValue(startingPosition)];
        });
        
        it(@"should copy weapons", ^ {
            [f startup];
            NSString *oldWeapon = [[[f player] weapon] description];
            [f advanceLevel];
            ClonePilot *c = [f firstClone];
            NSString *newWeapon = [[c weapon] description];
            NSLog(@"oldWeapon: %@", oldWeapon);
            NSLog(@"newWeapon: %@", newWeapon);
            BOOL result = [oldWeapon isEqualToString:newWeapon];
            [[theValue(result) should] beTrue];
        });    
    });
    
    context(@"Weapon Selection", ^ {
        it(@"should present choices for weapon selection between levels", ^ {
            firstKill();
            [[theValue([[f weaponChoices] count]) should] beGreaterThan:theValue(1)];
        });
        
        it(@"should advance level when a weapon is chosen", ^{
            firstKill();
            NSInteger level = [f level];
            [f chooseWeapon:0];
            [[theValue(f.level) should] equal:theValue(level+1)];
        });
        
        it(@"should assign the chosen weapon to the player", ^{
            firstKill();
            NSString *newWeapon = [[[f weaponChoices] objectAtIndex:0] description];
            [f chooseWeapon:0];
            NSString *weapon = [f.player.weapon description];
            BOOL result = [weapon isEqualToString:newWeapon];
            [[theValue(result) should] beTrue];
        });
        
        it(@"should have single laser and a non single laser weapon already chosen", ^ {
            [f startup];
            NSArray *chosenWeapons = [f chosenWeapons];
            NSString *w1 = [[chosenWeapons objectAtIndex:0] description];
            NSString *w2 = [[chosenWeapons objectAtIndex:1] description];
            BOOL singleLaserResult  = [w1 isEqualToString:[SingleLaser description]];
            BOOL secondWeaponResult = ![w2 isEqualToString:w1];
            
            [[theValue(singleLaserResult) should] beTrue];
            [[theValue(secondWeaponResult) should] beTrue];
        });
        
        it(@"should remove chosen weapon from weapon choices", ^ {
            firstKill();
            NSArray *availableWeapons = [f weaponChoices];
            NSString *w1 = [[availableWeapons objectAtIndex:0] description];
            [f chooseWeapon:0];
            NSArray *newAvailableWeapons = [f weaponChoices];
            BOOL result = YES;
            for (Weapon *w in newAvailableWeapons) {
                if ([[w description] isEqualToString:w1]) {
                    result = NO;
                }
            }
            
            [[theValue(result) should] beTrue];
        });
        
        it(@"should move the first chosen weapon into weapon choices", ^ {
            [f startup];
            NSString *w1 = [[[f chosenWeapons] objectAtIndex:0] description];
            [[f player] fire];
            kill();
            [f chooseWeapon:0];
            NSArray *availableWeapons = [f weaponChoices];
            BOOL result = NO;
            for (Weapon *w in availableWeapons) {
                if ([[w description] isEqualToString:w1]) {
                    result = YES;
                }
            }
            
            [[theValue(result) should] beTrue];
        });
        
        it(@"should record the last chosen weapon", ^ {
            firstKill();
            NSString *w = [[[f weaponChoices] objectAtIndex:0] description];
            [f chooseWeapon:0];
            NSString *chosenWeapon = [[[f chosenWeapons] objectAtIndex:[[f chosenWeapons] count] -1] description];
            BOOL result = [w isEqualToString:chosenWeapon];
            
            [[theValue(result) should] beTrue];
        });
        
    });
    
    context(@"Clone Piloting", ^{
        it(@"should reset moveIndex on new level", ^{
            firstKill();
            [f chooseWeapon:0];
            ClonePilot *p = [[f clones] objectAtIndex:0];
            [[theValue([p moveIndex]) should] equal:theValue(1)];
        });
        
        it(@"should increase moveIndex each tick", ^{
            [f startup];
            [[f player] fire];
            [f player].t = CGPointMake(10, 300);
            kill();
            [f chooseWeapon:0];
            [f tick];
            ClonePilot *p = [[f clones] objectAtIndex:0];
            [[theValue([p moveIndex]) should] equal:theValue(2)];
            [f tick];            
            [[theValue([p moveIndex]) should] equal:theValue(3)];            
        });

        it(@"should copy horizontal movement", ^ {
            [f startup];
            [[f player] fire];
            [f player].t = CGPointMake(500, 500);
            
            NSMutableArray *playerLocations = [NSMutableArray array];
            
            int turnTotal = 5;
            
            for (int i = 0; i < turnTotal; i++) {
                float x = [f player].l.x;
                [playerLocations addObject:[NSNumber numberWithFloat:x]];
                [f tick];
            }
            
            kill();
            NSLog(@"killed");            
            ClonePilot *p = [[f clones] objectAtIndex:0];            
            [f chooseWeapon:0];
            NSLog(@"chose weapon");
            
            for (int i = 0; i < turnTotal; i++) {
                [[theValue(p.l.x) should] equal:theValue([[playerLocations objectAtIndex:i] floatValue])];
                [f tick];
            }
        });
        
        it(@"should invert vertical movement", ^{
            [f startup];
            
            float originalY = [f player].l.y;
            float originalCloneY = ((ClonePilot *)[[f clones] objectAtIndex:0]).l.y;
            
            [[f player] fire];
            [f player].t = CGPointMake(500, 700);

            NSMutableArray *playerLocations = [NSMutableArray array];
            
            int turnTotal = 5;
            
            for (int i = 0; i < turnTotal; i++) {
                Turn *turn = [[f player] currentTurn];
                NSLog(@"turn: %@",turn);
                
                float y = [f player].l.y;
                float distance = y - originalY;
                NSLog(@"distance: %f", distance);
                [playerLocations addObject:[NSNumber numberWithFloat:y]];
                NSLog(@"%f",[[NSNumber numberWithFloat:y] floatValue]);
                [f tick];
            }
                 
            kill();
            
            ClonePilot *p = [[f clones] objectAtIndex:0];
            
            for (int i = 0; i < turnTotal; i++) {
                Turn *turn = [p currentTurn];
                NSLog(@"turn: %@",turn);
                float y = p.l.y;
                float oy = [[playerLocations objectAtIndex:i] floatValue];
                
                float playerDist    = oy - originalY;
                float cloneDist     = originalCloneY - y;
                NSLog(@"playerDist: %f", playerDist);
                NSLog(@"cloneDist: %f", cloneDist);
                
                float distance = playerDist - cloneDist;
                [[theValue(distance) should] beLessThan:theValue(.0001)]; //it's close. everything seems fine but this precision.
                [f tick];
            }
        });
        
        it(@"should fire when its turn fires", ^ {
            [f startup];
            [f tick];
            [f tick];
            [[f player] fire];
            [f tick];
            [f tick];
            [f tick];
            [f tick];
            [f tick];
            [[f player] fire];
            [f tick];
            kill();
            [f chooseWeapon:0];
            ClonePilot *p = [[f clones] objectAtIndex:0];
            NSLog(@"p current move index: %d",p.moveIndex);
            [[theValue([[p currentTurn] firing]) should] beFalse];
            [f tick];
            NSLog(@"p current move index: %d",p.moveIndex);            
            [[theValue([[p currentTurn] firing]) should] beTrue];  
            [f tick];
            
            NSLog(@"p current move index: %d",p.moveIndex);            
            [[theValue([[p currentTurn] firing]) should] beFalse];
            [f tick];
            NSLog(@"p current move index: %d",p.moveIndex);            
            [[theValue([[p currentTurn] firing]) should] beFalse];
            [f tick];
            NSLog(@"p current move index: %d",p.moveIndex);            
            [[theValue([[p currentTurn] firing]) should] beFalse];
            [f tick];
            NSLog(@"p current move index: %d",p.moveIndex);            
            [[theValue([[p currentTurn] firing]) should] beFalse];
            [f tick];
            NSLog(@"p current move index: %d",p.moveIndex);            
            [[theValue([[p currentTurn] firing]) should] beTrue];
            [f tick];
            NSLog(@"p current move index: %d",p.moveIndex);            
            [[theValue([[p currentTurn] firing]) should] beFalse];            
        });
    });
 
    context(@"Scoring", ^{
        it(@"should score when it kills", ^ {
            firstKill();
            [[theValue(f.score) should] beGreaterThan:theValue(0)];
        });
        
        it(@"should not score a bonus for having less than full health", ^ {
            firstKill();
            [f chooseWeapon:0];
            playerHit();
            [[f player] fire];
            [[f player] fire];
            [f player].t = CGPointMake(130, 700);
            kill();
            [f chooseWeapon:0];
            NSInteger clonesKillValue = 3 * [f cloneKillValue] + [f fullHealthBonus];;
            [[theValue([f score]) should] equal:theValue(clonesKillValue)];
        });
        
        it(@"should score a bonus for having full health", ^{
            firstKill();
            [f chooseWeapon:0];
            [[f player] fire];
            [[f player] fire];
            [f player].t = CGPointMake(150, 300);
            kill();
            [f chooseWeapon:0];
            NSInteger expectedScore = (3 * [f cloneKillValue]) + ([f fullHealthBonus] * 2);
            [[theValue([f score]) should] equal:theValue(expectedScore)];
        });
    });
    
    context(@"Combat", ^{
        it(@"should track shots fired", ^ {
            [f startup];
            [[f player] fire];
            [[theValue(f.shotsFired) should] equal:theValue(1)];
        });
        
        it(@"should track hits", ^ {
            [f startup];
            [[theValue(f.hits) should] equal:theValue(0)];
            [[f player] fire];
            kill();
            [[theValue(f.hits) should] equal:theValue(1)];
        });
        
        it(@"should reset position when out of moves", ^{
            [f startup];
            ClonePilot *p = [[f clones] lastObject];
            CGPoint position = p.l;
            [[f player] fire];
            [f player].t = CGPointMake(500, 750);
            kill();
            BOOL hitZero = 0;
            while (!hitZero) {
                [f tick];
                if (p.moveIndex == 0) {
                    hitZero = 1;
                }
            }
            [[theValue(p.l) should] equal:theValue(position)];
        });

        it(@"should assign ownership of bullets from the player", ^{
            [f startup];
            NSInteger bulletIdentifier = [[f player] identifier];
            [[f player] fire];
            Bullet *b = [[f bullets] lastObject];
            [[theValue([b identifier]) should] equal:theValue(bulletIdentifier)];
        });

        it(@"should assign ownership of bullets from the enemy", ^{
            firstKill();
            [f chooseWeapon:0];
            newBullet();
            Bullet *b = [[f bullets] lastObject];
            [[theValue([b identifier]) should] equal:theValue([ClonePilot identifier])];
        });
        
        it(@"should add bullets when its turn fires", ^{
            [f startup];
            [f tick];
            [[f player] fire];
            kill();
            NSInteger bullets = [[f bullets] count];
            [f chooseWeapon:0];
            [f tick];
            NSInteger newBullets = [[f bullets] count];
            [[theValue(newBullets) should] beGreaterThan:theValue(bullets)];            
        });
        
        it(@"should fire bullets from its weapon", ^ {
            firstKill();
            [f chooseWeapon:0];
            NSArray *existingBullets = [NSArray arrayWithArray:[f bullets]];  
            [[f player] fire];
            Weapon *w = [[f player] weapon];
            [f tick];
            NSArray *expectedBullets = [w newBulletsForLocation:[f player].l direction:-1];
            [[theValue([[f bullets] count]) should] equal:theValue([expectedBullets count] + [existingBullets count])];            
        });
    });
    
    context(@"Player Health", ^{
        it(@"should start with one health", ^{
            [f startup];
            [[theValue([[f player] health]) should] equal:theValue(1)];
        });
        
        it(@"should hurt player when bullet hits", ^{
            firstKill();
            NSInteger health = [[f player] health];
            playerHit();
            [[theValue([[f player] health]) should] beLessThan:theValue(health)];
        });
        
        it(@"should gain health between levels", ^{
            [f startup];
            NSInteger health = [[f player] health];
            [[f player] fire];
            kill();
            [f chooseWeapon:0];
            NSInteger newHealth = [[f player] health];
            [[theValue(newHealth) should] beGreaterThan:theValue(health)];
        });
        
        it(@"should have health equal to new level plus one", ^ {
            firstKill();
            [f chooseWeapon:0];
            playerHit();
            [[f player] fire];
            [[f player] fire];
            [f player].t = CGPointMake(100, 700);
            kill();
            [f chooseWeapon:0];
            NSInteger health = [[f player] health];
            [[theValue(health) should] equal:theValue([f level] + 1)];            
        });
                
        it(@"should reset clones when player dies", ^{
            firstPilotDeath();
            [[theValue([[f clones] count]) should] equal:theValue(0)];
        });
        
        it(@"should erase bullets when player dies", ^{
            firstPilotDeath();
            [[theValue([[f bullets] count]) should] equal:theValue(0)];
        });
        
        it(@"should reset player moves", ^{
            firstPilotDeath();
            [[theValue([[[f player] currentMoves] count]) should] equal:theValue(0)];
        });
        
        it(@"should reset player location", ^{
            [f startup];
            CGPoint startingPosition = [f player].l;
            [[f player] fire];
            kill();
            [f chooseWeapon:0];
            [f player].t = CGPointMake([f player].l.x, [f player].l.y - 200);
            playerHit();
            playerHit();
            [[theValue([f player].l) should] equal:theValue(startingPosition)];
        });
        
        it(@"should reset player weapon", ^{
            [f startup];
            Weapon *startingWeapon = [[f player] weapon];
            NSString *weaponDescription = [startingWeapon description];
            [[f player] fire];
            kill();
            [f chooseWeapon:0];
            playerHit();
            playerHit();
            NSString *resetWeapon = [[[f player] weapon] description];
            BOOL result = [resetWeapon isEqualToString:weaponDescription];
            [[theValue(result) should] equal:theValue(YES)];
        });
        
        it(@"should reset level", ^{
            firstPilotDeath();
            [[theValue([f level]) should] equal:theValue(0)];
        });
        
        it(@"should reset weapon choices", ^{
            [f startup];
            NSString *chosenWeapons     = [[[f weaponSelector] chosenWeapons] description];
            [[f player] fire];
            kill();
            [f chooseWeapon:0];
            playerHit();
            playerHit();
            NSString *resetChosenWeapons = [[[f weaponSelector] chosenWeapons] description];
            NSString *resetAvailableWeapons = [[[f weaponSelector] weaponChoices] description];
            BOOL chosenResult       = [resetChosenWeapons isEqualToString:chosenWeapons];
            BOOL availableResult    = resetAvailableWeapons == nil;
            [[theValue(chosenResult) should] beTrue];
            [[theValue(availableResult) should] beTrue];
        });
    });
    
    context(@"Player Input", ^{
        it(@"should start with no active touches", ^{
            [f startup];
            [[theValue([f moveActive]) should] beFalse];
        });
        
        it(@"should add a touch when passed to it", ^{
            firstTouch();
            [[theValue([f moveActive]) should] beTrue];
        });
        
        it(@"should set player target with first touch", ^{
            firstTouch();
            [[theValue([[f player] t]) should] equal:theValue(startingTouch)];
        });        
        
        
        it(@"should set player's state to fire on second touch", ^{
            firstTouch();
            [f addTouch:CGPointMake(800, 800)];
            Turn *currentTurn = [[f player] currentTurn];
            [[theValue([currentTurn firing]) should] equal:theValue(YES)];
        });
    });
    
    context(@"Pausing", ^{
        it(@"should start unpaused", ^{
            [f startup];
            [[theValue([f playing]) should] beTrue];
        });
        
        it(@"should pause when playing and toggled", ^{
            [f startup];
            [f togglePlaying];
            [[theValue([f playing]) should] beFalse];
        });
        
        it(@"should play when paused and toggled", ^{
            [f startup];
            [f togglePlaying];
            [f togglePlaying];
            [[theValue([f playing]) should] beTrue]; 
        });
        
        it(@"should freeze bullets when paused", ^{
            [f startup];
            [[f player] fire];
            [f tick];
            [f tick];
            [f togglePlaying];
            Bullet *b = [[f bullets] objectAtIndex:0];
            CGPoint l = b.l;
            [f tick];
            [[theValue(b.l) should] equal:theValue(l)];
        });
        
        it(@"should freeze player when paused", ^{
            [f startup];
            [f player].t = CGPointMake(100, 300);
            [f tick];
            CGPoint l = [f player].l;
            [f togglePlaying];
            [f tick];
            [[theValue([f player].l) should] equal:theValue(l)];
        });
        
        it(@"should freeze clones when paused", ^ {
            [f startup];
            [[f player] fire];
            [f tick];
            [f player].t = CGPointMake(600, 300);
            [f tick];
            kill();
            [f chooseWeapon:0];
            [f tick];
            [f tick];
            [f tick];
            [f togglePlaying];
            ClonePilot *p = [[f clones] objectAtIndex:0];
            NSLog(@"p.vel: %f %f",p.vel.x, p.vel.y);
            CGPoint l = p.l;
            [f tick];
            [[theValue(p.l) should] equal:theValue(l)];
        });
        
        it(@"should not fire player bullets when paused", ^{
            [f startup];
            [[f player] fire];
            [f togglePlaying];
            [f tick];
            [[theValue([[f bullets] count]) should] equal:theValue(0)];
        });
        
        it(@"should not fire clone bullets when paused", ^{
            [f startup];
            [f tick];
            [[f player] fire];
            [f tick];
            kill();
            [f chooseWeapon:0];
            [f togglePlaying];
            [f tick];
            [f tick];
            [f tick];
            [f tick];
            [[theValue([[f bullets] count]) should] equal:theValue(0)]; 
        });
    });
});

SPEC_END