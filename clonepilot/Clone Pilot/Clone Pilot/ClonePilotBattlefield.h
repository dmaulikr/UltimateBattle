#import <Foundation/Foundation.h>
#import "BulletHellBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"
#import "WeaponSelector.h"
#import "VRTouch.h"
#import "CCLayer.h"
#import "BulletWall.h"
#import "QPInputHandler.h"
#import "QPScoreDisplay.h"

extern int const QP_TouchTargetingYOffset; 
extern int const QP_AccuracyBonusModifier;
extern int const QP_MaxTime;
extern int const QP_TimeBonusModifier;

@class WeaponSelector;

@interface ClonePilotBattlefield : BulletHellBattlefield  <WeaponSelectorDelegate, QPInputHandlerDelegate> {
    BOOL _shouldAdvanceLevel;
    BOOL _battlefieldEnding;
    BOOL _paused;
    QPScoreDisplay *_scoreDisplay;
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
@property (nonatomic, assign) CGPoint lastMove;
@property (nonatomic, retain) CCSprite *rSprite;
@property (nonatomic, retain) QPInputHandler *inputHandler;
@property (nonatomic, assign) CGPoint moveAngle;

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
- (void)plusTouch:(UITouch *)t;
- (void)varyTouch:(UITouch *)t;

- (BOOL)playing;
- (void)togglePlaying;

- (NSInteger)accuracyBonus;
- (NSInteger)timeBonus;

- (void)ensurePlaying;

- (void)resetClones;

- (id)initWithLayer:(CCLayer *)quantumLayer;

@end
