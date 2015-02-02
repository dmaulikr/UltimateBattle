#import "cocos2d.h"
#import "QuantumPilot.h"
#import "QPBFState.h"
#import "QPBFTitleState.h"
#import "QPBFDrawingState.h"
#import "QPBFFightingState.h"
#import "QPBFPausedState.h"
#import "DeadLine.h"
#import "ShieldDebris.h"
#import "QPScoreCycler.h"
#import "UpgradeButton.h"

#define QP_BF_SCORE     @"QP_BF_SCORE"
#define QP_BF_ACCSCORE  @"QP_BF_ACCSCORE"
#define QP_BF_PATHSCORE @"QP_BF_PATHSCORE"

#import <AudioToolbox/AudioToolbox.h>

#define QPBF_MAX_DRAWING_FRAMES 4550

enum pulsestate {
    resting = 0,
    charging = 1,
    holding = 2,
    falling = 3
};

enum drawguide {
    circle = 0,
    zigzag = 1,
    rest = 2,
    fire = 3
};

@interface QPBattlefield : CCNode <QuantumPilotingDelegate, QPBulletDelegate, BulletDelegate> {
    NSInteger _pulseTimes[4];
    NSInteger _pulseState;
    NSInteger _pulseDirection;
    NSInteger _pulseCharge;
    float _rhythmScale;
    float _breaths;
    float _breathCycle;
    NSInteger _breathFlow;
    
    CGPoint _deltas[8551];
    
    int shotsFired;
    int hits;
    int paths;
    int level;
    
    int totalShotsFired;
    int totalHits;
    int totalPaths;
    
    int installLevel;
    int weaponLevel; //move to upgrade class?
    int shield;
    int warning;
    int slow;
    
    int titleY;
    int titleDelay;
    bool titleSlide;
    
    bool veteran;
    
    SystemSoundID dismantler;
    SystemSoundID novasplitter;
    SystemSoundID corecrusher;
    SystemSoundID exoslicer;
    SystemSoundID gammahammer;
    SystemSoundID spacemelter;
    SystemSoundID voidwave;
    
    SystemSoundID l1;
    SystemSoundID l2;
    SystemSoundID l3;
    SystemSoundID l4;
    SystemSoundID l5;
    SystemSoundID l6;
    SystemSoundID l7;
    
    SystemSoundID collect;
    
    SystemSoundID x1;
    SystemSoundID x2;
    SystemSoundID x3;
    SystemSoundID x4;
    SystemSoundID x5;
    SystemSoundID x6;
    SystemSoundID x7;
    
    SystemSoundID process;
    
    SystemSoundID drag;
    SystemSoundID tap;
    SystemSoundID copy;
    
    SystemSoundID again;

    SystemSoundID boost;
    SystemSoundID laser;
    
    NSInteger _recentBonus;
    
    int drawRadius;
    enum drawguide _guideMode;
    
    CGPoint zigzags[50];
    CGPoint fireCircle;
    bool _playedDrag;
    int _coresCollected;
    int _coreCycles;
    float _speedMod;
    float _bulletSpeed;
    CGSize _screenSize;
    int _drawings;
    
    CGRect _battlefieldFrame;
    
    int zonesWide;
    int zonesTall;
    
    int lastScore;
    
    float drawX;
    float l1x;
    float l2x;
    float l1y;
    float l2y;

    int lXDirection;

    float l3x;
    float l4x;
    int l3y;
    int l4y;
    
    int l3h;
    
    float tl1x;
    float tl2x;
    float tl3x;
    
    int boostLevel;
    int laserLevel;
    
    bool drawUpgradeSidelines;
    bool drawTopSidelines;
}

@property (nonatomic, retain) NSMutableArray *bullets;
@property (nonatomic, retain) NSMutableArray *cloneBullets;
@property (nonatomic, retain) NSMutableArray *debris;
@property (nonatomic, retain) NSMutableArray *shieldDebris;
@property (nonatomic, retain) NSMutableArray *shatters;
@property (nonatomic, retain) QuantumPilot *pilot;
@property (nonatomic, assign) CCLayer *layer;

@property (nonatomic, retain) NSMutableArray *zones;
@property (nonatomic, retain) NSMutableArray *cloneZones;
#pragma mark Score

@property (nonatomic) NSInteger score;

#pragma mark States
@property (nonatomic, retain) QPBFState *currentState;
@property (nonatomic, retain) QPBFTitleState *titleState;
@property (nonatomic, retain) QPBFDrawingState *drawingState;
@property (nonatomic, retain) QPBFFightingState *fightingState;
@property (nonatomic, retain) QPBFPausedState *pausedState;

#pragma mark Pilot Positioning
@property (nonatomic, assign) CGPoint playerTouch;
@property (nonatomic, assign) CGPoint lastPlayerTouch;
@property (nonatomic, assign) CGPoint touchPlayerOffset;
@property (nonatomic, assign) CGPoint touchOffset;

@property (nonatomic, assign) CGPoint latestExpected;

#pragma mark Clones
@property (nonatomic, retain) NSMutableArray *clones;

#pragma mark Pulse

@property (nonatomic, assign) NSInteger time;

#pragma mark Deadline

@property (strong, nonatomic) DeadLine *dl;

@property (nonatomic, copy) NSString *nextWeapon;

@property (strong, nonatomic) NSArray *weapons;

@property (strong, nonatomic) QPScoreCycler *scoreCycler;

- (float)rhythmScale;
- (void)pulse;

+ (QPBattlefield *)f;

+ (float)rhythmScale;
+ (float)pulseRotation;
- (bool)isPulsing;

#pragma mark Input

- (void)addTouch:(CGPoint)l;
- (void)addDoubleTouch;
- (void)endTouch:(CGPoint)l;
- (void)moveTouch:(CGPoint)l;

#pragma mark Pilot Positioning

- (BOOL)touchingPlayer:(CGPoint)l;
- (void)changeState:(QPBFState *)state;
- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l;
- (CGPoint)playerTouchWithOffset;
- (void)setTouchOffsetFromPilotNear:(CGPoint)l;
- (void)setTouchOffsetFromLatestExpectedNear:(CGPoint)l;

#pragma mark Recycling

- (int)shieldCost;
- (int)warningCost;
- (int)slowCost;

- (bool)installShield;
- (bool)installWarning;
- (bool)installNextWeapon;
- (bool)installSlow;

- (bool)shieldMaxed;

- (float)bulletSpeed;

- (void)bulletsFired:(NSArray *)bullets li:(int)li;

#pragma mark Guide

- (void)playDragSound;
- (void)playTapSound;
- (void)playCopySound;

- (NSArray *)weapons;

- (float)speedMod;

#pragma mark State Control

- (void)resetGuideMode;
- (void)showCircleGuideMode;
- (void)restGuideMode;
- (void)resetFireCircle;
- (void)moveFireCircleOffscreen;
- (void)resetScoringTotals;

- (void)resetLineXDirection:(int)lxd;

- (bool)showSocial;
- (void)announceScores;

- (NSString *)shareText;

#pragma mark Upgrades

- (void)upgradeBoost:(UpgradeButton *)b;
- (void)upgradeLaser:(UpgradeButton *)b;
- (void)updateBoostLabel;
- (void)updateLaserLabel;

- (bool)finishedAnimatingSidelines;
- (float)topLineY;

@end
