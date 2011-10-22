#import <Foundation/Foundation.h>
#import "BulletHellBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"
#import "SplitLaser.h"
#import "TriLaser.h"

@interface ClonePilotBattlefield : BulletHellBattlefield <BulletDelegate> {
    
}

@property (nonatomic, retain) ClonePlayer *player;
@property (nonatomic, retain) NSMutableArray *clones;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) float shotsFired;
@property (nonatomic, assign) float hits;
@property (nonatomic, retain) NSArray *weaponChoices;

@property (nonatomic, retain) SplitLaser *splitLaser;
@property (nonatomic, retain) TriLaser *triLaser;

@property (nonatomic, retain) NSMutableArray *chosenWeapons;

- (void)startup;
- (NSInteger)livingClones;

- (ClonePilot *)latestClone;

- (void)advanceLevel;

- (void)chooseWeapon:(NSInteger)choiceIndex;

@end
