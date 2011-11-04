#import "Kiwi.h"
#import "ClonePilotBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"
#import "ActionBlock.h"

SPEC_BEGIN(ClonePilotBattlefieldTest)

describe(@"Clone Pilot Battlefield", ^{
    __block ClonePilotBattlefield *f;

    ActionBlock kill = ^ {
        int livingClones = [f livingClones];
        
        while ([f livingClones] == 1) {
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
    
//    ActionBlock playerHit = ^{
//        int playerHealth = [[f player] health];
//        while ([[f player] health] == playerHealth) {
//            [f tick];
//        }
//    };
    
    beforeEach(^{
        f = [[[ClonePilotBattlefield alloc] init] autorelease];
    });
    
    context(@"Initialization", ^{
        it(@"should have a player with a location", ^{
            [[theValue([[[f player ]class] isSubclassOfClass:[ClonePlayer class]]) should] beTrue];
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
        
        it(@"should score when it kills", ^ {
            firstKill();
            [[theValue(f.score) should] beGreaterThan:theValue(0)];
        });
        
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
    });
    
    context(@"Weapon Selection", ^ {
        it(@"should present choices for weapon selection between levels", ^ {
            firstKill();
            [[theValue([[f weaponChoices] count]) should] beGreaterThan:theValue(1)];
        });
        
        it(@"should advance level when a weapon is chosen", ^{
            firstKill();
            [f chooseWeapon:0];
            [[theValue(f.level) should] equal:theValue(1)];
        });
        
        it(@"should assign the chosen weapon to the player", ^{
            firstKill();
            [f chooseWeapon:0];
            NSString *weapon = [f.player.weapon description];
            BOOL result = [weapon isEqualToString:[SplitLaser description]];
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
            NSLog(@"PRE weapon choices: %@",[f weaponChoices]);
            NSLog(@"PRE chosen: %@", [f chosenWeapons]);
            [f chooseWeapon:0];
            NSLog(@"POST weapon choices: %@",[f weaponChoices]);
            NSLog(@"POST chosen: %@", [f chosenWeapons]);
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
            NSLog(@"x0: %f", [f player].l.x);
            [f tick];
            NSLog(@"x1: %f", [f player].l.x);
            [f tick];
            NSLog(@"x2: %f", [f player].l.x);
            [f tick];
            NSLog(@"x3: %f", [f player].l.x);
            [f tick];
            NSLog(@"x4: %f", [f player].l.x);
            [f tick];
            float x = [f player].l.x;
            kill();
            NSLog(@"killed");            
            ClonePilot *p = [[f clones] objectAtIndex:0];            
            [f chooseWeapon:0];
            NSLog(@"chose weapon");
            NSLog(@"x0: %f", p.l.x);
            [f tick];
            NSLog(@"x1: %f", p.l.x);
            [f tick];
            NSLog(@"x2: %f", p.l.x);   
            [f tick];
            NSLog(@"x3: %f", p.l.x);   
            [f tick];         
            NSLog(@"x4: %f", p.l.x);   
            [f tick]; 
            [[theValue(p.l.x) should] equal:theValue(x)];
        });
        
//        context(@"should fire when its turn fires", ^ {
//            firstKill();
//            newBullet();
//            ClonePilot *p = [[f clones] objectAtIndex:0];
//            [[theValue([p moveIndex]) should] equal:theValue(1)];
//            Bullet *b = [[f bullets] lastObject];
//            [[theValue([b identifier]) should] equal:theValue([ClonePilot identifier])];
//        });
    });
    
    context(@"Combat", ^{
        it(@"should start with one health", ^{
            [f startup];
            [[theValue([[f player] health]) should] equal:theValue(1)];
        });

        it(@"should assign ownership of bullets from the player", ^{
            [f startup];
            NSInteger bulletIdentifier = [[f player] identifier];
            [[f player] fire];
            Bullet *b = [[f bullets] lastObject];
            [[theValue([b identifier]) should] equal:theValue(bulletIdentifier)];
        });
                
//        it(@"should assign ownership of bullets from the enemy", ^{
//            firstKill();
//            [f chooseWeapon:0];
//            newBullet();
//            Bullet *b = [[f bullets] lastObject];
//            [[theValue(b) should] equal:theValue([ClonePilot identifier])];
//        });
        
//        it(@"should hurt player when bullet hits", ^{
//            firstKill();
//            NSInteger health = [[f player] health];
//            playerHit();
//            [[theValue([[f player] health]) should] beLessThan:theValue(health)];
//        });
    });
});

SPEC_END