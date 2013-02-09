#import "QPBFFightingState.h"
#import "QPBattlefield.h"

@implementation QPBFFightingState

- (void)shiftToDrawingState {
    _shiftingToDrawing = NO;
    [self.f changeState:self.f.drawingState withTouch:_shiftToDrawingTouch];
    if (_interruptDrawingPath) {
        [self.f.pilot resetIterations];
        _interruptDrawingPath = NO;
    } else {
//        [self.f resetPassedIterations];
    }
}

- (BOOL)isPulsing {
    return YES;
}

- (void)pulse {
    if (_shiftingToDrawing) {
        [self shiftToDrawingState];
        return;
    }

    for (QuantumClone *c in self.f.clones) {
        [c pulse];
    }
    
//    if ([self.f livingClones] == 0) {
//        [self.f changeState:[self.f cloningState]];
//    }
//
//    
//    [self.f.freshClone addDeltas:self.f.player.vel firing:self.f.pilot.firing index:self.f.time];
    
    self.f.time++;    
}

- (void)postTick {
    self.f.pilot.firing = NO;
}

- (void)addTouch:(CGPoint)l {
    float distToPilot            = GetDistance(self.f.pilot.l, l);
    float distToLatestPathPoint   = GetDistance([self.f latestExpected], l);

    BOOL closeToPlayer      = distToPilot <= QPBF_PLAYER_TAP_RANGE;
    BOOL closeToPathPoint   = distToLatestPathPoint <= QPBF_PLAYER_TAP_RANGE;
    
    if (!closeToPlayer && !closeToPathPoint) {
//        [self.f pilotFires];
        return;
    }

    if (self.f.time < QPBF_MAX_DRAWING_FRAMES) {
    _shiftingToDrawing = YES;
    _shiftToDrawingTouch = l;

    if (closeToPlayer && distToPilot <= distToLatestPathPoint) {
        _interruptDrawingPath = YES;
    }
}
}

@end
