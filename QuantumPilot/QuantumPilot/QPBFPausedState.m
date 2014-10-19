#import "QPBFPausedState.h"
#import "QPBattlefield.h"

@implementation QPBFPausedState

- (void)addTouch:(CGPoint)l {
    if ([self.f.pilot touchesPoint:l]) {
        [self.f changeState:self.f.drawingState];
        [self.f setTouchOffsetFromPilotNear:l];
        [self.f addTouch:l];
    } else {
        [self.f.pilot fire];
    }
}

- (void)moveTouch:(CGPoint)l {
    CGPoint lOffset = CombinedPoint(l, ccp(-self.f.touchOffset.x, self.f.touchOffset.y));
    if (lOffset.x < 5) {
        l = ccp(5, l.y);
    } else if (lOffset.x > 315) {
        l = ccp(315, l.y);
    }
    if (lOffset.y > 573) {
        l = ccp(l.x, 573);
    }
    
    self.f.playerTouch = l;
    
    [self.f changeState:self.f.drawingState withTouch:self.f.playerTouch];
}


@end
