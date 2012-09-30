#import "QPBFFightingState.h"
#import "QPBattlefield.h"

@implementation QPBFFightingState

- (void)shiftToDrawingState {
    [self.f clearUsedDeltas];
    _shiftingToDrawing = NO;
    [self.f changeState:self.f.drawingState withTouch:_shiftToDrawingTouch];
}

- (void)tick {
    CGPoint deltaTarget = ccp(self.f.player.l.x + [self.f xDelta:self.f.fightingIteration],
                              self.f.player.l.y + [self.f yDelta:self.f.fightingIteration]);
    self.f.player.t = deltaTarget;
    self.f.fightingIteration++;    
    
    if (self.f.fightingIteration == self.f.drawingIteration) {
        [self.f changeState:self.f.pausedState];
    }
    
    if (_shiftingToDrawing) {
        [self shiftToDrawingState];
    }
}

- (void)addTouch:(CGPoint)l {
    _shiftingToDrawing = YES;
    _shiftToDrawingTouch = l;
}

@end
