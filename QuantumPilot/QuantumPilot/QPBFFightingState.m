#import "QPBFFightingState.h"
#import "QPBattlefield.h"

@implementation QPBFFightingState

- (void)shiftToDrawingState {
    _held = 0;
    _holding = false;
    
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
    
    [self.f playTapSound];
    
    if (_holding) {
        _held++;
    }
//        if (_held > 10) {
//            _interruptDrawingPath = true;
//            _shiftToDrawingTouch = _touch;
//            _shiftingToDrawing = true;
//        }
}

- (void)postTick {
    self.f.pilot.firing = NO;
}

- (void)addTouch:(CGPoint)l {
    _holding = true;
    _touch = l;
    _oldPilotLocation = self.f.pilot.l;
//    float distToPilot            = GetDistance(self.f.pilot.l, l);
//    float distToLatestPathPoint   = GetDistance([self.f latestExpected], l);
//    
//    BOOL closeToPlayer      = distToPilot <= QPBF_PLAYER_TAP_RANGE;
//    
//    if (closeToPlayer) {
//        if (distToPilot <= distToLatestPathPoint) {
//            _shiftingToDrawing = YES;
//            _shiftToDrawingTouch = l;
//            _interruptDrawingPath = YES;
//            [self.f setTouchOffsetFromPilotNear:l];
//        }
//    } else {
//        [self.f.pilot fire];
//    }
}

- (bool)touchDownWasCloseToPilot {
    return GetDistance(_touch, _oldPilotLocation) < 80;
}

- (bool)touchMovedAwayFromTouchDown:(CGPoint)l {
    return GetDistance(l, _touch) >= 10;
}

- (void)moveTouch:(CGPoint)l {
    if ([self touchDownWasCloseToPilot] && [self touchMovedAwayFromTouchDown:l]) {
        _interruptDrawingPath = true;
        _shiftToDrawingTouch = l;
        [self shiftToDrawingState];
        [self.f setTouchOffsetFromPilotNear:l];
    }
}

- (void)endTouch:(CGPoint)l {
    bool fire = _holding && _held < 10;

    if (fire) {
        [self.f.pilot fire];
    }
    
    _held = 0;
    _holding = false;
}

- (void)addDoubleTouch {
//    [self.f.pilot fire];
}

- (bool)isShieldDebrisPulsing {
    return true;
}


@end
