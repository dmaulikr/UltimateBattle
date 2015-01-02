#import "QPBFPausedState.h"
#import "QPBattlefield.h"

@implementation QPBFPausedState

- (void)resetFireCircle {
    [self.f resetFireCircle];
    [self.f showCircleGuideMode];
}

- (void)addTouch:(CGPoint)l {
    if ([self.f.pilot touchesPoint:l]) {
        [self.f changeState:self.f.drawingState];
        [self.f setTouchOffsetFromPilotNear:l];
        [self.f addTouch:l];
    } else {
        [self.f.pilot fire];
        [self.f.pilot resetFuture];
        [self.f changeState:self.f.fightingState withTouch:l];
    }
    
    if ([self.f touchingPlayer:l]) {
        [self.f restGuideMode];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeedLabel" object:@""];
}

@end
