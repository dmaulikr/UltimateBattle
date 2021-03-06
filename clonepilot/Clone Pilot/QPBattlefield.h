#import "ClonePilotBattlefield.h"
#import "QPBFState.h"
#import "QPBFTitleState.h"
#import "QPBFDrawingState.h"
#import "QPBFInputConstants.h"
#import "QPBFPausedState.h"
#import "QPBFFightingState.h"
#import "QPBFCloningState.h"
#import "QPBFScoringState.h"
#import "QPBFWeaponSelectionState.h"
#import "QuantumPilot.h"
#import "QuantumClone.h"

@interface QPBattlefield : ClonePilotBattlefield {
    BOOL _fireDelta[4001];
    CGPoint _deltas[4001];
}

@property (nonatomic, retain) QPBFState                 *currentState;
@property (nonatomic, retain) QPBFTitleState            *titleState;
@property (nonatomic, retain) QPBFDrawingState          *drawingState;
@property (nonatomic, retain) QPBFPausedState           *pausedState;
@property (nonatomic, retain) QPBFFightingState         *fightingState;
@property (nonatomic, retain) QPBFCloningState          *cloningState;
@property (nonatomic, retain) QPBFScoringState          *scoringState;
@property (nonatomic, retain) QPBFWeaponSelectionState  *weaponSelectionState;

@property (nonatomic, assign) NSInteger drawFrame;

@property (nonatomic, assign) CGPoint playerTouch;
@property (nonatomic, assign) CGPoint lastPlayerTouch;
@property (nonatomic, assign) CGPoint touchPlayerOffset;

@property (nonatomic, assign) float latestExpectedX;
@property (nonatomic, assign) float latestExpectedY;

@property (nonatomic, assign) NSInteger drawingIteration;
@property (nonatomic, assign) NSInteger fightingIteration;

@property (nonatomic, assign) NSInteger pauses;
@property (nonatomic, retain) QuantumClone *freshClone;

- (BOOL)fireDeltaAtIndex:(NSInteger)index;

- (CGPoint)latestExpectedPathPoint;

- (void)clearAllDeltas;

- (BOOL)touchingPlayer:(CGPoint)l;
- (void)changeState:(QPBFState *)state;
- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l;

- (void)pilotFires;

- (QuantumPilot *)pilot;
- (QuantumClone *)newestClone;

- (CGPoint)deltaPoint:(NSInteger)index;
- (void)addDelta:(CGPoint)l;
- (void)setDeltaPoint:(CGPoint)delta index:(NSInteger)index;

- (void)resetIterations;
- (void)resetPassedIterations;

- (void)activateFreshClone;

- (void)storeHistory;

@end
