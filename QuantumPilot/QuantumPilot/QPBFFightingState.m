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
//    <<IN PILOT>>
//    [self.f.freshClone addDeltas:self.f.pilot.vel firing:self.f.pilot.firing index:self.f.pilot.time];
   // <</IN PILOT>
}

- (void)postTick {
    self.f.pilot.firing = NO;
}

- (void)addTouch:(CGPoint)l {
    float distToPilot            = GetDistance(self.f.pilot.l, l);
    float distToLatestPathPoint   = GetDistance([self.f latestExpected], l);

    BOOL closeToPlayer      = distToPilot <= QPBF_PLAYER_TAP_RANGE;
    BOOL closeToPathPoint   = distToLatestPathPoint <= QPBF_PLAYER_TAP_RANGE;
    
    if (!closeToPlayer) {
        [self.f.pilot fire];
        return;
    }
    
//    if (self.f.time < QPBF_MAX_DRAWING_FRAMES) {
        if (closeToPlayer) {
            if (distToPilot <= distToLatestPathPoint) {
                _shiftingToDrawing = YES;
                _shiftToDrawingTouch = l;
                _interruptDrawingPath = YES;
                [self.f setTouchOffsetFromPilotNear:l];
            }
        } else {
            //[self.f setTouchOffsetFromLatestExpectedNear:l];
        }
//        if (closeToPlayer && distToPilot <= distToLatestPathPoint) {
//
//            [self.f setTouchOffsetFromLatestExpectedNear:l];
//        }
 //   }
}

@end
