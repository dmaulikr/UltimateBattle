#import "QPBFCloningState.h"
#import "QPBattlefield.h"

@implementation QPBFCloningState

- (void)tick {
    [self.f activateFreshClone];
    [self.f resetBattlefield];
    [self.f changeState:self.f.scoringState];
}

@end
