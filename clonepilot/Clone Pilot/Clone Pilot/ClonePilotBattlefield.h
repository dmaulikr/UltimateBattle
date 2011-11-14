#import <Foundation/Foundation.h>
#import "BulletHellBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"
#import "WeaponSelector.h"
#import "VRTouch.h"

@class WeaponSelector;

@interface ClonePilotBattlefield : BulletHellBattlefield <BulletDelegate> {
    BOOL _shouldAdvanceLevel;
    BOOL _battlefieldEnding;
    BOOL _paused;
}

@property (nonatomic, retain) ClonePlayer *player;
@property (nonatomic, retain) NSMutableArray *clones;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) float shotsFired;
@property (nonatomic, assign) float hits;
@property (nonatomic, retain) WeaponSelector *weaponSelector;
@property (nonatomic, retain) NSMutableArray *touches;

- (void)startup;
- (NSInteger)livingClones;

- (ClonePilot *)latestClone;
- (ClonePilot *)firstClone;

- (void)advanceLevel;

- (void)chooseWeapon:(NSInteger)choiceIndex;

- (void)playerChoseWeapon:(Weapon *)weapon;

- (NSArray *)weaponChoices;

- (NSArray *)chosenWeapons;

- (NSInteger)cloneKillValue;
- (NSInteger)fullHealthBonus;

- (void)addTouch:(VRTouch *)touch;
- (void)moveTouch:(CGPoint)l;

- (BOOL)playing;
- (void)togglePlaying;

@end
