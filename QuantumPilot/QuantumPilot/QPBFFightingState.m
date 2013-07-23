#import "QPBFFightingState.h"
#import "QPBattlefield.h"

@implementation QPBFFightingState

- (void)shiftToDrawingState {
    _shiftingToDrawing = NO;
    [self.f changeState:self.f.drawingState withTouch:_shiftToDrawingTouch];
    if (_interruptDrawingPath) {
        [self.f.pilot resetIterations];
        _interruptDrawingPath = NO;
    }
}

- (BOOL)isPulsing {
    return YES;
}

- (int)pulsesHeldBeforeMoving {
    return 10;
}

- (void)pulse {
    if (_shiftingToDrawing) {
        [self shiftToDrawingState];
        return;
    }

    for (QuantumClone *c in self.f.clones) {
        [c pulse];
    }
}

- (void)postTick {
    self.f.pilot.firing = NO;
}

- (void)addTouch:(CGPoint)l {
    float distToPilot            = GetDistance(self.f.pilot.l, l);
    float distToLatestPathPoint   = GetDistance([self.f latestExpected], l);
    
    BOOL closeToPlayer      = distToPilot <= QPBF_PLAYER_TAP_RANGE;
    
    if (closeToPlayer) {
        if (distToPilot <= distToLatestPathPoint) {
            _shiftingToDrawing = YES;
            _shiftToDrawingTouch = l;
            _interruptDrawingPath = YES;
            [self.f setTouchOffsetFromPilotNear:l];
        }
    } else {
        [self.f.pilot fire];
    }
}

- (void)addDoubleTouch {
//    [self.f.pilot fire];
}

@end
