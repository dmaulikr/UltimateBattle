#import "cocos2d.h"
#import "QuantumPilot.h"
#import "QPBFState.h"
#import "QPBFTitleState.h"
#import "QPBFDrawingState.h"
#import "QPBFFightingState.h"
#import "QPBFPausedState.h"
#import "QPBFScoreState.h"
#import "QPBFRecycleState.h"
#import "DeadLine.h"
#import "ShieldDebris.h"

#define QPBF_MAX_DRAWING_FRAMES 4550

enum pulsestate {
    resting = 0,
    charging = 1,
    holding = 2,
    falling = 3
};

@interface QPBattlefield : CCNode <QuantumPilotingDelegate, QPBulletDelegate> {
    NSInteger _pulseTimes[4];
    NSInteger _pulseState;
    NSInteger _pulseDirection;
    NSInteger _pulseCharge;
    float _rhythmScale;
    float _breaths;
    float _breathCycle;
    NSInteger _breathFlow;
    
    int _circleCharges;
    
    CGPoint _deltas[4551];
    
    int shotsFired;
    int hits;
    int paths;
    int level;
    int installLevel;
    int weaponLevel; //move to upgrade class?
    int shield;
    int warning;
    int slow;
    
    int debrisShow;
    
    int titleY;
    int titleDelay;
    bool titleSlide;
    
    bool veteran;
}

@property (nonatomic, retain) NSMutableArray *bullets;
@property (nonatomic, retain) NSMutableArray *cloneBullets;
@property (nonatomic, retain) NSMutableArray *debris;
@property (nonatomic, retain) NSMutableArray *shieldDebris;
@property (nonatomic, retain) NSMutableArray *shatters;
@property (nonatomic, retain) QuantumPilot *pilot;
@property (nonatomic, assign) CCLayer *layer;

#pragma mark Score

@property (nonatomic) int score;

#pragma mark States
@property (nonatomic, retain) QPBFState *currentState;
@property (nonatomic, retain) QPBFTitleState *titleState;
@property (nonatomic, retain) QPBFDrawingState *drawingState;
@property (nonatomic, retain) QPBFFightingState *fightingState;
@property (nonatomic, retain) QPBFPausedState *pausedState;
@property (nonatomic, retain) QPBFScoreState *scoreState;
@property (nonatomic, retain) QPBFRecycleState *recycleState;

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
- (void)finishedDisplayingScore:(CGPoint)l rush:(bool)rush;

- (bool)shieldMaxed;

- (float)bulletSpeed;

#pragma mark Pilot effects

- (void)registerShieldHit:(QuantumPilot *)p;

- (NSArray *)weapons;

@end
