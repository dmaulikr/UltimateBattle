#import <Foundation/Foundation.h>
#import "BulletHellBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"
#import "WeaponSelector.h"

@class WeaponSelector;

@interface ClonePilotBattlefield : BulletHellBattlefield <BulletDelegate> {
    
}

@property (nonatomic, retain) ClonePlayer *player;
@property (nonatomic, retain) NSMutableArray *clones;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) float shotsFired;
@property (nonatomic, assign) float hits;
@property (nonatomic, retain) WeaponSelector *weaponSelector;

- (void)startup;
- (NSInteger)livingClones;

- (ClonePilot *)latestClone;

- (void)advanceLevel;

- (void)chooseWeapon:(NSInteger)choiceIndex;

- (void)playerChoseWeapon:(Weapon *)weapon;

- (NSArray *)weaponChoices;

- (NSArray *)chosenWeapons;

@end
