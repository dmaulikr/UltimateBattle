#import "ClonePilotBattlefield.h"
#import "QPBFState.h"
#import "QPBFTitleState.h"
#import "QPBFDrawingState.h"
#import "QPBFInputConstants.h"
#import "QPBFPausedState.h"
#import "QPBFFightingState.h"

@interface QPBattlefield : ClonePilotBattlefield {
    float _xDelta[1000];
    float _yDelta[1000];
}

@property (nonatomic, retain) QPBFState *currentState;
@property (nonatomic, retain) QPBFTitleState *titleState;
@property (nonatomic, retain) QPBFDrawingState *drawingState;
@property (nonatomic, retain) QPBFPausedState *pausedState;
@property (nonatomic, retain) QPBFFightingState *fightingState;

@property (nonatomic, assign) CGPoint playerTouch;
@property (nonatomic, assign) CGPoint lastPlayerTouch;
@property (nonatomic, assign) CGPoint touchPlayerOffset;

@property (nonatomic, assign) NSInteger drawingIteration;
@property (nonatomic, assign) NSInteger fightingIteration;

- (float)xDelta:(NSInteger)index;
- (float)yDelta:(NSInteger)index;

- (void)addXDelta:(float)delta;
- (void)addYDelta:(float)delta;

- (BOOL)touchingPlayer:(CGPoint)l;
- (void)changeState:(QPBFState *)state;
- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l;

@end
