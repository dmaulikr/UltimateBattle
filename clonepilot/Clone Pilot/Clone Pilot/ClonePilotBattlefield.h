#import <Foundation/Foundation.h>
#import "BulletHellBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"
#import "WeaponSelector.h"
#import "VRTouch.h"
#import "CCLayer.h"
#import "BulletWall.h"
#import "QPFireLayer.h"
#import "QPFireLayer.h"

extern int const QP_TouchTargetingYOffset; 
extern int const QP_AccuracyBonusModifier;
extern int const QP_MaxTime;
extern int const QP_TimeBonusModifier;

@class WeaponSelector;

@interface ClonePilotBattlefield : BulletHellBattlefield <BulletDelegate, WeaponSelectorDelegate, QPFireLayerdelegate> {
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
@property (nonatomic, assign) BOOL moveActive;
@property (nonatomic, assign) CGPoint currentTarget;
@property (nonatomic, assign) CCLayer *layer;
@property (nonatomic, assign) double time;
@property (nonatomic, retain) BulletWall *wall;
@property (nonatomic, retain) QPFireLayer *fireLayer1;
@property (nonatomic, retain) QPFireLayer *fireLayer2;
@property (nonatomic, assign) CGPoint lastMove;

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

- (void)addTouch:(CGPoint)l;
- (void)moveTouch:(CGPoint)l;
- (void)endTouch:(CGPoint)l;

- (void)addTouch:(CGPoint)l last:(CGPoint)last;
- (void)moveTouch:(CGPoint)l last:(CGPoint)last;
- (void)endTouch:(CGPoint)l last:(CGPoint)last;


- (void)plusTouch:(UITouch *)t;
- (void)varyTouch:(UITouch *)t;
- (void)finishTouch:(UITouch *)t;

- (BOOL)playing;
- (void)togglePlaying;

- (NSInteger)accuracyBonus;
- (NSInteger)timeBonus;

- (id)initWithLayer:(CCLayer *)quantumLayer;

@end
