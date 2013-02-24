#import "QPBFPausedState.h"
#import "QPBattlefield.h"

@implementation QPBFPausedState

- (void)addTouch:(CGPoint)l {
    if ([self.f.pilot touchesPoint:l]) {
        [self.f changeState:self.f.drawingState];
        [self.f setTouchOffsetFromPilotNear:l];
        [self.f addTouch:l];
    }
}

- (void)addDoubleTouch {
    [self.f changeState:self.f.drawingState];
    [self.f setTouchOffsetFromPilotNear:self.f.pilot.l];
    [self.f addTouch:self.f.pilot.l];
    [self.f pulse];
    [self.f changeState:self.f.fightingState];
    [self.f.pilot fire];
}

@end
