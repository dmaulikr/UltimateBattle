#import "ClonePilotBattlefield.h"
#import "QPBFState.h"
#import "QPBFTitleState.h"
#import "QPBFDrawingState.h"
#import "QPBFInputConstants.h"
#import "QPBFPausedState.h"
#import "QPBFFightingState.h"
#import "QPBFCloningState.h"
#import "QPBFScoringState.h"
#import "QuantumPilot.h"

@interface QPBattlefield : ClonePilotBattlefield {
    float _xDelta[4001];
    float _yDelta[4001];
    BOOL _fireDelta[4001];
}

@property (nonatomic, retain) QPBFState         *currentState;
@property (nonatomic, retain) QPBFTitleState    *titleState;
@property (nonatomic, retain) QPBFDrawingState  *drawingState;
@property (nonatomic, retain) QPBFPausedState   *pausedState;
@property (nonatomic, retain) QPBFFightingState *fightingState;
@property (nonatomic, retain) QPBFCloningState  *cloningState;
@property (nonatomic, retain) QPBFScoringState  *scoringState;

@property (nonatomic, assign) CGPoint playerTouch;
@property (nonatomic, assign) CGPoint lastPlayerTouch;
@property (nonatomic, assign) CGPoint touchPlayerOffset;

@property (nonatomic, assign) float latestExpectedX;
@property (nonatomic, assign) float latestExpectedY;

@property (nonatomic, assign) NSInteger drawingIteration;
@property (nonatomic, assign) NSInteger fightingIteration;

@property (nonatomic, assign) NSInteger pauses;

- (float)xDelta:(NSInteger)index;
- (float)yDelta:(NSInteger)index;
- (BOOL)fireDeltaAtIndex:(NSInteger)index;

- (void)addXDelta:(float)delta;
- (void)addYDelta:(float)delta;

- (void)setXDelta:(float)delta atIndex:(NSInteger)index;
- (void)setYDelta:(float)delta atIndex:(NSInteger)index;

- (CGPoint)latestExpectedPathPoint;

- (void)resetDrawingIterationToFighting;
- (void)clearAllDeltas;

- (BOOL)touchingPlayer:(CGPoint)l;
- (void)changeState:(QPBFState *)state;
- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l;

- (void)pilotFires;

- (QuantumPilot *)pilot;

@end
