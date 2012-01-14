#import "Kiwi.h"
#import "ClonePilotBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"
#import "ActionBlock.h"
#import "SideLaserBullet.h"
#import "Bullet.h"
#import "VRGeometry.h"
#import "VRTouch.h"
#import "QuantumPilotLayer.h"

SPEC_BEGIN(ClonePilotBattlefieldTest)

describe(@"Clone Pilot Battlefield", ^{
    __block ClonePilotBattlefield *f;
    __block CGPoint startingTouch;
    
    ActionBlock kill = ^ {
        int livingClones = [f livingClones];
        
        while ([f livingClones] >= 1) {
            if ([f livingClones] > livingClones) {
                break;
            }
            [f tick];
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
    };
    
    ActionBlock playerDestinationReached = ^{
        while (GetDistance([f player].l, [f player].t) > 0) { // > acceptableProximityToTarget) {
            [f tick];
        }
    };

    beforeEach(^{
        
        QuantumPilotLayer *quantumLayer = [[[QuantumPilotLayer alloc] init] autorelease];
        f = [[[ClonePilotBattlefield alloc] initWithLayer:quantumLayer] autorelease];
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
        
        it(@"should reset wall between levels", ^ {
            firstKill();
            [[theValue([f wall].l.y) should] equal:theValue(1024-[[f wall] speed])];
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
                [[theValue(distance) should] beLessThan:theValue(.001)]; //it's close. everything seems fine but this precision.
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
        
        it(@"should reverse move index directions when it finishes moves", ^{
            firstKill();
            ClonePilot *p = [f firstClone];
            NSInteger cloneMoves = [p.moves count];
            [f player].t = CGPointMake(800, [[f player] l].y);
            f.moveActive = 1;
            while (1) {
                if ([p moveIndex] == cloneMoves - 1) {
                    break;
                }
                [f tick];
            }

            [f tick];        
            [[theValue([p moveIndex]) should] equal:theValue(cloneMoves-2)];
            
            while (1) {
                if ([p moveIndex] == 0) {
                    break;
                }
                [f tick];
            }
            
            [f tick];
            
            [[theValue([p moveIndex]) should] equal:theValue(1)];            
        });
        
        it(@"should reverse velocity when reversing move direction", ^{
            firstKill();
            ClonePilot *p = [f firstClone];
            Turn *t = [[p moves] objectAtIndex:1];
            NSInteger cloneMoves = [p.moves count];
            [f player].t = CGPointMake(800, 800);
            while (1) {
                if ([p moveIndex] == cloneMoves - 1) {
                    break;
                }
                [f tick];
            }
            [f tick];
            Turn *currentTurn = [p currentTurn];
            [[theValue(currentTurn.vel.x) should] equal:theValue(-t.vel.x)];
            [[theValue(currentTurn.vel.y) should] equal:theValue(-t.vel.y)];            
        });
    });
 
    context(@"Combat", ^{
        it(@"should track shots fired", ^ {
            [f startup];
            [[f player] fire];
            [f tick];
            [[theValue(f.shotsFired) should] equal:theValue(1)];
        });
        
        it(@"should track hits", ^ {
            [f startup];
            [[theValue(f.hits) should] equal:theValue(0)];
            [[f player] fire];
            kill();
            [[theValue(f.hits) should] equal:theValue(1)];
        });
        
        it(@"should reset hits between levels", ^{
            firstKill();
            [f chooseWeapon:0];
            [[theValue(f.hits) should] equal:theValue(0)];
        });
        
        it(@"should reset shots fired between levels", ^{
            firstKill();
            [f chooseWeapon:0];
            [[theValue(f.shotsFired) should] equal:theValue(0)];
        });

        it(@"should assign ownership of bullets from the player", ^{
            [f startup];
            NSInteger bulletIdentifier = [[f player] identifier];
            [[f player] fire];
            [f tick];
            Bullet *b = [[f bullets] lastObject];
            [[theValue([b identifier]) should] equal:theValue(bulletIdentifier)];
        });

        it(@"should assign ownership of bullets from the enemy", ^{
            firstKill();
            [f chooseWeapon:0];
            [f player].t = CGPointMake(800, 800);
            [f tick];
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
    
    context(@"Scoring", ^{
        it(@"should score when it kills", ^ {
            firstKill();
            [[theValue(f.score) should] beGreaterThan:theValue(0)];
        });
        
        it(@"should score based on accuracy", ^{
            [f startup];
            [[f player] fire];
            [f tick];
            [[f player] fire];
            [f tick];
            kill();
            double timeBonus = [f timeBonus];
            float accuracy = [f hits] / [f shotsFired];
            [f chooseWeapon:0];
            [[theValue(accuracy) should] equal:theValue(.5)];
            float expectedAccuracyBonus = QP_AccuracyBonusModifier * accuracy * 100;
            int totalExpectedScore = [f level] + expectedAccuracyBonus + timeBonus;
            [[theValue([f score]) should] equal:theValue(totalExpectedScore)];
        });
        
        it(@"should score based on time", ^{
            firstKill();
            double timeElapsed = [f time];
            double timeLeft = QP_MaxTime - timeElapsed;
            double expectedTimeBonus = timeLeft * QP_TimeBonusModifier;
            float accuracyBonus = [f accuracyBonus];
            [f chooseWeapon:0];
            NSInteger totalExpectedScore = expectedTimeBonus + accuracyBonus + [f level];            
            [[theValue([f score]) should] equal:theValue(totalExpectedScore)];
        });
    });
 
    context(@"Player Health", ^{
        it(@"should start with one health", ^{
            [f startup];
            [[theValue([[f player] health]) should] equal:theValue(1)];
        });
        
        it(@"should hurt player when bullet hits", ^{
            firstKill();
            [f chooseWeapon:0];
            NSInteger health = [[f player] health];
            playerHit();
            [[theValue([[f player] health]) should] beLessThan:theValue(health)];
        });
                        
        it(@"should reset clones when player dies", ^{
            firstPilotDeath();
            [f tick];
            [[theValue([[f clones] count]) should] equal:theValue(1)];
        });
        
        it(@"should reset score when player dies", ^{
            firstPilotDeath();
            [f tick];
            [[theValue([f score]) should] beZero];
        });
        
        it(@"should reset shots fired when player dies", ^{
            firstPilotDeath();
            [f tick];
            [[theValue(f.shotsFired) should] beZero];
        });
        
        it(@"should reset hits when player dies", ^{
            firstPilotDeath();
            [f tick];
            [[theValue(f.hits) should] beZero];
        });
        
        it(@"should erase bullets when player dies", ^{
            firstPilotDeath();
            [f tick];
            [[theValue([[f bullets] count]) should] equal:theValue(0)];
        });
        
        it(@"should reset player moves", ^{
            firstPilotDeath();
            [f tick];
            [[theValue([[[f player] currentMoves] count]) should] equal:theValue(1)];
        });
        
        it(@"should reset player location", ^{
            [f startup];
            CGPoint startingPosition = [f player].l;
            [[f player] fire];
            kill();
            [f chooseWeapon:0];
            [f player].t = CGPointMake([f player].l.x, [f player].l.y + 100);
            playerHit();
            [f tick];
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
            [f tick];
            NSString *resetWeapon = [[[f player] weapon] description];
            BOOL result = [resetWeapon isEqualToString:weaponDescription];
            [[theValue(result) should] equal:theValue(YES)];
        });
        
        it(@"should reset level", ^{
            firstPilotDeath();
            [f tick];
            [[theValue([f level]) should] equal:theValue(0)];
        });
        
        it(@"should reset weapon choices", ^{
            [f startup];
            NSString *chosenWeapons     = [[[f weaponSelector] chosenWeapons] description];
            [[f player] fire];
            kill();
            [f chooseWeapon:0];
            playerHit();
            [f tick];
            NSString *resetChosenWeapons = [[[f weaponSelector] chosenWeapons] description];
            NSString *resetAvailableWeapons = [[[f weaponSelector] weaponChoices] description];
            BOOL chosenResult       = [resetChosenWeapons isEqualToString:chosenWeapons];
            BOOL availableResult    = resetAvailableWeapons == nil;
            [[theValue(chosenResult) should] beTrue];
            [[theValue(availableResult) should] beTrue];
        });
    });
    
    context(@"Player Input", ^{
        it(@"should start stationary", ^{
            [f startup];
            [[theValue([f moveActive]) should] beFalse];
        });
        
        it(@"should do nothing with an oob touch", ^{
            [f startup];
            [f addTouch:CGPointMake(384, 384)];
            [f tick];
            [[theValue([f moveActive]) should] beFalse];
            [[theValue([[f player] isFiring]) should] beFalse];
        });

        
//        it(@"set a velocity when a touch lands within the move input circle", ^{
//            [f startup];
//            [f addTouch:CGPointMake(10, 1024-50)];
//            [f tick];
//            [[theValue([f moveActive]) should] beTrue]; 
//        });
    });
    
    context(@"Moving", ^{
        it(@"should move less than its full speed if less than a speed's ticks away from target", ^{
            [f startup];
            CGPoint currentLocation = [f player].l;
            [f player].t = CGPointMake(currentLocation.x, currentLocation.y - (2.5 * [[f player] speed]));
            [f tick];
            [f tick];
            [f tick];
            NSLog([[f player] locationAndTargetingStatus]);
            [[theValue([f player].vel.y) should] beLessThan:theValue([[f player] speed])];
        });
        
        it(@"should stop moving when it reaches its destination", ^{
            [f startup];
            CGPoint currentLocation = [f player].l;
            [f player].t = CGPointMake(currentLocation.x, currentLocation.y - (2.5 * [[f player] speed]));
            playerDestinationReached();   
            [f tick];
            [[theValue([f player].vel.x) should] equal:theValue(0)];
            [[theValue([f player].vel.y) should] equal:theValue(0)];            
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
    
    context(@"Time", ^{
        it(@"should have start time", ^{
            [f startup]; 
            [[theValue([f time]) should] beZero];
        });
        
        it(@"should increment time with ticks", ^{
            [f startup];
            double time = [f time];
            [f tick];
            [[theValue([f time]) should] beGreaterThan:theValue(time)];
        });
        
        it(@"should not increment time when paused",^{
            [f startup];
            double time = [f time];
            [f togglePlaying];
            [f tick];
            [[theValue([f time]) should] equal:theValue(time)];
        });
    });
    
    context(@"BulletWall", ^{
        it(@"should have a bullet wall", ^{
            [f startup];
            [[theValue([f wall]) should] beNonNil];
        });

        it(@"should start at the battlefield edge", ^{
            [f startup];
            [[theValue([f wall].l.y) should] equal:theValue(1024)];
        });
        
        it(@"should move each tick", ^{
            [f startup];
            float height = [f wall].l.y;
            [f tick];
            [[theValue([f wall].l.y) should] beLessThan:theValue(height)];
        });
        
        it(@"should kill player when overlapping", ^{
            [f startup];
            [f player].t = CGPointMake(384, 0);
            playerHit();
            [[theValue([[f player] health]) should] equal:theValue(-1)];      
        });
        
        it(@"should reset when it kills the player", ^{ 
            [f startup];
            [f tick];
            CGPoint wallStart = [f wall].l;
            [f player].t = CGPointMake(384, 0);
            playerHit();
            [f tick];
            [[theValue([f wall].l) should] equal:theValue(wallStart)];            
        });
    });

});

SPEC_END