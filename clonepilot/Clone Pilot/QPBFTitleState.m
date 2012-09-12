#import "QPBFTitleState.h"
#import "QPBattlefield.h"

@implementation QPBFTitleState

- (void)addTouch:(CGPoint)l {
    if (GetDistance(l, self.f.player.l) <= QPBF_PLAYER_TAP_RANGE) {
        [self.f changeState:self.f.drawingState withTouch:l];
    }
}

@end
