#import "QPBFFightingState.h"
#import "QPBattlefield.h"

@implementation QPBFFightingState

- (void)shiftToDrawingState {
    _shiftingToDrawing = NO;
    [self.f changeState:self.f.drawingState withTouch:_shiftToDrawingTouch];
    if (_interruptDrawingPath) {
        [self.f resetIterations];
        _interruptDrawingPath = NO;
    } else {
        [self.f resetPassedIterations];
    }
}

- (void)tick {
    CGPoint deltaTarget = [self.f deltaPoint:self.f.fightingIteration];
    self.f.player.t = deltaTarget;
    if (GetDistance(self.f.player.l, self.f.player.t) < 2) {
        self.f.fightingIteration++;
    }
    
    if (self.f.time < QPBF_MAX_DRAWING_FRAMES && self.f.fightingIteration == self.f.drawingIteration) {
        [self.f changeState:self.f.pausedState];
        [self.f resetIterations];
    }
    
    if (_shiftingToDrawing) {
        [self shiftToDrawingState];
        return;
    }

    for (QuantumClone *c in self.f.clones) {
        [c tick];
    }
    
    if ([self.f livingClones] == 0) {
        [self.f changeState:[self.f cloningState]];
    }
    
    [self.f bulletLoop];
    
    [self.f.freshClone addDeltas:self.f.player.vel firing:self.f.pilot.firing index:self.f.time];
    
    self.f.time++;    
}

- (void)postTick {
    self.f.pilot.firing = NO;
}

- (void)addTouch:(CGPoint)l {
    float distToPlayer            = GetDistance(self.f.player.l, l);
    float distToLatestPathPoint   = GetDistance([self.f latestExpectedPathPoint], l);

    BOOL closeToPlayer      = distToPlayer <= QPBF_PLAYER_TAP_RANGE;
    BOOL closeToPathPoint   = distToLatestPathPoint <= QPBF_PLAYER_TAP_RANGE;
    
    if (!closeToPlayer && !closeToPathPoint) {
        [self.f pilotFires];
        return;
    }

    if (self.f.time < QPBF_MAX_DRAWING_FRAMES) {
    _shiftingToDrawing = YES;
    _shiftToDrawingTouch = l;

    if (closeToPlayer && distToPlayer <= distToLatestPathPoint) {
        _interruptDrawingPath = YES;
    }
}
}

@end
