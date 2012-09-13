#import "ClonePilotBattlefield.h"
#import "QPBFState.h"
#import "QPBFTitleState.h"
#import "QPBFDrawingState.h"
#import "QPBFInputConstants.h"
#import "QPBFPausedState.h"

@interface QPBattlefield : ClonePilotBattlefield

@property (nonatomic, retain) QPBFState *currentState;
@property (nonatomic, retain) QPBFTitleState *titleState;
@property (nonatomic, retain) QPBFDrawingState *drawingState;
@property (nonatomic, retain) QPBFPausedState *pausedState;

@property (nonatomic, assign) CGPoint touchPlayerOffset;

- (void)changeState:(QPBFState *)state;
- (void)changeState:(QPBFState *)state withTouch:(CGPoint)l;

@end
