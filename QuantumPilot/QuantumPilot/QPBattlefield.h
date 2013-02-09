#import "cocos2d.h"
#import "QuantumPilot.h"
#import "QPBFState.h"
#import "QPBFTitleState.h"
#import "QPBFDrawingState.h"
#import "QPBFFightingState.h"

#define QPBF_MAX_DRAWING_FRAMES 4000

enum pulsestate {
    resting = 0,
    charging = 1,
    holding = 2,
    falling = 3
};

@interface QPBattlefield : CCNode <QuantumPilotingDelegate> {
    NSInteger _pulseTimes[4];
    NSInteger _pulseState;
    NSInteger _pulseDirection;
    NSInteger _pulseCharge;
    float _rhythmScale;
    float _breaths;
    float _breathCycle;
    NSInteger _breathFlow;
    
    CGPoint _deltas[4001];
}

@property (nonatomic, retain) NSMutableArray *bullets;
@property (nonatomic, retain) QuantumPilot *pilot;
@property (nonatomic, assign) CCLayer *layer;

#pragma mark States
@property (nonatomic, retain) QPBFState *currentState;
@property (nonatomic, retain) QPBFTitleState *titleState;
@property (nonatomic, retain) QPBFDrawingState *drawingState;
@property (nonatomic, retain) QPBFFightingState *fightingState;

//@property (nonatomic, assign) NSInteger drawingIteration;
//@property (nonatomic, assign) NSInteger fightingIteration;

#pragma mark Pilot Positioning
@property (nonatomic, assign) CGPoint playerTouch;
@property (nonatomic, assign) CGPoint lastPlayerTouch;
@property (nonatomic, assign) CGPoint touchPlayerOffset;

@property (nonatomic, assign) CGPoint latestExpected;

#pragma mark Clones
@property (nonatomic, retain) NSMutableArray *clones;

#pragma mark Pulse

@property (nonatomic, assign) NSInteger time;

- (float)rhythmScale;
- (void)pulse;

+ (QPBattlefield *)f;

+ (float)rhythmScale;
+ (float)pulseRotation;

#pragma mark Input

- (void)addTouch:(CGPoint)l;
- (void)endTouch:(CGPoint)l;
- (void)moveTouch:(CGPoint)l;

#pragma mark Pilot Positioning

- (BOOL)touchingPlayer:(CGPoint)l;

- (void)changeState:(QPBFState *)state;
- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l;

#pragma mark deltas

- (CGPoint)deltaPoint:(NSInteger)index;

@end
