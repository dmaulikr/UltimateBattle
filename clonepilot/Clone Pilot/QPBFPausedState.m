#import "QPBFPausedState.h"
#import "QPBattlefield.h"

@implementation QPBFPausedState

- (void)tick {
    if (self.f.fightingIteration == 0) {
        return;
    }
    
    [self.f clearUsedDeltas];
}

- (void)addTouch:(CGPoint)l {
    if ([self.f touchingPlayer:l]) {
        [self.f changeState:self.f.drawingState];
        [self.f addTouch:l];
    }
}

@end
