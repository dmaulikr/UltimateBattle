#import "QPBFPausedState.h"
#import "QPBattlefield.h"

@implementation QPBFPausedState

- (void)activate:(NSDictionary *)options {
    [super activate:options];
    [self.f resetLineXDirection:1];
    [self.f updateBoostLabel];
    [self.f updateLaserLabel];
}

- (void)resetFireCircle {
    [self.f resetFireCircle];
    [self.f showCircleGuideMode];
}

- (void)addTouch:(CGPoint)l {
    if ([self.f.pilot touchesPoint:l]) {
        [self.f changeState:self.f.drawingState];
        [self.f setTouchOffsetFromPilotNear:l];
        [self.f addTouch:l];
        [self.f resetGuideMode];
        [self.f resetLineXDirection:-1];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clearLabels" object:nil];
        [self.f.pilot fire];
        [self.f.pilot resetFuture];
        [self.f changeState:self.f.fightingState withTouch:l];
        [self.f resetLineXDirection:-1];
    }
    

    [[NSNotificationCenter defaultCenter] postNotificationName:@"SpeedLabel" object:@""];
}

@end
