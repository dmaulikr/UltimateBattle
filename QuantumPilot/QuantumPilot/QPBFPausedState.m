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

@end
