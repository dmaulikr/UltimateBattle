#import "QPBFFightingState.h"
#import "QPBattlefield.h"

@implementation QPBFFightingState

- (void)shiftToDrawingState {
    _shiftingToDrawing = NO;
    [self.f changeState:self.f.drawingState withTouch:_shiftToDrawingTouch];
    if (_interruptDrawingPath) {
        [self.f resetDrawingIterationToFighting];
        _interruptDrawingPath = NO;
    }
}

- (void)tick {
//    CGPoint deltaTarget = ccp(self.f.player.l.x + [self.f xDelta:self.f.fightingIteration],
//                              self.f.player.l.y + [self.f yDelta:self.f.fightingIteration]);
    CGPoint deltaTarget = [self.f deltaPoint:self.f.fightingIteration];
    //ccp([self.f xDelta:self.f.fightingIteration], [self.f yDelta:self.f.fightingIteration]);
    self.f.player.t = deltaTarget;
    if (GetDistance(self.f.player.l, self.f.player.t) < 2) {
        self.f.fightingIteration++;
    }
    
    if (self.f.fightingIteration == self.f.drawingIteration) {
        [self.f changeState:self.f.pausedState];
    }
    
    if (_shiftingToDrawing) {
        [self shiftToDrawingState];
        return;
    }
    
    if ([self.f livingClones] == 0) {
        [self.f changeState:[self.f cloningState]];
    }
    
    [self.f bulletLoop];
    
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

    _shiftingToDrawing = YES;
    _shiftToDrawingTouch = l;

    if (closeToPlayer && distToPlayer <= distToLatestPathPoint) {
        _interruptDrawingPath = YES;
    }
}

@end
